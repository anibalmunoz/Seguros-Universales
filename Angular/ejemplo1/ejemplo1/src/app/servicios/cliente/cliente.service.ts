import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ClienteService {

  constructor(private http: HttpClient) { }

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

  private manejarError(e: any) {
    return throwError("Ha ocurrido un error");
  }

  buscarClientes() {
    return this.consumirGet("cliente/buscar");
  }

  guardarCliente(cliente: any) {
    return this.consumirPost("cliente/guardar", cliente);
  }

  //PRUEBA DE CONSUMO DE PAGEABLE

  clientePaginado(pagina:number,cantidad:number){
    return this.consumirGet("cliente/paginado/"+pagina+"/"+cantidad)
  }

}
