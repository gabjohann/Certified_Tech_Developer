import { useAppDispatch, useAppSelector } from "../redux/hooks";
import { RootState } from "../redux/store";
import { useEffect } from "react";
import { fetchCharactersFavorites } from "../redux/reducers";
import { Heart } from "@phosphor-icons/react";

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
    <div className="mx-0 my-auto p-7">
      <div className="flex items-center justify-between">
        {favorites.length === 0 ? (
          <p>Não há favoritos selecionados</p>
        ) : (
          <ul
            key={characters.id}
            className="grid grid-cols-3 justify-items-center gap-5"
          >
            {characters.results?.map((character: any) => {
              const { id, name, image } = character;

              const isFavorite = favorites.includes(id);

              if (isFavorite) {
                return (
                  <div className="max-w-[300px] rounded-md border border-lineColor">
                    <img
                      src={image}
                      alt={`Image of character ${name}`}
                      className="overflow-clip"
                      width={300}
                      height={300}
                    />
                    <div className="flex items-center justify-between px-2 py-2">
                      <span>{name}</span>

                      <Heart size={32} weight="fill" color="#EE4A2D" />
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
