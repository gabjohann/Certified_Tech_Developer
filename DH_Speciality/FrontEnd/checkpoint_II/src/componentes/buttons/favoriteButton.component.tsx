import { Heart } from '@phosphor-icons/react';

interface ButtonProps {
  click: () => void;
  isFavorite: boolean;
}

export function FavoriteButton({ isFavorite, click }: ButtonProps) {
  return (
    <button type='button' onClick={click}>
      {isFavorite ? (
        <Heart size={32} weight='fill' color='#EE4A2D' />
      ) : (
        <Heart size={32} color='#EE4A2D' />
      )}
    </button>
  );
}
