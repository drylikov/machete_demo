defmodule MacheteDemo do
  @moduledoc false

  def get_user do
    %{
      id: Enum.random(1..1_000_000),
      name: Enum.random(["Moe Fonebone", "Abner Legrand", "Ella Grimes", "Serena Riley"]),
      age: Enum.random(20..80),
      created_at: DateTime.utc_now(),
      is_admin: false,
      tags: random(["hip", "purple", "organic", "open", "gorilla", "vintage", "pre-recorded"], 3)
    }
  end

  defp random(enumerable, count) do
    enumerable
    |> Enum.shuffle()
    |> Enum.take(count)
  end
end