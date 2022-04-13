import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FormPeritoComponent } from './form-perito.component';

describe('FormPeritoComponent', () => {
  let component: FormPeritoComponent;
  let fixture: ComponentFixture<FormPeritoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FormPeritoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FormPeritoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
