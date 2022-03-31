import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import {HttpClientModule} from '@angular/common/http'

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {InputTextModule} from 'primeng/inputtext';
import { FormsModule } from '@angular/forms';
import {ButtonModule} from 'primeng/button';
import {TableModule} from 'primeng/table';
import {ToastModule} from 'primeng/toast';
import {MenubarModule} from 'primeng/menubar';
import {TabMenuModule} from 'primeng/tabmenu';




import { BienvenidaComponent } from './bienvenida/bienvenida.component';
import { ClientesComponent } from './clientes/clientes.component';
import { SegurosComponent } from './seguros/seguros.component';

@NgModule({
  declarations: [
    AppComponent,
    BienvenidaComponent,
    ClientesComponent,
    SegurosComponent
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
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
