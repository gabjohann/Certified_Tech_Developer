import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { HomePage } from './pages/Home.page';
import { FavoritePage } from './pages/FavoritePage';
import { Header } from './componentes/layout/header.component';
import { DetailsPage } from './pages/DetailsPage';

export default function AppRoutes() {
  return (
    <Router>
      <Header />
      <Routes>
        <Route path='/' element={<HomePage />} />
        <Route path='/favorites' element={<FavoritePage />} />
        <Route path='/details/:id' element={<DetailsPage />} />
      </Routes>
    </Router>
  );
}
