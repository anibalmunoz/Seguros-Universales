import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DetallesPeritoComponent } from './detalles-perito.component';

describe('DetallesPeritoComponent', () => {
  let component: DetallesPeritoComponent;
  let fixture: ComponentFixture<DetallesPeritoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DetallesPeritoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DetallesPeritoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
