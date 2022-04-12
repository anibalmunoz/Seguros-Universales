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

const routes: Routes = [

  { path: '', component: BienvenidaComponent },
  { path: 'clientes', component: ClientesComponent },
  { path: 'clienteseguros/:param1/:param2', component: ClientesegurosComponent },
  { path: 'seguros', component: SegurosComponent },
  
  { path: 'formcliente/:param1', component: FormclienteComponent },
  { path: 'formseguro/:param1', component: FormseguroComponent },
  { path: 'formsiniestro/:param1', component: FormsiniestroComponent },


  { path: 'siniestros', component: SiniestrosComponent },
  { path: 'companias', component: CompaniasComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
