import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BienvenidaComponent } from './bienvenida/bienvenida.component';
import { ClientesComponent } from './clientes/clientes.component';
import { SegurosComponent } from './seguros/seguros.component';
import { FormclienteComponent } from './formcliente/formcliente.component';
import { FormseguroComponent } from './formseguro/formseguro.component';
import { ClientesegurosComponent } from './clienteseguros/clienteseguros.component';
import { SiniestrosComponent } from './siniestros/siniestros.component';
import { CompaniasComponent } from './companias/companias.component';
import { FormsiniestroComponent } from './formsiniestro/formsiniestro.component';
import { PeritosComponent } from './peritos/peritos.component';
import { FormPeritoComponent } from './form-perito/form-perito.component';
import { DetallesSiniestroComponent } from './detalles-siniestro/detalles-siniestro.component';
import { DetallesPeritoComponent } from './detalles-perito/detalles-perito.component';
import { FormCompaniaComponent } from './form-compania/form-compania.component';

const routes: Routes = [

  //PAGINAS
  { path: '', component: BienvenidaComponent },
  { path: 'clientes', component: ClientesComponent },
  { path: 'seguros', component: SegurosComponent },
  { path: 'siniestros', component: SiniestrosComponent },
  { path: 'companias', component: CompaniasComponent },
  { path: 'peritos', component: PeritosComponent },
  
  //FORMULARIOS DE CREACIÓN
  { path: 'formcliente/:param1', component: FormclienteComponent },
  { path: 'formseguro/:param1', component: FormseguroComponent },
  { path: 'formsiniestro/:param1', component: FormsiniestroComponent },
  { path: 'form-perito/:param1', component: FormPeritoComponent },
  { path: 'form-compania/:param1', component: FormCompaniaComponent },


  //PAGINAS DE DETALLES
  { path: 'clienteseguros/:param1/:param2', component: ClientesegurosComponent },
  { path: 'detalles-siniestro/:param1/:param2/:param3', component: DetallesSiniestroComponent },
  { path: 'detalles-perito/:param1', component: DetallesPeritoComponent },



];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
