import { useEffect, useState } from 'react';
import { useAppDispatch } from '../../redux/hooks';
import { characterFilterData } from '../../redux/reducers';

export function Filter() {
  const dispatch = useAppDispatch();

  const [inputValue, setInputValue] = useState('');

  useEffect(() => {
    dispatch(characterFilterData({ name: inputValue }));
  }, [dispatch, inputValue]);

  return (
    <div className='flex flex-col mb-5'>
      <label htmlFor='name' className='mb-2 font-medium text-base'>
        Filtrar por nome:
      </label>

      <form action=''></form>

      <input
        type='text'
        placeholder='Rick, Morty, Beth, Alien, ... etc'
        name='name'
        className='border border-lineColor rounded py-3 px-5 col-span-2'
        value={inputValue}
        onChange={(e) => setInputValue(e.target.value)}
      />
      <button type='button' onClick={() => setInputValue('')}>
        Clear
      </button>
    </div>
  );
}
