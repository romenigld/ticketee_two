class Comment < ActiveRecord::Base
  belongs_to :previous_state, class_name: "State"
  belongs_to :state
  belongs_to :ticket
  belongs_to :author, class_name: "User"

  attr_accessor :tag_names

  scope :persisted, lambda { where.not(id: nil) }

  validates :text, presence: true

  delegate :project, to: :ticket

  before_create :set_previous_state
  after_create :set_ticket_state
  # You want to use an after_create here so that the tags aren’t associated prematurely with a ticket, which they would be if you used a before_create. When you add things to an association with methods like ticket.tags << tag, you don’t have to save anything for that association to be created; it happens on the spot. So if the comment isn’t valid and doesn’t get saved, the tags would still be added—oops!
  after_create :associate_tags_with_ticket
  after_create :author_watches_ticket

  private

  def set_previous_state
    self.previous_state = ticket.state
  end

  def set_ticket_state
    ticket.state = state
    ticket.save!
  end

  def associate_tags_with_ticket
    if tag_names
      tag_names.split.each do |name|
        ticket.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

  def author_watches_ticket
    if author.present? && !ticket.watchers.include?(author)
      ticket.watchers << author
    end
  end
end
