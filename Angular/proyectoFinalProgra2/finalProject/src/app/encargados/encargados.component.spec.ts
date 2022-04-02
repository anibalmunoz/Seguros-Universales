import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EncargadosComponent } from './encargados.component';

describe('EncargadosComponent', () => {
  let component: EncargadosComponent;
  let fixture: ComponentFixture<EncargadosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EncargadosComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(EncargadosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
