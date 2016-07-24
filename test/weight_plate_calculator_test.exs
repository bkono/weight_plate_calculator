defmodule WeightPlateCalculatorTest do
  use ExUnit.Case
  doctest WeightPlateCalculator

  test "returns 0 plates for 45lbs" do
    assert WeightPlateCalculator.plates_for(45) == {:ok, %{}}
  end

  test "returns 1 45 for 90#s" do
    assert WeightPlateCalculator.plates_for(135) == {:ok, %{45 => 1}}
  end

  test "returns 1 35 for 70#s" do
    assert WeightPlateCalculator.plates_for(115) == {:ok, %{35 => 1}}
  end

  test "returns 1 45 and 1 35 for 160" do
    assert WeightPlateCalculator.plates_for(205) == {:ok, %{45 => 1, 35 => 1}}
  end

  test "returns 1 35 1 2.5 for 120#" do
    assert WeightPlateCalculator.plates_for(120) == {:ok, %{35 => 1, 2.5 => 1}}
  end

  test "returns 45, 10, 5, 2.5 for #170" do
    assert WeightPlateCalculator.plates_for(170) == {:ok, %{45 => 1, 10 => 1, 5 => 1, 2.5 => 1}}
  end

  test "returns :error, remaining for 57" do
    assert WeightPlateCalculator.plates_for(57) == {:error, {:weight_remaining, 2}}
  end

end
