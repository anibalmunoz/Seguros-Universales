import { TestBed } from '@angular/core/testing';

import { CompaniaSegurosService } from './compania-seguros.service';

describe('CompaniaSegurosService', () => {
  let service: CompaniaSegurosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CompaniaSegurosService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
