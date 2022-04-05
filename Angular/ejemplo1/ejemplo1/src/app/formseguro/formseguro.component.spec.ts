import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FormseguroComponent } from './formseguro.component';

describe('FormseguroComponent', () => {
  let component: FormseguroComponent;
  let fixture: ComponentFixture<FormseguroComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FormseguroComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FormseguroComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
