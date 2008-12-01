# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def state_column(record)
    record.state.to_s.humanize
  end
  def url_column(record)
    record.url ? link_to(record.url, 'http://'+record.url, {:target => '_blank'}) : '-'
  end
  def description_column(record)
    record.description
  end
end
