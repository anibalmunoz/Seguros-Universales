import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CompaniaService } from '../servicios/compania/compania.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';

@Component({
  selector: 'app-form-compania',
  templateUrl: './form-compania.component.html',
  styleUrls: ['./form-compania.component.css']
})
export class FormCompaniaComponent implements OnInit {

  companiaNueva: any = {};
  respuesta: boolean = true;
  parametro: any;


  constructor(private companiaService: CompaniaService, public ref: DynamicDialogRef, public config: DynamicDialogConfig,
    private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {
   
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearCliente");
    if (formulario.reportValidity()) {
      this.companiaService.guardarCompania(this.companiaNueva).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      formulario.reset();
      this.companiaNueva = {};
      this.ref.close(this.respuesta);
    }
  }

  finalizarGurdar(respuesta: any) {
  }

}
