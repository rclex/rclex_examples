defmodule RclexManyTalkersTest do
  use ExUnit.Case
  doctest RclexManyTalkers

  test "greets the world" do
    assert RclexManyTalkers.hello() == :world
  end
end
