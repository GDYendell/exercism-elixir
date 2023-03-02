defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  defstruct direction: :north, position: {0, 0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      direction not in [:north, :east, :south, :west] ->
        {:error, "invalid direction"}

      not is_tuple(position) or tuple_size(position) != 2 or not is_integer(elem(position, 0)) or
          not is_integer(elem(position, 1)) ->
        {:error, "invalid position"}

      true ->
        %RobotSimulator{direction: direction, position: position}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instruction) do
    do_simulate(robot, String.graphemes(instruction))
  end

  defp do_simulate(robot, [instruction | tail]) do
    case instruction do
      "R" -> do_simulate(rotate_r(robot), tail)
      "L" -> do_simulate(rotate_l(robot), tail)
      "A" -> do_simulate(advance(robot), tail)
      _ -> {:error, "invalid instruction"}
    end
  end

  defp do_simulate(robot, []) do
    robot
  end

  defp rotate_r(robot) do
    case robot.direction do
      :north -> %{robot | direction: :east}
      :east -> %{robot | direction: :south}
      :south -> %{robot | direction: :west}
      :west -> %{robot | direction: :north}
    end
  end

  defp rotate_l(robot) do
    case robot.direction do
      :north -> %{robot | direction: :west}
      :east -> %{robot | direction: :north}
      :south -> %{robot | direction: :east}
      :west -> %{robot | direction: :south}
    end
  end

  defp advance(robot) do
    x = elem(robot.position, 0)
    y = elem(robot.position, 1)

    case robot.direction do
      :north -> %{robot | position: {x, y + 1}}
      :east -> %{robot | position: {x + 1, y}}
      :south -> %{robot | position: {x, y - 1}}
      :west -> %{robot | position: {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot.position
  end
end
