import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {InputTextModule} from 'primeng/inputtext';
import { FormsModule } from '@angular/forms';
import {ButtonModule} from 'primeng/button';


import { BienvenidaComponent } from './bienvenida/bienvenida.component';

@NgModule({
  declarations: [
    AppComponent,
    BienvenidaComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    InputTextModule,
    FormsModule,
    ButtonModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
