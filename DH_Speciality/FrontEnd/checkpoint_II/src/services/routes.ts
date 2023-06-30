import { api } from './api';

export interface CharacterProps {
  _id: number;
  name: string;
  air_date: string;
  episodes: string;
  characters: string[];
  url: string;
  createdAt: string;
}

export async function fetchCharacters() {
  const response = await api.get('/character');

  return response.data;
}
export async function fetchFilterCharacters(filters: object) {
  const response = await api.get('/character', { params: filters });

  return response.data;
}

export async function fetchCharactersDetails(_id: string) {
  const response = await api.get(`/character/${_id}`);

  return response.data;
}

export async function fetchPagination(number: number) {
  const response = await api.get(`/character?page=${number}`);

  return response.data;
}

export async function fetchFavorite(number: number[]) {
  const response = await api.get(`/character?id=${number}`);

  return response.data;
}