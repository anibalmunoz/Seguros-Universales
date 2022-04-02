import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class SeguroService {

  constructor(private http:HttpClient) { }

  
  private consumirGet(url: string): Observable<any> {
    return this.http.get<any>(environment.urlService + url).pipe(
      catchError(e => this.manejarError(e))
    );
  }

  private consumirPost(url: string, parametro: any): Observable<any> {
    let httpOptions = {
      headers: new HttpHeaders(
        { 'Content-Type': 'application/json' }
      )
    };
    return this.http.post<any>(environment.urlService + url, parametro, httpOptions).pipe(
      catchError(e => this.manejarError(e))
    );
  }

  private consumirDelete(url: string, parametro: any): Observable<any> {
    return this.http.delete<any>(environment.urlService + url + parametro).pipe(
      catchError(e => this.manejarError(e))
    )
  }

  private manejarError(e: any) {
    return throwError("Ha ocurrido un error");
  }

  buscarSeguros() {
    return this.consumirGet("seguro/buscar")
  }

  
  guardarSeguro(cliente: any) {
    return this.consumirPost("seguro/guardar", cliente);
  }

  //PRUEBA DE CONSUMO DE PAGEABLE

  seguroPaginado(pagina:number,cantidad:number){
    return this.consumirGet("seguro/paginado/"+pagina+"/"+cantidad)
  }

   //Eliminar cliente
   eliminarSeguro(seguro: any) {
    return this.consumirDelete("cliente/eliminar/", seguro);

  }
}
