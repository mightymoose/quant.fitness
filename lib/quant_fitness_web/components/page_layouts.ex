defmodule QuantFitnessWeb.PageLayouts do
  use QuantFitnessWeb, :html

  def link_active_class(selected_tab, selected_tab), do: "bg-indigo-700 text-white"

  def link_active_class(_selected_tab, _tab),
    do: "text-white hover:bg-indigo-500 hover:bg-opacity-75"

  def stacked(assigns) do
    ~H"""
    <div class="min-h-full" x-data="{ showMobileMenu: false, showProfileDropdown: false }">
      <nav class="bg-indigo-600">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div class="flex h-16 items-center justify-between">
            <div class="flex items-center">
              <div class="hidden md:block">
                <div class="flex items-baseline space-x-4">
                  <.link
                    href={~p"/dashboard"}
                    class={"#{link_active_class(@selected_tab, "Dashboard")} rounded-md px-3 py-2 text-sm font-medium"}
                    aria-current="page"
                  >
                    Dashboard
                  </.link>
                  <.link
                    href={~p"/workouts"}
                    class={"#{link_active_class(@selected_tab, "Workouts")} rounded-md px-3 py-2 text-sm font-medium"}
                    aria-current="page"
                  >
                    Workouts
                  </.link>
                  <.link
                    href={~p"/exercises"}
                    class={"#{link_active_class(@selected_tab, "Exercises")} rounded-md px-3 py-2 text-sm font-medium"}
                    aria-current="page"
                  >
                    Exercises
                  </.link>
                </div>
              </div>
            </div>
            <div class="hidden md:block">
              <div class="ml-4 flex items-center md:ml-6">
                <div class="relative ml-3" x-cloak>
                  <div>
                    <button
                      type="button"
                      x-on:click="showProfileDropdown = !showProfileDropdown"
                      class="flex max-w-xs items-center rounded-full bg-indigo-600 text-sm focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-indigo-600"
                      id="user-menu-button"
                      aria-expanded="false"
                      aria-haspopup="true"
                    >
                      <span class="sr-only">Open user menu</span>
                      <span class="inline-block h-8 w-8 overflow-hidden rounded-full bg-gray-100">
                        <svg
                          class="h-full w-full text-gray-300"
                          fill="currentColor"
                          viewBox="0 0 24 24"
                        >
                          <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
                        </svg>
                      </span>
                    </button>
                  </div>
                  <div
                    x-show="showProfileDropdown"
                    x-transition:enter="transition ease-out duration-100"
                    x-transition:enter-start="opacity-0 scale-95"
                    x-transition:enter-end="opacity-100 scale-100"
                    x-transition:leave="transition ease-in duration-100"
                    x-transition:leave-start="opacity-100 scale-100"
                    x-transition:leave-end="opacity-0 scale-95"
                    x-on:click.outside="showProfileDropdown = false"
                    class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
                    role="menu"
                    aria-orientation="vertical"
                    aria-labelledby="user-menu-button"
                    tabindex="-1"
                  >
                    <!-- Active: "bg-gray-100", Not Active: "" -->
                    <a
                      href={~p"/users/settings"}
                      class="block px-4 py-2 text-sm text-gray-700"
                      role="menuitem"
                      tabindex="-1"
                      id="user-menu-item-1"
                    >
                      Settings
                    </a>
                    <.link
                      href={~p"/users/log_out"}
                      method="delete"
                      class="block px-4 py-2 text-sm text-gray-700"
                    >
                      Sign out
                    </.link>
                  </div>
                </div>
              </div>
            </div>
            <div class="-mr-2 flex md:hidden">
              <!-- Mobile menu button -->
              <button
                type="button"
                x-on:click="showMobileMenu = !showMobileMenu"
                class="inline-flex items-center justify-center rounded-md bg-indigo-600 p-2 text-indigo-200 hover:bg-indigo-500 hover:bg-opacity-75 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-indigo-600"
                aria-controls="mobile-menu"
                aria-expanded="false"
              >
                <span class="sr-only">Open main menu</span>
                <!-- Menu open: "hidden", Menu closed: "block" -->
                <svg
                  x-show="!showMobileMenu"
                  class="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  aria-hidden="true"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
                  />
                </svg>
                <!-- Menu open: "block", Menu closed: "hidden" -->
                <svg
                  x-show="showMobileMenu"
                  class="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  aria-hidden="true"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="md:hidden" id="mobile-menu" x-show="showMobileMenu" x-cloak>
          <div class="space-y-1 px-2 pb-3 pt-2 sm:px-3">
            <a
              href={~p"/dashboard"}
              class={"#{link_active_class(@selected_tab, "Dashboard")} block rounded-md px-3 py-2 text-base font-medium"}
              aria-current="page"
            >
              Dashboard
            </a>
            <a
              href={~p"/workouts"}
              class={"#{link_active_class(@selected_tab, "Workouts")} block rounded-md px-3 py-2 text-base font-medium"}
              aria-current="page"
            >
              Workouts
            </a>
            <a
              href={~p"/exercises"}
              class={"#{link_active_class(@selected_tab, "Exercises")} block rounded-md px-3 py-2 text-base font-medium"}
              aria-current="page"
            >
              Exercises
            </a>
          </div>
          <div class="border-t border-indigo-700 pb-3 pt-4">
            <div class="flex items-center px-5">
              <div class="flex-shrink-0">
                <span class="inline-block h-10 w-10 overflow-hidden rounded-full bg-gray-100">
                  <svg class="h-full w-full text-gray-300" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
                  </svg>
                </span>
              </div>
              <div class="ml-3">
                <div class="text-base font-medium text-white"><%= @current_user.username %></div>
                <div class="text-sm font-medium text-indigo-300"><%= @current_user.email %></div>
              </div>
            </div>
            <div class="mt-3 space-y-1 px-2">
              <.link
                href={~p"/users/settings"}
                class="block rounded-md px-3 py-2 text-base font-medium text-white hover:bg-indigo-500 hover:bg-opacity-75"
              >
                Settings
              </.link>
              <.link
                href={~p"/users/log_out"}
                method="delete"
                class="block rounded-md px-3 py-2 text-base font-medium text-white hover:bg-indigo-500 hover:bg-opacity-75"
              >
                Sign out
              </.link>
            </div>
          </div>
        </div>
      </nav>
      <header class="bg-white shadow-sm">
        <%= render_slot(@header) %>
      </header>

      <main>
        <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
          <%= render_slot(@inner_block) %>
        </div>
      </main>
    </div>
    """
  end
end
