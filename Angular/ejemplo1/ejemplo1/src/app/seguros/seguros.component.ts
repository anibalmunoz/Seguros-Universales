import { Component, OnInit } from '@angular/core';
import { SeguroService } from '../servicios/seguro/seguro.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { FormseguroComponent } from '../formseguro/formseguro.component';

import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DialogService } from 'primeng/dynamicdialog';



@Component({
  selector: 'app-seguros',
  templateUrl: './seguros.component.html',
  styleUrls: ['./seguros.component.css'],
  providers: [ConfirmationService, MessageService, DialogService],
})
export class SegurosComponent implements OnInit {

  seguros: any = [];
  seguroNuevo: any = {};
  mostrarFormulario: boolean = false;
  paginado: any = {};
  primeraPagina: boolean = false;
  finalPagina: boolean = false;
  pagina: number = 0;
  filas: number = 5;
  paginasTotales: number = 0;
  cantidadSeguros: number = 0;

  first = 0;
  rows = 10;


  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  paginas: any = { name: 5 };
  ref?: DynamicDialogRef;


  constructor(private seguroService: SeguroService, private confirmationService: ConfirmationService, private messageService: MessageService,
    public dialogService: DialogService) { }

  ngOnInit(): void {
    this.obtenerPaginado(0, this.filas);
  }

  obtenerSeguros() {
    this.seguroService.buscarSeguros().subscribe(
      (res: any) => this.mostrarSeguros(res)
    );
  }

  mostrarSeguros(segs: any) {
    this.seguros = segs;
  }


  enviarFormulario() {
    let formulario: any = document.getElementById("crearSeguro");
    this.seguroNuevo.fechaInicio = new Date(this.seguroNuevo.fechaI + "T00:00:00");
    this.seguroNuevo.fechaVencimiento = new Date(this.seguroNuevo.fechaV + "T00:00:00");
    if (formulario.reportValidity()) {
      this.seguroService.guardarSeguro(this.seguroNuevo).subscribe(
        (res: any) => this.finalizarGuardar(res)
      )
      this.mostrarGuardarToast();
      formulario.reset();
      this.seguroNuevo = {};
      this.mostrarFormulario = false;
      this.reset();
    }
  }

  finalizarGuardar(respuesta: any) {
    this.obtenerPaginado(this.pagina, this.filas);
  }

  mostrarFormularios() {
    this.mostrarFormulario = !this.mostrarFormulario;
  }

  //PRUEBA DE CONSUMO DE PAGEABLE 

  obtenerPaginado(pagina: number, cantidad: number) {
    //clientePaginado(pagina,cantidad)
    this.seguroService.seguroPaginado(pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.seguros = pageable.content;
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
    //this.first = 0;
    this.finalPagina = false;
    this.primeraPagina = true;
    this.pagina = 0;
    this.filas = this.paginas.name;
    this.obtenerPaginado(0, this.filas);
  }

  editarSeguro(seguro: any) {
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

  eliminar(seguro: any) {
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
    this.seguroNuevo = seguro
    this.mostrarFormulario = true;
  }

  cancelarEditar() {
    this.mostrarFormulario = false;
    this.seguroNuevo = {};
  }

  eliminarSeguro(seguro: any) {
    this.seguroService.eliminarSeguro(seguro.numeroPoliza).subscribe();
    this.mostrarDeleteToast();
    this.reset();
  }

  mostrarGuardarToast(){
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Info', detail: 'Cliente guardado correctamente' });
  }

  mostrarDeleteToast() {
    this.messageService.add({ key: 'td', severity: 'error', summary: 'Info', detail: 'Seguro eliminado correctamente' });
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
        this.mostrarDeleteToast();
        this.reset();
        //this.ngOnInit();
      }
    });
  }

}
