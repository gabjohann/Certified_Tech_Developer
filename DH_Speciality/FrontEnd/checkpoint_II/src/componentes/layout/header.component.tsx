/**
 * Header that contains links to navigate between pages
 *
 * Usage: `<Header />`
 *
 * @returns {TSX.Element}
 */

import { Link } from "react-router-dom";

export function Header() {
  return (
    <>
      <header className="flex w-full items-center justify-between border-b border-lineColor px-7 py-6">
        <div>
          <h1 className="text-2xl font-bold">Checkpoint Front-end IV</h1>
        </div>
        <nav>
          <ul className="flex items-center justify-between gap-5 text-base font-medium">
            <li>
              <Link to="/">Início</Link>
            </li>
            <li>
              <Link to="/favorites">Favoritos</Link>
            </li>
          </ul>
        </nav>
      </header>
    </>
  );
}
