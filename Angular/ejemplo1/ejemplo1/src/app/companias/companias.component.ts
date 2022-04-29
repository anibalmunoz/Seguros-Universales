import { Component, OnInit } from '@angular/core';
import { CompaniaService } from '../servicios/compania/compania.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { Message } from 'primeng/api';
import { PrimeNGConfig } from 'primeng/api';
import { FormCompaniaComponent } from '../form-compania/form-compania.component';

import { DialogService } from 'primeng/dynamicdialog';
import { DynamicDialogRef } from 'primeng/dynamicdialog';


@Component({
  selector: 'app-companias',
  templateUrl: './companias.component.html',
  styleUrls: ['./companias.component.css'],
  providers: [ConfirmationService, MessageService, DialogService],
})
export class CompaniasComponent implements OnInit {




  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  paginas: any = { name: 5 };
  companias: any = [];
  companiaNueva: any = {};
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

  constructor(private companiaService: CompaniaService, private confirmationService: ConfirmationService,
    private primengConfig: PrimeNGConfig, private messageService: MessageService, public dialogService: DialogService) { }

  ngOnInit(): void {
    this.obtenerPaginado(0, this.filas);
  }


  formularioComponent() {
    this.ref = this.dialogService.open(FormCompaniaComponent, {
      header: 'Companía',
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

  flotanteEditar(compania: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de editar la compania?',
      header: 'Edicion',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        this.modificarCompania(compania);
      },
      reject: () => {
      }
    });
  }

  flotanteEliminar(compania: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de eliminar esta compania?',
      header: 'Confirmación de eliminación',
      icon: 'pi pi-info-circle',
      accept: () => {
        this.eliminarCompania(compania);
        this.reset();
      },
      reject: () => {
      }
    });
  }

  mostrarGuardarToast() {
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Info', detail: 'Compania guardada correctamente' });
  }
  mostrarEditarToast() {
    this.messageService.add({ key: 'te', severity: 'warn', summary: 'Info', detail: 'Compania editada correctamente' });
  }
  mostrarDeleteToast() {
    this.messageService.add({ key: 'td', severity: 'error', summary: 'Info', detail: 'Compania eliminada correctamente' });
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





  obtenerPaginado(pagina: number, cantidad: number) {    
    this.companiaService.companiaPaginado(pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.companias = pageable.content;
    this.paginasTotales = pageable.totalPages;
    this.cantidadClientes = pageable.totalElements;
    this.listaSeguros = this.companias.segurosList;
    this.filas = this.paginas.name;
    if (pageable.last) {
      this.finalPagina = true;
    }
    if (pageable.first) {
      this.primeraPagina = true;
    }
  }



    modificarCompania(compania: any) {
      this.mostrarBotonNuevo = false;
      this.companiaNueva = compania
      this.mostrarFormulario = true;
    }
  
  
    eliminarCompania(cliente: any) {
      this.companiaService.eliminarCompania(cliente.nombreCompania).subscribe();
      this.mostrarDeleteToast();
      this.reset();
    }

    //FORMULARIOS

    enviarFormulario() {
      let formulario: any = document.getElementById("crearCliente");
      if (formulario.reportValidity()) {
        this.companiaService.guardarCompania(this.companiaNueva).subscribe(
          (res: any) => this.finalizarGurdar(res)
        )
        this.mostrarEditarToast();
        formulario.reset();
        this.companiaNueva = {};
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

    
  cancelarEditar() {
    this.mostrarFormulario = false;
    this.companiaNueva = {};
    this.mostrarBotonNuevo = true;
  }

}
