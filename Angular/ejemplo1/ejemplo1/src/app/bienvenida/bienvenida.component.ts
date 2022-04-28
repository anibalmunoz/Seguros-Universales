import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-bienvenida',
  templateUrl: './bienvenida.component.html',
  styleUrls: ['./bienvenida.component.css']
})
export class BienvenidaComponent implements OnInit {

  nombre: string = "";
  saludo: string = "";


  constructor() { }

  ngOnInit(): void {
  }

  saludar() {
    this.saludo = "Hola " + this.nombre + " mucho gusto";
  }


  irClientes() {
    location.href = "/clientes";
  }

  irSeguros() {
    location.href = "/seguros";
  }

  irSiniestros() {
    location.href = "/siniestros"
  }

  irCompanias() {
    location.href = "/companias"
  }

  irPeritos() {
    location.href = "/peritos"
  }

}
