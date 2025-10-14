class PagesController < ApplicationController

  def home
    @worlds = World.includes(:user, :tags)
  end

  # Inertia
  def inertia_home
    render inertia: "InertiaHome", props: {
      worlds: World.includes(:user, :tags)
    }
  end
end

# pages/InertiaHome.jsx