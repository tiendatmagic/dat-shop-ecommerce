import { Component } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute, Router } from '@angular/router';
import { DataService } from '../../services/data.service';

@Component({
  selector: 'app-place-order',
  standalone: false,
  templateUrl: './place-order.component.html',
  styleUrl: './place-order.component.scss'
})

export class PlaceOrderComponent {
  choosePaymentMethod: number = 1;
  cartProducts: any[] = [];
  subtotal: number = 0;
  deliveryFee: number = 5;
  total: number = 0;
  public id: any;
  name: string = '';
  email: string = '';
  address: string = '';
  phone: string = '';
  note: string = '';

  constructor(private snackBar: MatSnackBar, private route: ActivatedRoute, private router: Router, private dataService: DataService) { }

  ngOnInit() {
    this.id = this.route.snapshot.paramMap.get('id');
    if (!this.id) {
      const storedCart = localStorage.getItem('cartItems');
      this.cartProducts = storedCart ? JSON.parse(storedCart) : [];
      if (!this.cartProducts.length) {
        this.router.navigate(['/cart']);
      }
      this.calculateTotal();
    }
  }

  calculateTotal() {
    this.subtotal = this.cartProducts.reduce((sum, item) => {
      return sum + item.price * item.quantity;
    }, 0);
    this.total = this.subtotal + this.deliveryFee;
  }

  choosePayment(payment: number) {
    this.choosePaymentMethod = payment;
  }

  proceedToPayment() {
    const orderData = {
      name: this.name,
      email: this.email,
      address: this.address,
      phone: this.phone,
      note: this.note,
      paymentMethod: this.choosePaymentMethod === 1 ? 'Cash on delivery' : 'USDT',
      cart: this.cartProducts,
      subtotal: this.subtotal,
      deliveryFee: this.deliveryFee,
      total: this.total
    };

    if (!orderData.name || !orderData.email || !orderData.address || !orderData.phone) {
      this.snackBar.open('Please fill in all the required fields.', 'OK', {
        duration: 3000,
        horizontalPosition: 'right',
        verticalPosition: 'bottom',
      })
      return;
    }
    this.router.navigate(['/checkout', 123]);

    this.cartProducts = [];
    this.dataService.cartCount = this.cartProducts.length;
    localStorage.removeItem('cartItems');
  }

  viewOrder() {
    this.router.navigate(['/order', this.id]);
  }
}

