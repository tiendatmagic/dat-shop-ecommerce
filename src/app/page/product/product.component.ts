import { Component, OnInit, OnDestroy } from '@angular/core';
import { DataService } from '../../services/data.service';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-product',
  standalone: false,
  templateUrl: './product.component.html',
  styleUrl: './product.component.scss'
})
export class ProductComponent implements OnInit, OnDestroy {
  productData: any;
  selectedSize: string | null = null;
  selectedImage: string | null = null;
  public id: any;
  productList: any[] = [];
  public routeSubscription: Subscription | undefined;

  constructor(private dataService: DataService, private route: ActivatedRoute) { }

  ngOnInit() {
    this.routeSubscription = this.route.paramMap.subscribe(params => {
      window.scrollTo(0, 0);
      this.selectedImage = null;
      this.selectedSize = null;
      this.id = params.get('id');
      this.productList = this.dataService.productList;
      this.productData = this.dataService.productList.find(product => product.id == this.id);
      if (!this.productData) {
        console.error(`Product with ID ${this.id} not found`);
      } else {
        this.selectedImage = this.productData.image[0] || null;
      }
    });
  }

  ngOnDestroy() {
    // Clean up subscription to prevent memory leaks
    if (this.routeSubscription) {
      this.routeSubscription.unsubscribe();
    }
  }

  selectSize(size: string) {
    this.selectedSize = size;
  }

  selectImage(image: string) {
    this.selectedImage = image;
  }
}