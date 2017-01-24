module ApplicationHelper
  # the splat operator (*), any arguments passed from this point will be available in the method as an array. Here that array can be referenced as parts.
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end
end
