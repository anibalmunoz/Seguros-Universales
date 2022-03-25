import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient } from '@angular/common/http';

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

  private manejarError(e: any) {
    return throwError("Ha ocurrido un error");
  }

  bucarClientes() {
    return this.consumirGet("cliente/buscar")
  }


}
