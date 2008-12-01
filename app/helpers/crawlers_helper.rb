module CrawlersHelper
  def name_column(record)
    if record.is_a? Crawler
      link_to record.name, crawler_path(record)
    else
      record.name
    end
  end
end
