import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { Message } from 'primeng/api';
import { PrimeNGConfig } from 'primeng/api';

import { DialogService } from 'primeng/dynamicdialog';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { FormclienteComponent } from '../formcliente/formcliente.component';
import { MenuItem } from 'primeng/api';



@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.css'],
  providers: [ConfirmationService, MessageService, DialogService],

})
export class ClientesComponent implements OnInit {

  items!: MenuItem[];
  tooltipItems!: MenuItem[];
  leftTooltipItems!: MenuItem[];

  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  paginas: any = { name: 5 };
  clientes: any = [];
  clienteNuevo: any = {};
  mostrarFormulario: boolean = false;
  paginado: any = {};
  primeraPagina: boolean = false;
  finalPagina: boolean = false;
  pagina: number = 0;
  filas: number = 5;
  paginasTotales: number = 0;
  cantidadClientes: number = 0;
  listaSeguros: any = [];

  first = 0;
  rows = 10;

  msgs: Message[] = [];
  ref?: DynamicDialogRef;
  position: string = "";
  mostrarBotonNuevo = true;

  value3: string = "";

  constructor(private clienteService: ClienteService, private confirmationService: ConfirmationService,
    private primengConfig: PrimeNGConfig, private messageService: MessageService, public dialogService: DialogService) { }


  ngOnInit(): void {

    this.items = [
      {
        icon: 'pi pi-pencil',
        command: () => {
          this.messageService.add({ severity: 'info', summary: 'Add', detail: 'Data Added' });
        }
      },
      {
        icon: 'pi pi-trash',
        command: () => {
          this.messageService.add({ severity: 'error', summary: 'Delete', detail: 'Data Deleted' });
        }
      },
      {
        icon: 'pi pi-list',
      },

    ];





    this.obtenerPaginado(0, this.filas);
   
  }

  flotanteEditar(cliente: any) {
    this.confirmationService.confirm({
      message: '??Estas seguro de editar el cliente?',
      header: 'Edicion',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        this.modificarCliente(cliente);
      },
      reject: () => {
      }
    });
  }

  flotanteEliminar(cliente: any) {
    this.confirmationService.confirm({
      message: '??Estas seguro de eliminar este cliente?',
      header: 'Confirmaci??n de eliminaci??n',
      icon: 'pi pi-info-circle',
      accept: () => {
        this.eliminarCliente(cliente);
        this.reset();
      },
      reject: () => {
      }
    });
  }


  //toast
  showSuccess() {
    this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Message Content' });
  }
  mostrarGuardarToast() {
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Info', detail: 'Cliente guardado correctamente' });
  }
  mostrarEditarToast() {
    this.messageService.add({ key: 'te', severity: 'warn', summary: 'Info', detail: 'Cliente editado correctamente' });
  }
  mostrarDeleteToast() {
    this.messageService.add({ key: 'td', severity: 'error', summary: 'Info', detail: 'Cliente eliminado correctamente' });
  }

  formularioComponent() {
    this.ref = this.dialogService.open(FormclienteComponent, {
      header: 'Cliente',
      width: '70%',
      contentStyle: { "max-height": "500px", "overflow": "auto" },
      baseZIndex: 10000,
    });

    this.ref.onClose.subscribe((respuesta: any) => {
      if (respuesta) {
        this.mostrarGuardarToast();
        this.reset();
        this.ngOnInit();
      }
    });
  }

  formularioComponentEditar() {
    this.ref = this.dialogService.open(FormclienteComponent, {
      header: 'Cliente',
      width: '70%',
      contentStyle: { "max-height": "500px", "overflow": "auto" },
      baseZIndex: 10000,
      data: this.clienteNuevo,
    });

    this.ref.onClose.subscribe((respuesta: any) => {
      if (respuesta) {
        this.mostrarGuardarToast();
        this.reset();
        this.ngOnInit();
      }
    });
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
    if (formulario.reportValidity()) {
      this.clienteService.guardarCliente(this.clienteNuevo).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      this.mostrarEditarToast();
      formulario.reset();
      this.clienteNuevo = {};
      this.mostrarFormulario = false;
      this.reset();
      this.mostrarBotonNuevo = true;
    }
  }

  finalizarGurdar(respuesta: any) {
    this.obtenerPaginado(this.pagina, this.filas);
  }

  mostrarFormularios() {
    this.mostrarFormulario = !this.mostrarFormulario;
  }


  //CONSUMO DE PAGEABLE 

  obtenerPaginado(pagina: number, cantidad: number) {
    //clientePaginado(pagina,cantidad)
    this.clienteService.clientePaginado(pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  obtenerPaginadoNombre() {   
    console.log(this.value3);
    this.clienteService.clientePaginadoNombre(this.pagina, this.filas, this.value3).subscribe(
      (res: any) => this.mostrarPaginado(res)
    
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.clientes = pageable.content;
    this.paginasTotales = pageable.totalPages;
    this.cantidadClientes = pageable.totalElements;
    this.listaSeguros = this.clientes.segurosList;
    this.filas = this.paginas.name;
    if (pageable.last) {
      this.finalPagina = true;
    }
    if (pageable.first) {
      this.primeraPagina = true;
    }
  }


  //IMPLEMENTACION DE LAS TABLAS CON PAGINACI??N CUSTOM


  next() {
    if (!this.finalPagina) {
      this.pagina = this.pagina + 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  last() {
    if (!this.finalPagina) {
      this.pagina = this.paginasTotales - 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  prev() {
    if (!this.primeraPagina) {
      this.pagina = this.pagina - 1;
      this.finalPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  primero() {
    if (!this.primeraPagina) {
      this.pagina = 0;
      this.finalPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  reset() {
    this.finalPagina = false;
    this.primeraPagina = true;
    this.pagina = 0;
    this.filas = this.paginas.name;
    this.obtenerPaginado(0, this.filas);
  }


  //Modificar cliente

  modificarCliente(cliente: any) {
    this.mostrarBotonNuevo = false;
    this.clienteNuevo = cliente
    this.mostrarFormulario = true;
  }

  //Eliminar Cliente

  eliminarCliente(cliente: any) {
    this.clienteService.eliminarCliente(cliente.dniCl).subscribe();
    this.mostrarDeleteToast();
    this.reset();
  }

  cancelarEditar() {
    this.mostrarFormulario = false;
    this.clienteNuevo = {};
    this.mostrarBotonNuevo = true;
  }

  irClienteSeguros(cliente: any) {
    location.href = "/clienteseguros/" + cliente.dniCl + "/cliente";
  }


}
