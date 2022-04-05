import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BienvenidaComponent } from './bienvenida/bienvenida.component';
import { ClientesComponent } from './clientes/clientes.component';
import { SegurosComponent } from './seguros/seguros.component';
import { FormclienteComponent } from './formcliente/formcliente.component';
import { FormseguroComponent } from './formseguro/formseguro.component';

const routes: Routes = [

  { path: '', component: BienvenidaComponent },
  { path: 'clientes', component: ClientesComponent },
  { path: 'seguros', component: SegurosComponent },
  { path: 'formcliente', component: FormclienteComponent },
  { path: 'formseguro', component: FormseguroComponent },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
