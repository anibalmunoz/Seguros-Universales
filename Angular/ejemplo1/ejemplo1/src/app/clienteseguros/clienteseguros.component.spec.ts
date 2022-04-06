import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ClientesegurosComponent } from './clienteseguros.component';

describe('ClientesegurosComponent', () => {
  let component: ClientesegurosComponent;
  let fixture: ComponentFixture<ClientesegurosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ClientesegurosComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ClientesegurosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
