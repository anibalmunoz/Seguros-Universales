import { Component, OnInit } from '@angular/core';
import { PeritoService } from '../servicios/perito/perito.service';
import { SiniestroService } from '../servicios/siniestro/siniestro.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { Message } from 'primeng/api';
import { PrimeNGConfig } from 'primeng/api';

import { DialogService } from 'primeng/dynamicdialog';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { MenuItem } from 'primeng/api';
import { FormPeritoComponent } from '../form-perito/form-perito.component';


@Component({
  selector: 'app-peritos',
  templateUrl: './peritos.component.html',
  styleUrls: ['./peritos.component.css'],
  providers: [ConfirmationService, MessageService, DialogService],
})
export class PeritosComponent implements OnInit {

  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  paginas: any = { name: 5 };
  peritos: any = [];
  peritoNuevo: any = {};
  mostrarFormulario: boolean = false;
  paginado: any = {};
  primeraPagina: boolean = false;
  finalPagina: boolean = false;
  pagina: number = 0;
  filas: number = 5;
  paginasTotales: number = 0;
  cantidadPeritos: number = 0;
  listaSiniestros: any = [];

  first = 0;
  rows = 10;

  msgs: Message[] = [];
  ref?: DynamicDialogRef;
  position: string = "";
  mostrarBotonNuevo = true;
  value3: string = "";

  constructor(private peritoService: PeritoService, private confirmationService: ConfirmationService,
    private messageService: MessageService, public dialogService: DialogService) { }

  ngOnInit(): void {

    this.obtenerPaginado(0, this.filas);

  }


  obtenerPaginado(pagina: number, cantidad: number) {
    //clientePaginado(pagina,cantidad)
    this.peritoService.buscarPeritoPaginado(pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.peritos = pageable.content;
    this.paginasTotales = pageable.totalPages;
    this.cantidadPeritos = pageable.totalElements;
    this.listaSiniestros = this.peritos.segurosList;
    this.filas = this.paginas.name;
    if (pageable.last) {
      this.finalPagina = true;
    }
    if (pageable.first) {
      this.primeraPagina = true;
    }
  }

  formularioComponent() {
    this.ref = this.dialogService.open(FormPeritoComponent, {
      header: 'Perito',
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


  mostrarGuardarToast() {
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Info', detail: 'Perito guardado correctamente' });
  }
  mostrarEditarToast() {
    this.messageService.add({ key: 'te', severity: 'warn', summary: 'Info', detail: 'Perito editado correctamente' });
  }
  mostrarDeleteToast() {
    this.messageService.add({ key: 'td', severity: 'error', summary: 'Info', detail: 'Perito eliminado correctamente' });
  }

  //IMPLEMENTACION DE LAS TABLAS CON PAGINACIÓN CUSTOM


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

  flotanteEditar(perito: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de editar el perito?',
      header: 'Edicion',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        //this.msgs = [{ severity: 'info', summary: 'Confirmed', detail: 'You have accepted' }];
        this.modificaPerito(perito);
      },
      reject: () => {
      }
    });
  }

  flotanteEliminar(perito: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de eliminar este perito?',
      header: 'Confirmación de eliminación',
      icon: 'pi pi-info-circle',
      accept: () => {
        this.eliminarPerito(perito);
        this.reset();
      },
      reject: () => {
      }
    });
  }

  //Modificar perito

  modificaPerito(perito: any) {
    this.mostrarBotonNuevo = false;
    this.peritoNuevo = perito
    this.mostrarFormulario = true;
  }

  //Eliminar perito

  eliminarPerito(perito: any) {
    this.peritoService.eliminarPerito(perito.dniPerito).subscribe();
    this.mostrarDeleteToast();
    this.reset();
  }

  /*FORMULARIOS */

  enviarFormulario() {
    let formulario: any = document.getElementById("crearCliente");
    if (formulario.reportValidity()) {
      this.peritoService.guardarPerito(this.peritoNuevo).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      this.mostrarEditarToast();
      formulario.reset();
      this.peritoNuevo = {};
      this.mostrarFormulario = false;
      this.reset();
      this.mostrarBotonNuevo = true;
    }
  }

  finalizarGurdar(respuesta: any) {
    this.obtenerPaginado(this.pagina, this.filas);
  }

  cancelarEditar() {
    this.mostrarFormulario = false;
    this.peritoNuevo = {};
    this.mostrarBotonNuevo = true;
  }

  irDetallesPerito(perito: any) {
    location.href = "/detalles-perito/" + perito.dniPerito;
  }

}
