class Mailer
  include ActiveModel::Model

  attr_accessor :name, :email, :title, :message, :recipients, :template

  validates :email,   presence: true
  validates :message, presence: true

  def template_msg
    self.template.gsub('%name%', self.name).gsub('%email%', self.email).gsub('%title%', self.title).gsub('%message%', self.message).html_safe
  end
end