import { Link } from 'react-router-dom';
/**
 * Header that contains links to navigate between pages
 *
 * Usage: `<Header />`
 *
 * @returns {TSX.Element}
 */

export function Header() {
  return (
    <>
      <header className='flex items-center justify-between px-7 py-6 border-b border-lineColor w-full'>
        <div>
          <h1 className='font-bold text-2xl'>Checkpoint Front-end IV</h1>
        </div>
        <nav>
          <ul className='flex items-center justify-between gap-5 font-medium text-base'>
            <li>
              <Link to='/'>Início</Link>
            </li>
            <li>
              <Link to='/favorites'>Favoritos</Link>
            </li>
            <li>
              <Link to='/details'>Detalhes</Link>
            </li>
          </ul>
        </nav>
      </header>
    </>
  );
}
