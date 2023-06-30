import { useNavigate } from 'react-router-dom';
import { CharactersGrid } from '../componentes/characters/charactersGrid.component';
import { useAppDispatch, useAppSelector } from '../redux/hooks';
import { RootState } from '../redux/store';
import { useEffect } from 'react';
import { fetchCharactersFavorites } from '../redux/reducers';

export function FavoritePage() {
  const navigate = useNavigate();

  const getBack = () => {
    navigate(-1);
  };

  const dispatch = useAppDispatch();

  const {
    characters,
    loading,
    favorites,
  }: { characters: any; loading: boolean; favorites: number[] } =
    useAppSelector((state: RootState) => state.characters);

  useEffect(() => {
    dispatch(fetchCharactersFavorites(favorites));
  }, [useAppDispatch, fetchCharactersFavorites]);

  return (
    <div className='p-7 mx-0 my-auto'>
      <div className='flex justify-between items-center'>
        {favorites.length === 0 ? (
          <p>Não há favoritos selecionados</p>
        ) : (
          <ul>
            {characters.results?.map((character: any) => {
              const { _id, name, image } = character;

              const isFavorite = favorites.includes(_id);

              console.log(isFavorite);
              if (isFavorite) {
                return <p>{name}</p>;
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
