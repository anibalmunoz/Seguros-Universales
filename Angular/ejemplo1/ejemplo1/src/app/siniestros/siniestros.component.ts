import { Component, OnInit } from '@angular/core';
import { SiniestroService } from '../servicios/siniestro/siniestro.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { FormseguroComponent } from '../formseguro/formseguro.component';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DialogService } from 'primeng/dynamicdialog';

@Component({
  selector: 'app-siniestros',
  templateUrl: './siniestros.component.html',
  styleUrls: ['./siniestros.component.css']
})
export class SiniestrosComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

}
