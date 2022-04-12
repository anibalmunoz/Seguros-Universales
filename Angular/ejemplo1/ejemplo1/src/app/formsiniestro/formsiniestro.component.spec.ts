import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FormsiniestroComponent } from './formsiniestro.component';

describe('FormsiniestroComponent', () => {
  let component: FormsiniestroComponent;
  let fixture: ComponentFixture<FormsiniestroComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FormsiniestroComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FormsiniestroComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
