import { Component } from '@angular/core';
import {MenuItem} from 'primeng/api';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'ejemplo1';

  irClientes() {
    location.href = "/clientes";
  }

  irSeguros() {
    location.href = "/seguros";
  }

  irBienvenida() {
    location.href ="";
  }

}
