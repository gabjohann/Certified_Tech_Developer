import { useParams } from "react-router-dom";
import { useAppDispatch, useAppSelector } from "../redux/hooks";
import { useEffect } from "react";
import { characterDetailsData } from "../redux/reducers";
import { RootState } from "../redux/store";

export function DetailsPage() {
  const { id }: any = useParams();

  const dispatch = useAppDispatch();

  const { characters }: { characters: any } = useAppSelector(
    (state: RootState) => state.characters
  );
  const { name, gender, location, image } = characters;

  useEffect(() => {
    dispatch(characterDetailsData(id));
  }, [dispatch, id]);

  return (
    <div className="grid grid-cols-2 px-7 py-7">
      <div className="flex items-center">
        <div>
          <h1 className="pb-8 text-lg font-bold">
            List of episodes in which the character appeared:
          </h1>
          <div className="max-w-[300px] rounded-md border border-lineColor">
            <img
              src={image}
              alt={`Image of character ${name}`}
              className="overflow-clip"
              width={300}
              height={300}
            />
            <div className="flex flex-col gap-3 px-2 py-4">
              <h1 className="text-lg font-bold">{name}</h1>
              <p className="text-lg font-bold">
                Planet: <span className="font-normal">{location?.name}</span>
              </p>
              <p className="text-lg font-bold">
                Gender: <span className="font-normal">{gender}</span>
              </p>
            </div>
          </div>
        </div>
      </div>

      <div>
        <h1 className="text-lg font-bold">
          List of episodes in which the character appeared:
        </h1>
        <p>fazer a lista</p>
      </div>
    </div>
  );
}
