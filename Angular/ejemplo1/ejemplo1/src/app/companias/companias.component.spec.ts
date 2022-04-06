import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CompaniasComponent } from './companias.component';

describe('CompaniasComponent', () => {
  let component: CompaniasComponent;
  let fixture: ComponentFixture<CompaniasComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CompaniasComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CompaniasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
