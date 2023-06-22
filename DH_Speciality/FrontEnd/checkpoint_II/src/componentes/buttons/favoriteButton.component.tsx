import { Heart } from '@phosphor-icons/react';

interface ButtonProps {
  isFavorite: boolean;
}

export function FavoriteButton({ isFavorite = false }: ButtonProps) {
  return (
    <button type='button'>
      {isFavorite ? (
        <Heart size={32} weight='fill' color='#EE4A2D' />
      ) : (
        <Heart size={32} color='#EE4A2D' />
      )}
    </button>
  );
}
