import { Component } from '@angular/core';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';
import { ClientesComponent } from './clientes.component';

@Component({
    template: `
        <form id="crearCliente">
        <font COLOR="white">

        </font>
        <br>
        <div class="row">
            <div class="col-md-6 ">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="text" pInputText class="form-control" required maxlength="40"
                        >
                        <label class="form-label">Nombre</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="text" pInputText class="form-control" required maxlength="40"
                           >
                        <label class="form-label">Primer Apellido</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="text" pInputText class="form-control" maxlength="40"
                           >
                        <label class="form-label">Segundo Apellido</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="text" pInputText class="form-control" required maxlength="40"
                            >
                        <label class="form-label">Clase Vía</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="text" pInputText class="form-control" required maxlength="40"
                            >
                        <label class="form-label">Nombre Vía</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="number" pInputText class="form-control" required maxlength="40"
                            >
                        <label class="form-label">Número Vía</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="number" pInputText class="form-control" required maxlength="40"
                            >
                        <label class="form-label">Código Postal</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="text" pInputText class="form-control" required maxlength="40"
                           >
                        <label class="form-label">Ciudad</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="number" pInputText class="form-control" required maxlength="40"
                            >
                        <label class="form-label">Teléfono</label>
                    </span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-4">
                    <span class="p-float-label">
                        <input type="text" pInputText class="form-control" maxlength="75"
                            >
                        <label class="form-label">Observaciones</label>
                    </span>
                </div>
            </div>
            <div>
                <button type="button" class="btn btn-outline-success float-end" >
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor"
                        class="bi bi-check-square-fill" viewBox="0 0 16 16">
                        <path
                            d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z" />

                    </svg> Guardar </button>
                &nbsp; &nbsp;

                <button type="button" class="btn btn-outline-danger float-end" >

                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor"
                        class="bi bi-x-square-fill" viewBox="0 0 16 16">
                        <path
                            d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm3.354 4.646L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 1 1 .708-.708z" />
                    </svg> Cancelar </button>
            </div>
        </div>
    </form>
    `
})
export class ProductListDemo {

    clientesComponent?: ClientesComponent;

    constructor(public ref: DynamicDialogRef, public config: DynamicDialogConfig) { }

    ngOnInit() {
    }

}