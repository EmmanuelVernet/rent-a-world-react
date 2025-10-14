class PagesController < ApplicationController

  def home
    @worlds = World.includes(:user, :tags)
  end

  # Inertia
  def inertia_home
    render inertia: "Pages/Home", props: {
      worlds: World.includes(:user, :tags)
    }
    raise
  end
end
