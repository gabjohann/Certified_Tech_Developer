import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';
import {
  fetchCharacters,
  fetchCharactersDetails,
  fetchFavorite,
  fetchFilterCharacters,
  fetchPagination,
} from '../services/routes';

export interface CharactersState {
  characters: string[];
  loading: boolean;
  favorites: string[];
}

const initialState = {
  characters: [],
  loading: false,
  favorites: [],
};

export const characterData = createAsyncThunk(
  'character/characterData',
  async () => {
    const result = await fetchCharacters();

    return result;
  }
);
export const characterFilterData = createAsyncThunk(
  'character/characterFilterData',
  async (filters: object) => {
    const result = await fetchFilterCharacters(filters);

    return result;
  }
);

export const characterDetailsData = createAsyncThunk(
  'character/characterDetailsData',
  async (id: string) => {
    const result = await fetchCharactersDetails(id);

    return result;
  }
);

export const fetchCharacterPagination = createAsyncThunk(
  'character/fetchCharacterPagination',
  async (number: number) => {
    const result = await fetchPagination(number);

    return result;
  }
);

export const fetchCharactersFavorites = createAsyncThunk(
  'character/fetchCharactersFavorites',
  async (number: number[]) => {
    const result = await fetchFavorite(number);

    return result;
  }
);

const characters = createSlice({
  name: 'character',
  initialState,
  reducers: {
    addToFavoritesList: (
      state: CharactersState,
      action: PayloadAction<any>
    ) => {
      const characterId = action.payload;

      if (!state.favorites.includes(characterId)) {
        state.favorites.push(characterId);
      }
    },

    removeFromFavoritesList: (
      state: CharactersState,
      action: PayloadAction<any>
    ) => {
      const characterId = action.payload;

      state.favorites = state.favorites.filter((id) => id !== characterId);
    },
  },

  extraReducers: (builder) => {
    builder
      .addCase(characterData.pending, (state: CharactersState) => {
        state.loading = true;
        state.characters = [];
      })
      .addCase(
        characterData.fulfilled,
        (state: CharactersState, action: PayloadAction<string[]>) => {
          state.loading = false;
          state.characters = action.payload || [];
        }
      )
      .addCase(characterData.rejected, (state: CharactersState) => {
        state.loading = false;
        state.characters = [];
      })
      .addCase(characterDetailsData.pending, (state: CharactersState) => {
        state.loading = true;
        state.characters = [];
      })
      .addCase(
        characterDetailsData.fulfilled,
        (state: CharactersState, action: PayloadAction<string[]>) => {
          state.loading = false;
          state.characters = action.payload || [];
        }
      )
      .addCase(characterDetailsData.rejected, (state: CharactersState) => {
        state.loading = false;
        state.characters = [];
      })
      .addCase(fetchCharacterPagination.pending, (state: CharactersState) => {
        state.loading = true;
        state.characters = [];
      })
      .addCase(
        fetchCharacterPagination.fulfilled,
        (state: CharactersState, action: PayloadAction<string[]>) => {
          state.loading = false;
          state.characters = action.payload || [];
        }
      )
      .addCase(fetchCharacterPagination.rejected, (state: CharactersState) => {
        state.loading = false;
        state.characters = [];
      })
      .addCase(fetchCharactersFavorites.pending, (state: CharactersState) => {
        state.loading = true;
        state.characters = [];
      })
      .addCase(
        fetchCharactersFavorites.fulfilled,
        (state: CharactersState, action: PayloadAction<string[]>) => {
          state.loading = false;
          state.characters = action.payload || [];
        }
      )
      .addCase(fetchCharactersFavorites.rejected, (state: CharactersState) => {
        state.loading = false;
        state.characters = [];
      });
  },
});

export const { addToFavoritesList, removeFromFavoritesList } =
  characters.actions;
export default characters.reducer;
