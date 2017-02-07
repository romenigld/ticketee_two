module CapybaraFinders
  def list_item(content)
    find("ul:not(.actions) li", text: content)
  end
end

RSpec.configure do |c|
  c.include CapybaraFinders, type: :feature
end

# This method simply takes some text, finds a list item on the page (that isn’t an action link)
# with the specified content, and then returns it. Capybara will then use that element as the basis
# for all actions inside the block. It’s great to write these little helper methods that make your
# tests more readable, and it’s so easy to do!
