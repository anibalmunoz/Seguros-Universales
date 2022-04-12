import { Component, OnInit } from '@angular/core';
import { SiniestroService } from '../servicios/siniestro/siniestro.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DialogService } from 'primeng/dynamicdialog';
import { FormsiniestroComponent } from '../formsiniestro/formsiniestro.component';

@Component({
  selector: 'app-siniestros',
  templateUrl: './siniestros.component.html',
  styleUrls: ['./siniestros.component.css'],
  providers: [ConfirmationService, MessageService, DialogService],
})
export class SiniestrosComponent implements OnInit {

  pagina: number = 0;
  filas: number = 5;
  paginas: any = { name: 5 };
  paginado: any = {};
  siniestros: any = [];
  siniestroNuevo: any = {};
  mostrarFormulario: boolean = false;
  primeraPagina: boolean = false;
  ultimaPagina: boolean = false;
  paginasTotales: number = 0;
  cantidadSiniestros: number = 0;

  first = 0;
  rows = 10;

  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  mostrarBotonNuevo = true;

  siniestro: any = { perito: {}, };

  ref?: DynamicDialogRef;



  constructor(private siniestroService: SiniestroService, private confirmationService: ConfirmationService, private messageService: MessageService,
    public dialogService: DialogService) { }

  ngOnInit(): void {
    this.obtenerPaginado(0, this.filas);
  }


  obtenerPaginado(pagina: number, cantidad: number) {
    //clientePaginado(pagina,cantidad)
    this.siniestroService.siniestroPaginado(pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.siniestros = pageable.content;
    this.paginasTotales = pageable.totalPages;
    this.cantidadSiniestros = pageable.totalElements;
    this.filas = this.paginas.name;
    if (pageable.last) {
      this.ultimaPagina = true;
    }
    if (pageable.first) {
      this.primeraPagina = true;
    }
  }

  flotanteEditar(siniestro: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de editar el siniestro?',
      header: 'Edicion',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        this.modificarSiniestro(siniestro);
      },
      reject: () => {
      }
    });
  }


  flotanteEliminar(siniestro: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de eliminar este siniestro?',
      header: 'Confirmación de eliminación',
      icon: 'pi pi-info-circle',
      accept: () => {
        this.eliminarSiniestro(siniestro);
        this.reset();
      },
      reject: () => {
      }
    });
  }


  modificarSiniestro(siniestro: any) {
    this.siniestroNuevo = siniestro
    this.siniestroNuevo.fechaS = siniestro.fechaSiniestro;
    this.mostrarFormulario = true;
    this.mostrarBotonNuevo = false;
  }

  eliminarSiniestro(siniestro: any) {
    this.siniestroService.eliminarSiniestro(siniestro.idSiniestro).subscribe();
    this.mostrarDeleteToast();
    this.reset();
  }

  mostrarGuardarToast() {
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Info', detail: 'Siniestro guardado correctamente' });
  }

  mostrarEditarToast() {
    this.messageService.add({ key: 'te', severity: 'warn', summary: 'Info', detail: 'Siniestro editado correctamente' });
  }

  mostrarDeleteToast() {
    this.messageService.add({ key: 'td', severity: 'error', summary: 'Info', detail: 'Siniestro eliminado correctamente' });
  }


  //IMPLEMENTACION DE LAS TABLAS CON PAGINACIÓN CUSTOM


  next() {
    if (!this.ultimaPagina) {
      this.pagina = this.pagina + 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  last() {
    if (!this.ultimaPagina) {
      this.pagina = this.paginasTotales - 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }


  prev() {
    if (!this.primeraPagina) {
      this.pagina = this.pagina - 1;
      this.ultimaPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  primero() {
    if (!this.primeraPagina) {
      this.pagina = 0;
      this.ultimaPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  reset() {
    //this.first = 0;
    this.ultimaPagina = false;
    this.primeraPagina = true;
    this.pagina = 0;
    this.filas = this.paginas.name;
    this.obtenerPaginado(0, this.filas);
  }

  //FIN DE IMPLEMENTACIÓN DE NAVEGACION CUSTOM


  irClienteSeguros(siniestro: any) {
    location.href = "/clienteseguros/" + siniestro.numeroPoliza + "/siniestro";
  }

  //FORMULARIOS

  formularioComponent() {
    this.ref = this.dialogService.open(FormsiniestroComponent, {
      header: 'Siniestro',
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

  enviarFormulario() {
    let formulario: any = document.getElementById("crearSiniestro");
    this.siniestroNuevo.fechaSiniestro = new Date(this.siniestroNuevo.fechaS + "T00:00:00");
    if (formulario.reportValidity()) {
      this.siniestroService.guardarSiniestro(this.siniestroNuevo).subscribe(
        (res: any) => this.finalizarGuardar(res)
      )
      this.mostrarEditarToast();
      formulario.reset();
      this.siniestroNuevo = {};
      this.mostrarFormulario = false;
      this.reset();
      this.mostrarBotonNuevo = true;
    }
  }

  finalizarGuardar(respuesta: any) {
    this.obtenerPaginado(this.pagina, this.filas);
  }

  cancelarEditar() {
    this.mostrarFormulario = false;
    this.siniestroNuevo = {};
    this.mostrarBotonNuevo = true;
  }

}

