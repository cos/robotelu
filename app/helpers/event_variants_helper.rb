module EventVariantsHelper
  def time_column(record)
    record.time ? record.time.to_formatted_s(:time) : '-'
  end
  def date_column(record)
    record.date ? record.date.to_formatted_s(:short) : '-'
  end
  def crawler_column(record)
    link_to record.crawler.name, crawler_path(record.crawler)
  end
end
