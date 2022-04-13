import { Component, OnInit } from '@angular/core';
import { PeritoService } from '../servicios/perito/perito.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-form-perito',
  templateUrl: './form-perito.component.html',
  styleUrls: ['./form-perito.component.css']
})
export class FormPeritoComponent implements OnInit {

  peritoNuevo: any = {};
  respuesta: boolean = true;
  parametro: any;


  constructor(private peritoService: PeritoService, public ref: DynamicDialogRef, public config: DynamicDialogConfig,
    private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {

    this.activatedRoute.params.subscribe(parametros => {
      this.parametro = parametros['param1'];
      console.log(this.parametro);
    });

  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearPerito");
    if (formulario.reportValidity()) {
      this.peritoService.guardarPerito(this.peritoNuevo).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      formulario.reset();
      this.peritoNuevo = {};
      this.ref.close(this.respuesta);
    }
  }

  finalizarGurdar(respuesta: any) {
  }

}
