import { TestBed } from '@angular/core/testing';

import { App } from './app';

describe('App', () => {
  it('renders the course title', async () => {
    await TestBed.configureTestingModule({ imports: [App] }).compileComponents();

    const fixture = TestBed.createComponent(App);
    await fixture.whenStable();

    const page = fixture.nativeElement as HTMLElement;
    expect(page.querySelector('h1')?.textContent).toBe('Curso de Angular');
  });
});
