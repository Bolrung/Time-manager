defmodule TimemanagerWeb.ClocksView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.ClocksView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClocksView, "clocks.json")}
  end

  def render("show.json", %{clocks: clocks}) do
    %{data: render_one(clocks, ClocksView, "clocks.json")}
  end

  def render("clocks.json", %{clocks: clocks}) do
    %{
      id: clocks.id,
      start: clocks.start,
      end: clocks.end,
      working_time: clocks.working_time
    }
  end
end
