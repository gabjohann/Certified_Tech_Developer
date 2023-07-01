/**
 * Component that contains the pagination buttons.
 *
 * You should add the necessary properties for it to work correctly.
 *
 *
 * @returns {TSX.Element}
 */

export function Pagination({ nextPage, previousPage }: any) {
  return (
    <div className='flex items-center justify-between my-3'>
      <button
        onClick={previousPage}
        className={`${
          previousPage ? 'bg-enableColor' : 'bg-disableColor'
        } text-white text-base font-medium px-5 py-2 rounded-md`}
      >
        Anterior
      </button>

      {nextPage && (
        <button
          onClick={nextPage}
          className='bg-enableColor text-white text-base font-medium px-5 py-2 rounded-md '
        >
          Próximo
        </button>
      )}
    </div>
  );
}
