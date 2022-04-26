import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class CompaniaSegurosService {

  constructor(private http:HttpClient) { }

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

  guardarCompaniaSeguro(compSeg: any) {
    return this.consumirPost("companiaseguro/guardar", compSeg);
  }
}
