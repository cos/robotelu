class LogEntry < ActiveRecord::Base  
  belongs_to :subject, :polymorphic => true
  
  def initialize
    super
    self.text = ''
  end
  
  def << (s)
    self.text += s+"\n"
    save!
  end
  
  def to_s
    title
  end
end