import { TestBed } from '@angular/core/testing';

import { PeritoService } from './perito.service';

describe('PeritoService', () => {
  let service: PeritoService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PeritoService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
