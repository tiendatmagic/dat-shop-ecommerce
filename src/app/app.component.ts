import { Component } from '@angular/core';
import { initFlowbite } from 'flowbite';
import { TranslateService } from '@ngx-translate/core';
import { DataService } from './services/data.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  standalone: false,
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'dat_shop';
  cartItems: any[] = [];

  constructor(public translate: TranslateService, private dataService: DataService) { }
  ngOnInit(): void {
    var lang = localStorage.getItem('event-ticket-lang');

    if (lang) {
      this.translate.use(lang);
    }
    else {
      this.translate.use('vi');
    }

    var getCartItems = localStorage.getItem('cartItems');

    if (getCartItems) {
      try {
        this.cartItems = JSON.parse(getCartItems);
      } catch (error) {
        this.cartItems = [];
      }
    }
    this.dataService.cartCount = this.cartItems.length;
    initFlowbite();
  }
}
