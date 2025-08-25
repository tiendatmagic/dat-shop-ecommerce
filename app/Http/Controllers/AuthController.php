<?php

namespace App\Http\Controllers;

use App\Models\LoginHistory;
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
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized',
            ], 401);
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
        return $data;
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
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

            if (!$user) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Unauthorized',
                ], 401);
            }
            $token = auth('api')->login($user);

            $newRefreshToken = $this->createRefreshToken();

            return $this->respondWithToken($token, $newRefreshToken, $refreshToken, request());
        } catch (\Throwable $th) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized',
            ], 401);
        }
    }

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

    public function changePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'password' => 'required|min:8|max:200',
            'newPassword' => 'required|min:8|max:200',
        ]);


        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
                'status' => 'error'
            ], 200);
        }

        $user = $request->user();
        if (!$user || !password_verify($request->password, $user->password)) {
            return response()->json([
                'message' => 'Current password is incorrect',
                'status' => 'error'
            ], 200);
        }

        $user->update([
            'password' => password_hash($request->newPassword, PASSWORD_DEFAULT)
        ]);

        return response()->json([
            'message' => 'Password changed successfully',
            'status' => 'success'
        ], 200);
    }
}
