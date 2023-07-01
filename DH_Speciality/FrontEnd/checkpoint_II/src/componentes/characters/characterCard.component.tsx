/**
 * Card for each character within the character grid.
 *
 * You will need to add the necessary properties to display the character data.
 *
 * @returns {TSX.Element}
 */

import { Link } from "react-router-dom";
import "../buttons/favoriteButton.component";
import { FavoriteButton } from "../buttons/favoriteButton.component";

type CharacterCardProps = {
  image: string;
  name: string;
  id: number;
  favorite: boolean;
  addToFavoritesList?: any;
  removeFromFavoritesList?: any;
};

export function CharacterCard({
  name,
  image,
  id,
  favorite,
  addToFavoritesList,
  removeFromFavoritesList,
}: CharacterCardProps) {
  function handleFavoriteButtonClick() {
    favorite ? removeFromFavoritesList(id) : addToFavoritesList(id);
  }

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
        <Link to={`/details/${id}`}>
          <button>{name}</button>
        </Link>

        <FavoriteButton
          click={handleFavoriteButtonClick}
          isFavorite={favorite}
        />
      </div>
    </div>
  );
}
