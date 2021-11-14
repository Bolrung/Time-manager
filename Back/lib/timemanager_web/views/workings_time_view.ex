defmodule TimemanagerWeb.WorkingsTimeView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.WorkingsTimeView

  def render("index.json", %{workingstime: workingstime}) do
    %{data: render_many(workingstime, WorkingsTimeView, "workings_time.json")}
  end

  def render("show.json", %{workings_time: workings_time}) do
    %{data: render_one(workings_time, WorkingsTimeView, "workings_time.json")}
  end

  def render("workings_time.json", %{workings_time: workings_time}) do
    %{
      id: workings_time.id,
      start: workings_time.start,
      end: workings_time.end
    }
  end
end
