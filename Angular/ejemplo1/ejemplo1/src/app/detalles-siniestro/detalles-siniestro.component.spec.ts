import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DetallesSiniestroComponent } from './detalles-siniestro.component';

describe('DetallesSiniestroComponent', () => {
  let component: DetallesSiniestroComponent;
  let fixture: ComponentFixture<DetallesSiniestroComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DetallesSiniestroComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DetallesSiniestroComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
