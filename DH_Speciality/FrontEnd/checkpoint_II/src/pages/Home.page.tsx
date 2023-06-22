/**
 * This is the main page. Here you should see the filter panel along with the character grid.
 * Usage:
 * ``` <HomePage /> ```
 *
 * @returns Home page
 */

import { CharactersGrid } from '../componentes/characters/charactersGrid.component';
import { Filter } from '../componentes/characters/filters.character';
import { Pagination } from '../componentes/pagination/pagination.component';

export function HomePage() {
  return (
    <div className='p-6 mx-auto my-0'>
      <h1 className='text-2xl font-bold'>Catálogo de Personagens</h1>

      <Filter />
      <Pagination />
      <CharactersGrid />
      <Pagination />
    </div>
  );
}
