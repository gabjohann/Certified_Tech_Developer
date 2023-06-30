export function Filter() {
  return (
    <div className='flex flex-col mb-5'>
      <label htmlFor='name' className='mb-2 font-medium text-base'>
        Filtrar por nome:
      </label>

      <input
        type='text'
        placeholder='Rick, Morty, Beth, Alien, ... etc'
        name='name'
        className='border border-lineColor rounded py-3 px-5 col-span-2'
      />
    </div>
  );
}
