import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { DataService } from '../../services/data.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  standalone: false,
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss'
})
export class LoginComponent {
  email: FormControl;
  password: FormControl;
  loginForm: FormGroup;
  isShow: boolean = false;
  isLoading: boolean = false;

  constructor(_fb: FormBuilder, private dataService: DataService, private router: Router) {
    this.email = new FormControl('', [
      Validators.required, Validators.email
    ]);
    this.password = new FormControl('', [
      Validators.required
    ]);
    this.loginForm = _fb.group({
      email: this.email,
      password: this.password,
    });
  }

  onLogin() {
    this.loginForm.markAllAsTouched();
    if (this.loginForm.valid) {
      var data: any = {
        'email': this.loginForm.value.email,
        'password': this.loginForm.value.password
      };

      console.log(data);
      // this.isLoading = this.auth.isLoading;
      this.loginForm.disable();

      /*
      this.auth.onLogin(data).subscribe((res: any) => {
        if (res.requires_2fa) {
          localStorage.setItem('email', this.loginForm.value.email);
          this.router.navigate(['/verify-2fa']);
          return;
        }
        localStorage.setItem('mmo-token', res.access_token);
        localStorage.setItem('mmo-renew', res.refresh_token);
        this.router.navigate(['/home']);
        this.auth.getToken = res.access_token;
        this.auth.isLogin = true;
        this.isLoading = this.auth.isLoading;
        localStorage.setItem('mmo-profile', JSON.stringify(res['information']));
        this.auth.accountData = {
          'amount': res['information']['amount'],
          'ref_code': res['information']['ref_code'],
          'avatar_url': res['information']['avatar_url'],
          'is_admin': res['information']['is_admin'],
        };
        this.loginForm.enable();
      },

        (error: any) => {
          // this.auth.isLogin = false;
          // this.isLoading = this.auth.isLoading;
          this.loginForm.enable();
          if (error.error.message == 'Unauthorized') {
            this.dataService.showNotify('error', 'Lỗi đăng nhập', 'Đăng nhập thất bại, hãy kiểm tra lại thông tin');
          }
        }
      );
    }
*/


    }
  }
}