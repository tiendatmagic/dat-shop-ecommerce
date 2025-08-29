import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DataService } from '../../services/data.service';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-order',
  standalone: false,
  templateUrl: './order.component.html',
  styleUrl: './order.component.scss'
})
export class OrderComponent {

  orderData: any;

  constructor(private route: ActivatedRoute, private router: Router, private dataService: DataService, private http: HttpClient, private auth: AuthService) { }

  ngOnInit() {
    console.log(this.orderData);
    this.auth.getMyOrder().subscribe(
      (res: any) => {
        this.orderData = res;
        console.log(res);
      },
      (error: any) => {
        console.error(error);
      }
    )
  }

  viewOrder() {

  }
}
