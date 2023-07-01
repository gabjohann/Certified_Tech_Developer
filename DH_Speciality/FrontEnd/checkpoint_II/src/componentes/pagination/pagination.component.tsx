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
    <div className="my-3 flex items-center justify-between">
      <button
        onClick={previousPage}
        className={`${
          previousPage ? "bg-enableColor" : "bg-disableColor"
        } rounded-md px-5 py-2 text-base font-medium text-white`}
      >
        Anterior
      </button>

      {nextPage && (
        <button
          onClick={nextPage}
          className="rounded-md bg-enableColor px-5 py-2 text-base font-medium text-white"
        >
          Próximo
        </button>
      )}
    </div>
  );
}
