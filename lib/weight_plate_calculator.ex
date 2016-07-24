defmodule WeightPlateCalculator do
  @default_available_plates %{45 => 2, 35 => 2, 25 => 2, 10 => 2, 5 => 4, 2.5 => 2}
  @default_weight_of_bar 45
  def plates_for(weight_in_lbs) do
    starting_weight = weight_in_lbs - @default_weight_of_bar
    @default_available_plates
    |> Map.to_list
    |> Enum.sort_by(&elem(&1, 0), &>=/2)
    |> Enum.reduce({starting_weight, %{}},
      fn({weight, available_plates}, {remaining_weight, needed_plates}) ->
      do_plate_calc(remaining_weight, weight, available_plates, needed_plates)
      end
    )
    |> result
  end

  defp result({0.0, plates}), do: {:ok, plates}
  defp result({0, plates}), do: {:ok, plates}
  defp result({remaining, _plates}), do: {:error, {:weight_remaining, remaining}}

  defp do_plate_calc(remaining_weight, plate_weight, available_plates, needed_plates) when
  available_plates >= 2 and remaining_weight >= (plate_weight * 2) do
    remaining_weight = remaining_weight - (plate_weight * 2)
    available_plates = available_plates - 2
    needed_plates = Map.update(needed_plates, plate_weight, 1, &(&1+1))
    do_plate_calc(remaining_weight, plate_weight, available_plates, needed_plates)
  end
  defp do_plate_calc(remaining_weight, _plate_weight, _available_plates, needed_plates) do
    {remaining_weight, needed_plates}
  end

end
