class PagesController < ApplicationController

  def home
    @worlds = World.includes(:user, :tags)
  end

  # Inertia
  def inertia_home
    # render inertia: "InertiaHome", props: {
    #   worlds: World.includes(:user, :tags)
    # }
    #   Rails.logger.info props.as_json

    worlds = World.includes(:user, :tags)
    # Rails.logger.info worlds.as_json
    render inertia: "InertiaHome", props: { worlds: worlds }
    # raise
  end
end

# pages/InertiaHome.jsx