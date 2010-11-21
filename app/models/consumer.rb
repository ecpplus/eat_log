class Consumer < OAuth::Consumer
  def initialize
    super(CONSUMER_KEY, CONSUMER_SECRET, :site => SITE)
  end
end
