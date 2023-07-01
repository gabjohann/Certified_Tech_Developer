/**
 * This is the main page. Here you should see the filter panel along with the character grid.
 * Usage:
 * ``` <HomePage /> ```
 *
 * @returns Home page
 */

import { Pagination } from '../componentes/pagination/pagination.component';
import { Filter } from '../componentes/characters/filters.character';
import { CharactersGrid } from '../componentes/characters/charactersGrid.component';
import { useAppDispatch, useAppSelector } from '../redux/hooks';
import { RootState } from '../redux/store';
import { useEffect, useState } from 'react';
import { fetchCharacterPagination } from '../redux/reducers';

export function HomePage() {
  const dispatch = useAppDispatch();

  const { characters }: { characters: any } = useAppSelector(
    (state: RootState) => state.characters
  );

  const [currentPageUrl, setCurrentPageUrl] = useState(1);

  useEffect(() => {
    dispatch(fetchCharacterPagination(currentPageUrl));
  }, [dispatch, currentPageUrl]);

  function nextPage() {
    if (currentPageUrl < characters.info?.pages) {
      setCurrentPageUrl((previous: number) => previous + 1);
    }
  }

  function previousPage() {
    if (currentPageUrl > 1) {
      setCurrentPageUrl((previous: number) => previous - 1);
    }
  }

  function getToPage(number: number) {
    setCurrentPageUrl(number);
  }

  return (
    <div className='p-6 mx-auto my-0'>
      <h1 className='text-2xl font-bold'>Catálogo de Personagens</h1>

      <Filter />
      <Pagination
        nextPage={currentPageUrl < characters.info?.pages ? nextPage : null}
        previousPage={currentPageUrl > 1 ? previousPage : null}
        goToPage={getToPage}
        pages={characters.info?.pages}
        currentPage={currentPageUrl}
      />
      <CharactersGrid />
      <Pagination
        nextPage={currentPageUrl < characters.info?.pages ? nextPage : null}
        previousPage={currentPageUrl > 1 ? previousPage : null}
      />
    </div>
  );
}
