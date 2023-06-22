/**
 * Card for each character within the character grid.
 *
 * You will need to add the necessary properties to display the character data.
 *
 * @returns {TSX.Element}
 */

import '../buttons/favoriteButton.component';
import { FavoriteButton } from '../buttons/favoriteButton.component';

export function CharacterCard() {
  return (
    <div className='border border-lineColor rounded-md max-w-[300px]'>
      <img
        src='https://rickandmortyapi.com/api/character/avatar/1.jpeg'
        alt='Rick Sanchez Image'
        className='overflow-clip'
        width={300}
        height={300}
      />
      <div className='px-2 py-2 flex items-center justify-between'>
        <span>Rick Sanchez</span>
        <FavoriteButton isFavorite={false} />
      </div>
    </div>
  );
}
