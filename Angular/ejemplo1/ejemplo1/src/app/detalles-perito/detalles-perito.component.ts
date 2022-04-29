import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DialogService } from 'primeng/dynamicdialog';
import { PeritoService } from '../servicios/perito/perito.service';
import { SiniestroService } from '../servicios/siniestro/siniestro.service';
import { FormsiniestroComponent } from '../formsiniestro/formsiniestro.component';

@Component({
  selector: 'app-detalles-perito',
  templateUrl: './detalles-perito.component.html',
  styleUrls: ['./detalles-perito.component.css'],
  providers: [ConfirmationService, MessageService, DialogService],

})
export class DetallesPeritoComponent implements OnInit {

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
  perito: any;

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

  dniPerito:any;



  constructor(private siniestroService: SiniestroService, private peritoService: PeritoService, private activatedRoute: ActivatedRoute,
    private confirmationService: ConfirmationService, private messageService: MessageService, public dialogService: DialogService) { }

  ngOnInit(): void {
    this.activatedRoute.params.subscribe(parametros => {

      this.dniPerito=parametros['param1'];
      this.buscarPeritoPorDNI(this.dniPerito);

    });
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

  buscarPeritoPorDNI(perito: any) {
    this.peritoService.buscarPeritoPorDNI(perito).subscribe(
      (respuesta: any) => this.asginarPerito(respuesta)
    );
  }

  asginarPerito(perito: any) {
    this.perito = perito[0];
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
      }
    });
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


   irDetallesSiniestro(siniestro: any) {
    location.href = "/detalles-siniestro/" + siniestro.numeroPoliza + "/" + siniestro.perito.dniPerito +"/" + siniestro.idSiniestro;
  }


}
