/***
 * Character grid for the home page.
 *
 * You will need to add the necessary functions to display and paginate the characters.
 *
 *
 * @returns {TSX.Element}
 */

import { useEffect, useState } from 'react';
import { useAppDispatch, useAppSelector } from '../../redux/hooks';
import {
  addToFavoritesList,
  characterData,
  removeFromFavoritesList,
} from '../../redux/reducers';
import { RootState } from '../../redux/store';
import { CharacterCard } from './characterCard.component';

export function CharactersGrid() {
  const dispatch = useAppDispatch();

  const {
    characters,
    favorites,
  }: { characters: any; loading: boolean; favorites: boolean[] } =
    useAppSelector((state: RootState) => state.characters);

  const [inputValue, setInputValue] = useState('');

  useEffect(() => {
    dispatch(characterData());
  }, [dispatch]);

  const handleAddToFavoritesList = (episodeId: string) => {
    dispatch(addToFavoritesList(episodeId));
  };

  const handleRemoveFromFavoritesList = (episodeId: string) => {
    dispatch(removeFromFavoritesList(episodeId));
  };

  return (
    <div className='grid grid-cols-3 gap-5 justify-items-center'>
      {characters.results?.map((character: any) => {
        const favorite = favorites.includes(character.id);

        return (
          <ul key={character.id}>
            <CharacterCard
              name={character.name}
              image={character.image}
              id={character.id}
              favorite={favorite}
              addToFavoritesList={handleAddToFavoritesList}
              removeFromFavoritesList={handleRemoveFromFavoritesList}
            />
          </ul>
        );
      })}
    </div>
  );
}

/* 
      <ul>
        {character.results?.map((character) => (
          <CharacterCard
            key={character.id}
            image={character.image}
            name={character.name}
          />
        ))}
      </ul> */
