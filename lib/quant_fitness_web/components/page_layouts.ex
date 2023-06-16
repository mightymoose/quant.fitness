defmodule QuantFitnessWeb.PageLayouts do
  use Phoenix.Component

  slot :header

  def stacked(assigns) do
    ~H"""
    <header class="bg-white shadow-sm">
      <div class="mx-auto max-w-7xl px-4 py-4 sm:px-6 lg:px-8">
        <%= render_slot(@header) %>
      </div>
    </header>

    <main>
      <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
        <%= render_slot(@inner_block) %>
      </div>
    </main>
    """
  end
end
