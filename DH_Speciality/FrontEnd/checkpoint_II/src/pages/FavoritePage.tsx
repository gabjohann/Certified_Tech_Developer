import { CharactersGrid } from '../componentes/characters/charactersGrid.component';

export function FavoritePage() {
  return (
    <>
      <div className='p-7 mx-0 my-auto'>
        <div className='flex justify-between items-center'>
          <h1 className='text-lg font-bold'>Personagens Favoritos</h1>
        </div>
      </div>
      <CharactersGrid />
    </>
  );
}
