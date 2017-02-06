module CapybaraMatchers
  def has_heading?(text)
    has_css?("h1, h2, h3, h4, h5, h6", text: text)
  end
end

Capybara::Session.include(CapybaraMatchers)


# The has_heading method we define here could also be written as another custom RSpec matcher, like the following:
# RSpec::Matchers.define :have_heading do |text|
#   match do |page|
#     page.has_css?("h1, h2, h3, h4, h5, h6", text: text)
#   end
#
#   failure_message do
#     "Expected page to have heading '#{text}'"
#   end
#
#   failure_message_when_negated do |policy|
#     "Expected page not to have heading '#{text}'"
#   end
# end
# We think adding the method directly to Capybara::Session is more idiomatic,
# as it more closely matches how Capybara’s other matchers are implemented.
# You can also use both has_heading? and have_heading and get the same result.
