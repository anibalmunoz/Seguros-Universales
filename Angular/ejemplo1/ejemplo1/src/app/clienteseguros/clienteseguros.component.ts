import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { SeguroService } from '../servicios/seguro/seguro.service';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DialogService } from 'primeng/dynamicdialog';
import { FormseguroComponent } from '../formseguro/formseguro.component';




@Component({
  selector: 'app-clienteseguros',
  templateUrl: './clienteseguros.component.html',
  styleUrls: ['./clienteseguros.component.css'],
  providers: [ConfirmationService, MessageService, DialogService],
})
export class ClientesegurosComponent implements OnInit {

  clienteId: any;
  cliente: any = {};
  listaSeguros: any = [];
  cantidadSeguros: number = 0;
  first = 0;
  rows = 10;
  seguroNuevo: any = {};
  primeraPagina: boolean = false;
  finalPagina: boolean = false;
  pagina: number = 0;
  filas: number = 5;
  mostrarFormulario: boolean = false;
  paginado: any = {};
  paginasTotales: number = 0;
  paginas: any = { name: 5 };
  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];
  ref?: DynamicDialogRef;
  mostrarBotonNuevo = true;

  tipoDeRespuesta: any;
  polizaABuscar: any;
  seguro: any = [];

  constructor(private seguroService: SeguroService, private clienteService: ClienteService, private activatedRoute: ActivatedRoute,
    private confirmationService: ConfirmationService, private messageService: MessageService, public dialogService: DialogService) { }

  ngOnInit(): void {

    this.activatedRoute.params.subscribe(parametros => {
      this.tipoDeRespuesta = parametros['param2'];

      if (this.tipoDeRespuesta == "cliente") {
        this.clienteId = parametros['param1'];
        this.reset();
        this.buscarCliente();
      }
      if (this.tipoDeRespuesta == "siniestro") {
        this.polizaABuscar = parametros['param1'];
        this.buscarSeguroPorNumeroPoliza(this.polizaABuscar);
      }

    });
  }
  

  buscarSeguroPorNumeroPoliza(numeroPoliza: any) {
    this.seguroService.buscarPorPoliza(numeroPoliza).subscribe(
      (respuesta: any) => this.asignarSeguro(respuesta)
    );
  }

  asignarSeguro(seguro: any) {
    this.seguro = seguro[0];
    this.clienteId = this.seguro.dniCl;
    this.reset();
    this.buscarCliente();
  }

  buscarCliente() {
    this.clienteService.buscarClientePorDNI(this.clienteId).subscribe(
      (res: any) => this.mostrarClientes(res)
    );
  }

  mostrarClientes(client: any) {
    this.cliente = client[0];
  }

  flotanteEditar(seguro: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de editar el seguro?',
      header: 'Edicion',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        this.modificarSeguro(seguro);
      },
      reject: () => {
      }
    });
  }

  flotanteEliminar(seguro: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de eliminar este seguro?',
      header: 'Confirmación de eliminación',
      icon: 'pi pi-info-circle',
      accept: () => {
        this.eliminarSeguro(seguro);
        this.reset();
      },
      reject: () => {
      }
    });
  }

  modificarSeguro(seguro: any) {
    this.mostrarBotonNuevo = false;
    this.seguroNuevo = seguro
    this.seguroNuevo.fechaI = seguro.fechaInicio;
    this.seguroNuevo.fechaV = seguro.fechaVencimiento;
    this.mostrarFormulario = true;
  }

  cancelarEditar() {
    this.mostrarFormulario = false;
    this.seguroNuevo = {};
    this.mostrarBotonNuevo = true;
  }

  eliminarSeguro(seguro: any) {
    this.seguroService.eliminarSeguro(seguro.numeroPoliza).subscribe();
    this.mostrarDeleteToast();
    this.reset();
  }

  obtenerPaginado(dni: number, pagina: number, cantidad: number) {
    this.seguroService.seguroPaginadoPorDNI(dni, pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.listaSeguros = pageable.content;
    this.paginasTotales = pageable.totalPages;
    this.cantidadSeguros = pageable.totalElements;
    this.filas = this.paginas.name;
    if (pageable.last) {
      this.finalPagina = true;
    }
    if (pageable.first) {
      this.primeraPagina = true;
    }
  }

  mostrarGuardarToast() {
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Info', detail: 'Seguro guardado correctamente' });
  }

  mostrarDeleteToast() {
    this.messageService.add({ key: 'td', severity: 'error', summary: 'Info', detail: 'Seguro eliminado correctamente' });
  }


  next() {
    if (!this.finalPagina) {
      this.pagina = this.pagina + 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.clienteId, this.pagina, this.filas);
    }
  }

  last() {
    if (!this.finalPagina) {
      this.pagina = this.paginasTotales - 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.clienteId, this.pagina, this.filas);
    }
  }


  prev() {
    if (!this.primeraPagina) {
      this.pagina = this.pagina - 1;
      this.finalPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.clienteId, this.pagina, this.filas);
    }
  }

  primero() {
    if (!this.primeraPagina) {
      this.pagina = 0;
      this.finalPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.clienteId, this.pagina, this.filas);
    }
  }

  reset() {
    //this.first = 0;
    this.finalPagina = false;
    this.primeraPagina = true;
    this.pagina = 0;
    this.filas = this.paginas.name;
    this.obtenerPaginado(this.clienteId, 0, this.filas);
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearSeguro");
    this.seguroNuevo.fechaInicio = new Date(this.seguroNuevo.fechaI + "T00:00:00");
    this.seguroNuevo.fechaVencimiento = new Date(this.seguroNuevo.fechaV + "T00:00:00");
    this.seguroNuevo.dniCl = this.clienteId;
    if (formulario.reportValidity()) {
      this.seguroService.guardarSeguro(this.seguroNuevo).subscribe(
        (res: any) => this.finalizarGuardar(res)
      )
      this.mostrarGuardarToast();
      formulario.reset();
      this.seguroNuevo = {};
      this.mostrarFormulario = false;
      this.mostrarBotonNuevo = true;
      this.reset();
    }
  }

  finalizarGuardar(respuesta: any) {
    this.obtenerPaginado(this.clienteId, this.pagina, this.filas);
  }

  mostrarFormularios() {
    this.mostrarFormulario = !this.mostrarFormulario;
    this.mostrarBotonNuevo = false;
  }


  formularioComponent() {
    this.ref = this.dialogService.open(FormseguroComponent, {
      header: 'Seguro',
      width: '70%',
      contentStyle: { "max-height": "500px", "overflow": "auto" },
      baseZIndex: 10000
    });

    this.ref.onClose.subscribe((respuesta: any) => {
      if (respuesta) {
        this.mostrarGuardarToast();
        this.reset();
        //this.ngOnInit();
      }
    });
  }


}
