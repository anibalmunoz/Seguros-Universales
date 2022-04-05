import { Component, OnInit } from '@angular/core';
import { SeguroService } from '../servicios/seguro/seguro.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';

@Component({
  selector: 'app-formseguro',
  templateUrl: './formseguro.component.html',
  styleUrls: ['./formseguro.component.css']
})
export class FormseguroComponent implements OnInit {

  seguroNuevo: any = {};
  respuesta: boolean = true;

  constructor(private seguroService: SeguroService, public ref: DynamicDialogRef, public config: DynamicDialogConfig) { }

  ngOnInit(): void {
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearSeguro");
    this.seguroNuevo.fechaInicio = new Date(this.seguroNuevo.fechaI + "T00:00:00");
    this.seguroNuevo.fechaVencimiento = new Date(this.seguroNuevo.fechaV + "T00:00:00");
    if (formulario.reportValidity()) {
      this.seguroService.guardarSeguro(this.seguroNuevo).subscribe(
        (res: any) => this.finalizarGuardar(res)
      )
      alert("Seguro guardado correctamente");
      formulario.reset();
      this.seguroNuevo = {};
    }
    this.ref.close(this.respuesta);
  }


  finalizarGuardar(respuesta: any) {
  }


}
