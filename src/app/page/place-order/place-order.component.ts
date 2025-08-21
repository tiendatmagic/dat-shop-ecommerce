import { Component } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute, Router } from '@angular/router';
import { DataService } from '../../services/data.service';
import { Web3Service } from '../../services/web3.service';
import { combineLatest } from 'rxjs';

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
  deliveryFee: number = 0;
  total: number = 0;
  public id: any;
  name: string = '';
  email: string = '';
  address: string = '';
  phone: string = '';
  note: string = '';

  account: string = '';
  balance: any;
  USDTBalance: any;
  nativeSymbol: string = '';
  isConnected: boolean = false;
  selectedNetwork: string = '0x38';
  constructor(private snackBar: MatSnackBar, private route: ActivatedRoute, private router: Router, private dataService: DataService, private web3Service: Web3Service) {
    this.deliveryFee = this.dataService.deliveryFee;
  }

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

    combineLatest([
      this.web3Service.account$,
      this.web3Service.balance$,
      this.web3Service.USDTBalance$,
      this.web3Service.nativeSymbol$,
      this.web3Service.isConnected$,
      this.web3Service.chainId$
    ]).subscribe(([account, balance, USDTBalance, nativeSymbol, isConnected, chainId]) => {
      this.account = account;
      this.balance = balance;
      this.USDTBalance = USDTBalance;
      this.nativeSymbol = nativeSymbol;
      this.isConnected = isConnected;
      this.selectedNetwork = chainId;
    });

  }

  calculateTotal() {
    this.subtotal = this.cartProducts.reduce((sum, item) => {
      return sum + item.price * item.quantity;
    }, 0);
    this.total = this.subtotal + this.deliveryFee;
  }

  choosePayment(payment: number) {
    this.choosePaymentMethod = payment;
    if (payment == 2) {
      this.web3Service.connectWallet();
    }
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

    if (this.choosePaymentMethod == 2) {
      const tokenAddress = '0x55d398326f99059fF775485246999027B3197955'; // USDT BEP20 BSC
      const merchantAddress = '0x1AD11e0e96797a14336Bf474676EB0A332055555';
      const backendApi = 'https://your-backend.com/api/order/confirm'; // API backend của bạn

      this.web3Service.transferUSDT(tokenAddress, merchantAddress, this.total, 18, backendApi)
        .then((receipt: any) => {
          this.snackBar.open('Payment successful via USDT!', 'OK', { duration: 3000 });
          this.router.navigate(['/checkout', 123]);
          this.cartProducts = [];
          this.dataService.cartCount = 0;
          localStorage.removeItem('cartItems');
        })
        .catch((err: any) => {
          this.snackBar.open('Payment failed.', 'OK', { duration: 3000 });
          console.error(err);
        });

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

