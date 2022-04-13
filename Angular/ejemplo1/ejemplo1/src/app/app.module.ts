import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http'

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { InputTextModule } from 'primeng/inputtext';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';
import { ToastModule } from 'primeng/toast';
import { MenubarModule } from 'primeng/menubar';
import { TabMenuModule } from 'primeng/tabmenu';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { DropdownModule } from 'primeng/dropdown';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { DynamicDialogModule } from 'primeng/dynamicdialog';
import { MessagesModule } from 'primeng/messages';
import { DialogModule } from 'primeng/dialog';

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

import {RippleModule} from 'primeng/ripple';
import { SpeedDialModule } from 'primeng/speeddial';
import { FormPeritoComponent } from './form-perito/form-perito.component';
import { DetallesSiniestroComponent } from './detalles-siniestro/detalles-siniestro.component';
import { DetallesPeritoComponent } from './detalles-perito/detalles-perito.component';
import { FormCompaniaComponent } from './form-compania/form-compania.component';



@NgModule({
  declarations: [
    AppComponent,
    BienvenidaComponent,
    ClientesComponent,
    SegurosComponent,
    FormclienteComponent,
    FormseguroComponent,
    ClientesegurosComponent,
    SiniestrosComponent,
    CompaniasComponent,
    FormsiniestroComponent,
    PeritosComponent,
    FormPeritoComponent,
    DetallesSiniestroComponent,
    DetallesPeritoComponent,
    FormCompaniaComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    InputTextModule,
    FormsModule,
    ButtonModule,
    HttpClientModule,
    TableModule,
    ToastModule,
    MenubarModule,
    TabMenuModule,
    BrowserAnimationsModule,
    DropdownModule,
    ConfirmDialogModule,
    DynamicDialogModule,
    MessagesModule,
    DialogModule,
    RippleModule,
    SpeedDialModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
