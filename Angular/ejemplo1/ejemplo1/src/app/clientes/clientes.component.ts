import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { MessageService } from 'primeng/api';


@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.css']
})
export class ClientesComponent implements OnInit {

  //private messageService: MessageService
  constructor(private clienteService: ClienteService) { }

  clientes: any = [];
  clienteNuevo: any = {};
  mostrarFormulario: boolean = false;

  ngOnInit(): void {
    this.obtenerClientes();
    //setInterval(()=>this.obtenerClientes(),1000)
  }

  obtenerClientes() {
    this.clienteService.buscarClientes().subscribe(
      (res: any) => this.mostrarClientes(res)
    );
  }

  mostrarClientes(clients: any) {
    this.clientes = clients;
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearCliente");
    // this.clienteNuevo.fechacreacion= new Date(this.clienteNuevo.fecha+"T00:00:00");
    if (formulario.reportValidity()) {
      this.clienteService.guardarCliente(this.clienteNuevo).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      alert("Cliente guardado correctamente");
      formulario.reset();
    }
  }

  finalizarGurdar(respuesta: any) {
    console.log(respuesta);
    this.obtenerClientes();
  }

  mostrarFormularios() {
    this.mostrarFormulario = !this.mostrarFormulario;
  }

 
  /*
    addSingle() {
      this.messageService.add({ severity: 'success', summary: 'Service Message', detail: 'Via MessageService' });
    }
  
    addMultiple() {
      this.messageService.addAll([{ severity: 'success', summary: 'Service Message', detail: 'Via MessageService' },
      { severity: 'info', summary: 'Info Message', detail: 'Via MessageService' }]);
    }
  
    clear() {
      this.messageService.clear();
    }
  */

}
