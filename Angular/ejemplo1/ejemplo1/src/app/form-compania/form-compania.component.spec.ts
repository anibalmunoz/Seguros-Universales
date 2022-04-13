import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FormCompaniaComponent } from './form-compania.component';

describe('FormCompaniaComponent', () => {
  let component: FormCompaniaComponent;
  let fixture: ComponentFixture<FormCompaniaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FormCompaniaComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FormCompaniaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
