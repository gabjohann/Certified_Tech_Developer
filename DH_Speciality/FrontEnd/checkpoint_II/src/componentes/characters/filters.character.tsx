import { useEffect, useState } from "react";
import { useAppDispatch } from "../../redux/hooks";
import { characterFilterData } from "../../redux/reducers";

export function Filter() {
  const dispatch = useAppDispatch();

  const [inputValue, setInputValue] = useState("");

  useEffect(() => {
    dispatch(characterFilterData({ name: inputValue }));
  }, [dispatch, inputValue]);

  return (
    <div className="mb-5 flex flex-col">
      <label htmlFor="name" className="mb-2 text-base font-medium">
        Filtrar por nome:
      </label>

      <form action=""></form>

      <input
        type="text"
        placeholder="Rick, Morty, Beth, Alien, ... etc"
        name="name"
        className="col-span-2 rounded border border-lineColor px-5 py-3"
        value={inputValue}
        onChange={(e) => setInputValue(e.target.value)}
      />
      <button type="button" onClick={() => setInputValue("")}>
        Clear
      </button>
    </div>
  );
}
