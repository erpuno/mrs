defmodule MRS do
  @moduledoc """
  """
  require Record

  @schema [ :"ATC", :"INN", :"Package", :"SKU", :"Manufacturer", :"AuthHolder", :"Registry" ]

  Enum.each(@schema,
    fn t ->
      Enum.each(
        Record.extract_all(
          from_lib: "mrs/include/" <> :erlang.list_to_binary(:erlang.atom_to_list(t)) <> ".hrl"
        ),
        fn {name, definition} ->
          prev = :application.get_env(:kernel, :mrs_tables, [])
          prev2 = :application.get_env(:mrs, :mrs_fields, [])
          case :lists.member(name, prev) do
            true ->
              :skip

            false ->
              Record.defrecord(name, definition)
              :application.set_env(:kernel, :mrs_tables, [name | prev])
              :application.set_env(:mrs, :mrs_fields, [{name,definition} | prev2])
          end
        end
      )
    end
  )

  def schema(), do: @schema

end
