import { Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { BehaviorSubject } from 'rxjs';
import { NotifyComponent } from '../modal/notify/notify.component';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  productList: any[] = [
    {
      id: 1,
      name: 'Football Jersey',
      price: 1,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063577/b1devpuovnvqwdo8pfia.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063577/o7kcxzpkbvobb05iu949.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063577/iwopzvmpc5olrt7anheh.jpg'],
      size: ['S', 'M', 'XL', 'XXL'],
      isBestSeller: true,
    },
    {
      id: 2,
      name: 'Hampton Long Sleeve Shirt',
      price: 50,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063302/wowbtd0tlj6tpfxvkxcg.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063302/kjfejg6lvpqwib89qwfy.jpg'],
      size: ['S', 'M', 'L'],
      isBestSeller: false,
    },
    {
      id: 3,
      name: 'Cropped Fit Graphic T-Shirt',
      price: 30,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063623/gnttim2dl0vxljmpejlu.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063623/fwtx0axdz5iowwgarff7.jpg'],
      size: ['S', 'M', 'XL', 'XXL', 'L'],
      isBestSeller: false,
    },
    {
      id: 4,
      name: 'Easy Short',
      price: 25,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063667/qudc6bwwlvnzfsgmx2ah.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063667/ocu1bqsqtipqrk1dt61i.jpg'],
      size: ['S', 'M', 'L'],
      isBestSeller: false,
    },
    {
      id: 5,
      name: 'Alina Shirred Halter Top',
      price: 35,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063762/ggjerydhpsewxvm8kbyd.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063762/jqoik9izii3hv5j2z2b4.jpg'],
      size: ['S', 'M', 'L', 'XL'],
      isBestSeller: true,
    },
    {
      id: 6,
      name: 'Mikki Drop Hem Mini Dress',
      price: 60,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063815/hbrtbquoemjpaghclydx.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063815/hk4ofjpoxe8ocrfvagkz.jpg'],
      size: ['S', 'M', 'L', 'XL'],
      isBestSeller: true,
    },
    {
      id: 7,
      name: 'Haven Wide Leg Pant',
      price: 30,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063885/cnffks7xikrhgjan9zil.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063885/e6xpjggzveoxjospfxos.jpg'],
      size: ['S', 'M', 'L', 'XL'],
      isBestSeller: false,
    },
    {
      id: 8,
      name: 'Kaia Faux Leather Bomber',
      price: 109,
      image: ['https://res.cloudinary.com/dfyykwzsa/image/upload/v1753064020/zc0xgahhdyl4jttwci2e.jpg', 'https://res.cloudinary.com/dfyykwzsa/image/upload/v1753064020/mwzlfoxgfofmncknwecv.jpg'],
      size: ['S', 'M', 'L', 'XL', 'XXL'],
      isBestSeller: true,
    }

  ]
  cartItems: any[] = [];
  deliveryFee: number = 1;
  usdtAddress = '0x55d398326f99059fF775485246999027B3197955';
  merchantAddress = '0x282eae859073adC4bC3Cf4DE24a2436bC1888888';

  private cartCountSubject = new BehaviorSubject<number>(0);
  public cartCount$ = this.cartCountSubject.asObservable();

  constructor(public dialog: MatDialog) { }

  get cartCount(): number {
    return this.cartCountSubject.value;
  }
  set cartCount(value: number) {
    this.cartCountSubject.next(value);
  }

  addToCart(product: any) {
    var getCartItems = localStorage.getItem('cartItems');

    if (getCartItems) {
      try {
        this.cartItems = JSON.parse(getCartItems);
      } catch (error) {
        this.cartItems = [];
      }
    }
    this.cartItems.unshift(product);
    localStorage.setItem('cartItems', JSON.stringify(this.cartItems));
    this.cartCount = this.cartItems.length;
  }

  showNotify(status: string, title: string, desc: string, disableClose: boolean = false, nrStatus: number = 0, value: any = '') {
    this.dialog.closeAll();
    this.dialog.open(NotifyComponent, {
      disableClose: disableClose,
      width: '90%',
      maxWidth: '400px',
      enterAnimationDuration: '100ms',
      exitAnimationDuration: '100ms',
      data: {
        status: status,
        title: title,
        desc: desc,
        nrStatus: nrStatus,
        value: value,
      }
    });
  }
}
