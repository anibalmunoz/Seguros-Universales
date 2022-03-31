import { Component, OnInit } from '@angular/core';
import { SeguroService } from '../servicios/seguro/seguro.service';

@Component({
  selector: 'app-seguros',
  templateUrl: './seguros.component.html',
  styleUrls: ['./seguros.component.css']
})
export class SegurosComponent implements OnInit {

  seguros: any = [];
  seguroNuevo: any = {};
  mostrarFormulario: boolean = false;



  constructor(private seguroService: SeguroService) { }

  ngOnInit(): void {
    this.obtenerSeguros();
    //setInterval(()=>this.obtenerClientes(),1000)
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
      alert("Seguro guardado correctamente");
      formulario.reset();
    }
  }

  finalizarGuardar(respuesta: any) {
    console.log(respuesta);
    this.obtenerSeguros();
  }

  mostrarFormularios() {
    this.mostrarFormulario = !this.mostrarFormulario;
  }

}
