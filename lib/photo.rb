class Photo

  def initialize(data)
    @data = data
  end

  def title
    @data.find_first('title').content
  end

  def image
    @data.find_first('media:content')['url'].sub('_b.jpg', '_z.jpg')
  end

  def link
    @data.find_first('link').content
  end

  def width
    @width ||= @data.find_first('media:content')['width'].to_i
  end

  def height
    @height ||= @data.find_first('media:content')['height'].to_i
  end

  def pixel_area
    width * height
  end

  def aspect_ratio
    @aspect_ratio ||= height.to_f / width.to_f
  end

  def percentages
    {
      :wide => magic_percentage(0.441),
      :big => magic_percentage(0.902),
      :small => magic_percentage(0.9),
      :tall => magic_percentage(1.84),
      :extrabig => magic_percentage(1.363)
    }
  end

  def to_hash
    {
      title: title,
      image: image,
      link: link,
      width: width,
      height: height,
      pixel_area: pixel_area,
      aspect_ratio: aspect_ratio,
      percentages: percentages
    }
  end

  private

  def magic_percentage(ratio)
    answer = 103
    return "auto #{answer}%" if aspect_ratio < ratio
    "#{answer}% auto"
  end

end
