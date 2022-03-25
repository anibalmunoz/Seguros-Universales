import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../servicios/cliente/cliente.service';

@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.css']
})
export class ClientesComponent implements OnInit {

  constructor(private clienteService: ClienteService) { }

  clientes: any = [];

  ngOnInit(): void {
    this.obtenerClientes();
    //setInterval(()=>this.obtenerClientes(),1000)
  }

  obtenerClientes() {
    this.clienteService.bucarClientes().subscribe(
      (res: any) => this.mostrarClientes(res)
    );
  }

  mostrarClientes(clients: any) {
    this.clientes = clients;
    console.log(this.clientes)
  }

}
