defmodule Fibonacci.Memoize do
  use GenServer

  # client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, Map.new(), name: __MODULE__)
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def set(key, value) do
    GenServer.cast(__MODULE__, {{:set, key}, value})
  end

  def delete(key) do
    GenServer.cast(__MODULE__, {:delete, key})
  end

  # server API

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_cast({{:set, key}, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl true
  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end
end
