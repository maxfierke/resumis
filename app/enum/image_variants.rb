module ImageVariants
  QUALITIES = {
    lossy: {
      format: :jpeg,
      saver: {
        optimize_coding: true,
        quality: 85,
        subsample_mode: "on",
        strip: true
      }
    },
    lossless: { saver: { strip: true } },
  }.freeze
  SQUARE = {
    small: { resize_to_fill: [100, 100] },
    medium: { resize_to_fill: [256, 256] },
    large: { resize_to_fill: [512, 512] },
  }.freeze
  HEADER = {
    small: { resize_to_fill: [800, 267, { crop: :attention }] },
    medium: { resize_to_fill: [1500, 500, { crop: :attention }] },
    large: { resize_to_fill: [3000, 1000, { crop: :attention }] },
  }.freeze
  SIZES = %i[small medium large].freeze
  STYLES = {
    header: HEADER,
    square: SQUARE,
  }.freeze

  def self.dimensions_for_style(style, size)
    validate_size!(size)
    validate_style!(style)

    STYLES.dig(style, size, :resize_to_fill)[0...2]
  end

  def self.variant_for_image(image, **kwargs)
    variant_name = variant_name_for_image(image, **kwargs)

    image.variant(variant_name)
  end

  def self.variant_name_for_image(image, size: :medium, quality: nil)
    unless image
      raise ArgumentError, "image must be specified"
    end

    validate_size!(size)

    quality ||= if image.content_type == "image/png"
      :lossless
    else
      :lossy
    end

    validate_quality!(quality)

    :"#{size}_#{quality}"
  end

  def self.variants_for_style(style)
    validate_style!(style)

    variants = {}

    QUALITIES.each do |quality, quality_opts|
      STYLES[style].each do |size, size_opts|
        variants[:"#{size}_#{quality}"] = size_opts.merge(quality_opts)
      end
    end

    variants
  end

  def self.validate_quality!(quality)
    unless QUALITIES.key?(quality)
      raise ArgumentError, "#{quality} not found. Expected one of #{QUALITIES.keys.join(", ")}"
    end
  end
  private_class_method :validate_quality!

  def self.validate_size!(size)
    unless SIZES.include?(size)
      raise ArgumentError, "#{size} not found. Expected one of #{SIZES.join(", ")}"
    end
  end
  private_class_method :validate_size!

  def self.validate_style!(style)
    unless STYLES.key?(style)
      raise ArgumentError, "#{style} not found. Expected one of #{STYLES.keys.join(", ")}"
    end
  end
  private_class_method :validate_style!
end
