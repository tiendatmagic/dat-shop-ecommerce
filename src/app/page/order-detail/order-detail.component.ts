import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DataService } from '../../services/data.service';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-order-detail',
  standalone: false,
  templateUrl: './order-detail.component.html',
  styleUrl: './order-detail.component.scss'
})
export class OrderDetailComponent {
  orderData: any;
  id: any;
  deliveryFee: number = 0;
  constructor(private route: ActivatedRoute, private router: Router, private dataService: DataService, private http: HttpClient, private auth: AuthService) {
    this.deliveryFee = this.dataService.deliveryFee;
  }

  ngOnInit() {
    this.id = this.route.snapshot.paramMap.get('id');
    if (this.id) {
      this.auth.getOrderDetail({ id: this.id }).subscribe(
        (res: any) => {
          this.orderData = res;
        },
        (error: any) => {
          console.error(error);
        }
      )
    }
    else {
      this.router.navigate(['/order']);
    }
  }


}