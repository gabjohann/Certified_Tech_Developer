/***
 * Character grid for the home page.
 *
 * You will need to add the necessary functions to display and paginate the characters.
 *
 *
 * @returns {TSX.Element}
 */

import { CharacterCard } from './characterCard.component';

export function CharactersGrid() {
  return (
    <div className='grid grid-cols-3 gap-5 justify-items-center'>
      <CharacterCard />
      <CharacterCard />
      <CharacterCard />
    </div>
  );
}
