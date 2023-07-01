import { useAppDispatch, useAppSelector } from '../redux/hooks';
import { RootState } from '../redux/store';
import { useEffect } from 'react';
import { fetchCharactersFavorites } from '../redux/reducers';
import { Heart } from '@phosphor-icons/react';

export function FavoritePage() {
  const dispatch = useAppDispatch();

  const {
    characters,
    favorites,
  }: { characters: any; loading: boolean; favorites: number[] } =
    useAppSelector((state: RootState) => state.characters);

  useEffect(() => {
    dispatch(fetchCharactersFavorites(favorites));
  }, [dispatch, favorites]);

  return (
    <div className='p-7 mx-0 my-auto'>
      <div className='flex justify-between items-center'>
        {favorites.length === 0 ? (
          <p>Não há favoritos selecionados</p>
        ) : (
          <ul
            key={characters.id}
            className='grid grid-cols-3 gap-5 justify-items-center'
          >
            {characters.results?.map((character: any) => {
              const { id, name, image } = character;

              const isFavorite = favorites.includes(id);

              if (isFavorite) {
                return (
                  <div className='border border-lineColor rounded-md max-w-[300px]'>
                    <img
                      src={image}
                      alt={`Image of character ${name}`}
                      className='overflow-clip'
                      width={300}
                      height={300}
                    />
                    <div className='px-2 py-2 flex items-center justify-between'>
                      <span>{name}</span>

                      <Heart size={32} weight='fill' color='#EE4A2D' />
                    </div>
                  </div>
                );
              }
            })}
          </ul>
        )}
      </div>
    </div>
  );
}
/* return (
    <>
      <div className='p-7 mx-0 my-auto'>
        <div className='flex justify-between items-center'>
          <h1 className='text-lg font-bold'>Personagens Favoritos</h1>
        </div>
      </div>
      <CharactersGrid />
    </>
  ); */
