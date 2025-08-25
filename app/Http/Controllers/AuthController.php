<?php

namespace App\Http\Controllers;

use App\Models\TwoFactorUsers;
use App\Models\User;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Carbon\Carbon;
use GuzzleHttp\Client;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Artisan;
use PragmaRX\Google2FA\Google2FA;
use Illuminate\Support\Facades\Crypt;
use Defuse\Crypto\Crypto;
use Defuse\Crypto\Key;
use Illuminate\Routing\Controller as BaseController;
use App\Traits\Sharable;
use Illuminate\Auth\Events\Login;
use PhpParser\Node\Stmt\TryCatch;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests, Sharable;

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'refresh']]);
    }

    public function systemSetting(Request $request)
    {
        $name = $request->name;

        switch ($name) {
            case 'app-key':
                Artisan::call('config:cache');
                Artisan::call('key:generate');
                break;
            case 'jwt-token':
                Artisan::call('config:cache');
                Artisan::call('jwt:secret --force');
                break;
            case 'clear-all-cache':
                Artisan::call('cache:clear');
                break;
            case 'clear-web-compiled':
                Artisan::call('view:cache');
                break;
            case 'clear-config':
                Artisan::call('config:cache');
                break;
            case 'clear-routing':
                Artisan::call('route:cache');
                break;
            case 'clear-log':
                file_put_contents(storage_path('logs/laravel.log'), '');
                break;
            case 'clear-all':
                Artisan::call('key:generate');
                Artisan::call('cache:clear');
                Artisan::call('view:cache');
                Artisan::call('route:cache');
                file_put_contents(storage_path('logs/laravel.log'), '');
                Artisan::call('jwt:secret --force');
                Artisan::call('config:cache');
                break;
            default:
                break;
        }
        return true;
    }

    public function login(Request $request)
    {
        $credentials = request(['email', 'password']);
        if (strlen($request->password) >= 8) {
            if (!$token = auth('api')->attempt($credentials)) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Unauthorized',
                ], 401);
            }

            $user = auth('api')->user();

            // Kiểm tra nếu tài khoản có bật 2FA
            if ($user->two_factor_secret) {
                return response()->json([
                    'requires_2fa' => true,
                    'message' => '2FA required'
                ], 200);
            }

            $newRefreshToken = $this->createRefreshToken();
            return $this->respondWithToken($token, $newRefreshToken, null, request());
        }
    }

    public function createRefreshToken()
    {
        $data = [
            'user_id' => auth('api')->user()->id,
            'random' => rand() . time(),
            'exp' => time() + config('jwt.refresh_ttl')
        ];

        $refreshToken = JWTAuth::getJWTProvider()->encode($data);
        return $refreshToken;
    }

    public function me(Request $request)
    {
        $data = response()->json(auth('api')->user())->getData();
        // $appVersion = Settings::where('key', 'version')->first();
        $arr = [];

        // foreach ($data as $key => $value) {
        //     $arr[$key] = $value;
        //     $arr['level'] = $this->calcLevel($data->exp);
        //     $arr['app_version'] = $appVersion->value;
        // }
        return $data;
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        $refreshToken = request()->refresh_token;

        auth('api')->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        $refreshToken = request()->refresh_token;
        try {
            $decoded = JWTAuth::getJWTProvider()->decode($refreshToken);
            $user = User::find($decoded['user_id']);
            if (Cache::has("blacklist:{$refreshToken}")) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Unauthorized',
                ], 401);
            } else {
                if (!$user) {
                    return response()->json([
                        'status' => 'error',
                        'message' => 'Unauthorized',
                    ], 401);
                }

                $token = auth('api')->login($user);
                $newRefreshToken = $this->createRefreshToken();

                return $this->respondWithToken($token, $newRefreshToken, $refreshToken, request());
            }
        } catch (\Throwable $th) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized',
            ], 401);
        }
    }

    public function changePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'password' => 'required|min:8|max:200',
            'newPassword' => 'required|min:8|max:200',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'error' => 'can_not_save_password',
                'messages' => $validator->errors()
            ], 400);
        }

        $user = $request->user();
        $getUserPassword = $user->password;

        if (!password_verify($request->password, $getUserPassword)) {
            return response()->json(['error' => 'password_does_not_match'], 400);
        }

        $user->update([
            'password' => password_hash($request->newPassword, PASSWORD_DEFAULT)
        ]);

        return response()->json(['success' => 'password_changed'], 200);
    }

    public function updateProfile(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'full_name' => 'required|string|min:2|max:30',
            'address' => 'required|string|min:1|max:255',
            'email' => 'required|email',
            'phone' => 'required|string|min:10|max:12',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'invalid_input', 'messages' => $validator->errors()], 422);
        }

        User::where('id', $request->user()->id)->update([
            'full_name' => $request->full_name,
            'address' => $request->address,
            'email' => $request->email,
            'phone' => $request->phone
        ]);

        $getProfile = User::where('id', $request->user()->id)->first();

        return response()->json([
            'success' => 'profile_updated',
            'data' => $getProfile
        ], 200);
    }


    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */

    public function respondWithToken($token, $newRefreshToken, $refreshToken = null, Request $request)
    {
        return response()->json([
            'access_token' => $token,
            'refresh_token' => $newRefreshToken,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60,
            'information' =>  response()->json(auth('api')->user())->getData()
        ]);
    }
}
