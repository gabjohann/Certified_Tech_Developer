/**
 * Component that contains the pagination buttons.
 *
 * You should add the necessary properties for it to work correctly.
 *
 *
 * @returns {TSX.Element}
 */

import { useDispatch, useSelector } from 'react-redux';
import {
  PAGINATION_INCREMENT,
  PAGINATION_DECREMENT,
} from '../../redux/actionsTypes';

export function Pagination() {
  /* const dispatch = useDispatch();
  const { page } = useSelector((store) => store.page); */

  return (
    <div className='flex items-center justify-between my-3'>
      <button
        /*  disabled={page === 1} */
        /*  onClick={() => dispatch({ type: PAGINATION_DECREMENT })} */
        className='bg-disableColor text-white text-base font-medium px-5 py-2 rounded-md '
      >
        Anterior
      </button>
      <button
        /*  disabled={page === 42} */
        /*  onClick={() => dispatch({ type: PAGINATION_INCREMENT })} */
        className='bg-enableColor text-white text-base font-medium px-5 py-2 rounded-md '
      >
        Próximo
      </button>
    </div>
  );
}
