import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class SiniestroService {

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

  private consumirDelete(url: string, parametro: any): Observable<any> {
    return this.http.delete<any>(environment.urlService + url + parametro).pipe(
      catchError(e => this.manejarError(e))
    )
  }

  private manejarError(e: any) {
    return throwError("Ha ocurrido un error");
  }

  buscarSiniestros() {
    return this.consumirGet("siniestro/buscar")
  }

  buscarSiniestroPorID(id:any) {
    return this.consumirGet("siniestro/buscar/dni/"+id);
  }

  guardarSiniestro(siniestro: any) {
    return this.consumirPost("siniestro/guardar", siniestro);
  }

  //CONSUMO DE PAGEABLE

  siniestroPaginado(pagina: number, cantidad: number) {
    return this.consumirGet("siniestro/paginado/" + pagina + "/" + cantidad)
  }

  //Paginado filtrado
  siniestroPaginadoPorDNI(dniCliente: number, pagina: number, cantidad: number) {
    return this.consumirGet("siniestro/paginado/cliente/" + dniCliente + "/" + pagina + "/" + cantidad)
  }

  //Eliminar siniestro
  eliminarSiniestro(siniestro: any) {
    return this.consumirDelete("siniestro/eliminar/", siniestro);
  }

}
