import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Title } from '@angular/platform-browser';
import { debounceTime, distinctUntilChanged } from 'rxjs';
import { DataService } from '../../services/data.service';

@Component({
  selector: 'app-register',
  standalone: false,
  templateUrl: './register.component.html',
  styleUrl: './register.component.scss'
})
export class RegisterComponent {
  email: FormControl;
  password: FormControl;
  confirmPassword: FormControl;
  registerForm: FormGroup;
  emailExists: boolean = false;
  isShow: boolean = false;
  isShowConfirm: boolean = false;
  constructor(_fb: FormBuilder, private router: Router, private route: ActivatedRoute, private dataService: DataService) {
    this.email = new FormControl('', [
      Validators.required, Validators.email
    ]);
    this.password = new FormControl('', [
      Validators.required
    ]);
    this.confirmPassword = new FormControl('', [
      Validators.required
    ]);
    this.registerForm = _fb.group({
      email: this.email,
      password: this.password,
      confirmPassword: this.confirmPassword
    });
  }

  ngOnInit() {
    var token = localStorage.getItem('mmo-token');
    if (token) {
      // this.auth.isGetMe = false;
      // this.auth.onMe({}).subscribe((res: any) => {
      //   localStorage.setItem('mmo-profile', JSON.stringify(res));
      //   this.auth.isLogin = true;
      //   this.router.navigate(['/home']);
      // },
      //   (error: any) => {
      //     this.auth.isLogin = false;
      //   }
      // );
    }


    this.email.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged()
    ).subscribe((value) => {

      this.checkUserNameExists(value);
    });
  }

  checkUserNameExists(event: string) {
    if (this.registerForm.controls['email']?.valid) {
      // this.auth.onCheckEmailExists({ email: event }).subscribe(res => {
      //   if (res == 'false') {
      //     this.emailExists = false;
      //   }
      //   else {
      //     this.emailExists = true;
      //   }
      // },
      // );
    }
  }

  onRegister() {
    if (this.registerForm.value.password == this.registerForm.value.confirmPassword) {
      var data: any = {
        'email': this.registerForm.value.email,
        'password': this.registerForm.value.password,
        // 'refCode': this.refCode
      };
      console.log(data);
      // this.registerForm.disable();

      // this.auth.onRegister(data).subscribe((res: any) => {
      //   localStorage.setItem('mmo-token', res.access_token);
      //   localStorage.setItem('mmo-renew', res.refresh_token);
      //   this.auth.getToken = res.access_token;
      //   this.router.navigate(['/home']);
      //   this.auth.isLogin = true;
      //   this.auth.onLoad = true;
      //   this.registerForm.enable();
      // },

      //   (error: any) => {
      //     this.auth.isLogin = false;
      //     this.registerForm.enable();
      //     this.dataService.showNotify('error', 'Lỗi đăng ký', 'Đăng ký thất bại, hãy kiểm tra lại thông tin');
      //   }
      // );

    }
  }
}
