require 'rails_helper'

RSpec.describe ImageVariants, type: :enum do
  let!(:lossy_settings) do
    {
      format: :jpeg,
      saver: {
        optimize_coding: true,
        quality: 85,
        subsample_mode: "on",
        strip: true
      }
    }
  end

  describe ".dimensions_for_style" do
    it "returns the width/height for the given size for a given style" do
      expect(ImageVariants.dimensions_for_style(:header, :medium)).to eq([1500, 500])
      expect(ImageVariants.dimensions_for_style(:square, :medium)).to eq([256, 256])
    end

    it "raises if you specify an invalid size" do
      expect {
        ImageVariants.dimensions_for_style(:square, :smallish)
      }.to raise_error(ArgumentError, "smallish not found. Expected one of small, medium, large")
    end

    it "raises if you specify an invalid style" do
      expect {
        ImageVariants.dimensions_for_style(:duck_shaped, :small)
      }.to raise_error(ArgumentError, "duck_shaped not found. Expected one of header, square")
    end
  end

  describe ".variant_for_image" do
    it "returns an ActiveStorage variant for the medium size & default quality if you don't specify", :aggregate_failures do
      lossy_variant = instance_double(ActiveStorage::Variant)
      lossy_image = instance_double(ActiveStorage::Blob, content_type: "image/jpeg", variant: lossy_variant)

      expect(ImageVariants.variant_for_image(lossy_image)).to eq(lossy_variant)
      expect(lossy_image).to have_received(:variant).with(:medium_lossy)

      lossless_variant = instance_double(ActiveStorage::Variant)
      lossless_image = instance_double(ActiveStorage::Blob, content_type: "image/png", variant: lossless_variant)

      expect(ImageVariants.variant_for_image(lossless_image)).to eq(lossless_variant)
      expect(lossless_image).to have_received(:variant).with(:medium_lossless)
    end

    it "returns a variant for the given size & quantity" do
      lossless_large_variant = instance_double(ActiveStorage::Variant)
      lossless_large_image = instance_double(ActiveStorage::Blob, content_type: "image/jpeg", variant: lossless_large_variant)

      expect(
        ImageVariants.variant_for_image(
          lossless_large_image,
          size: :large,
          quality: :lossless
        )
      ).to eq(lossless_large_variant)
      expect(lossless_large_image).to have_received(:variant).with(:large_lossless)
    end

    it "raises if you don't provide an image argument" do
      expect {
        ImageVariants.variant_for_image(nil)
      }.to raise_error(ArgumentError, "image must be specified")
    end
  end

  describe ".variant_name_for_image" do
    let(:image) { instance_double(ActiveStorage::Blob, content_type: "image/jpeg") }

    it "returns a medium-sized variant by default if you don't specify size" do
      expect(ImageVariants.variant_name_for_image(image)).to eq(
        :medium_lossy
      )
    end

    it "raises if you don't provide an image argument" do
      expect {
        ImageVariants.variant_name_for_image(nil)
      }.to raise_error(ArgumentError, "image must be specified")
    end

    it "raises if you provide an invalid size argument" do
      expect {
        ImageVariants.variant_name_for_image(image, size: :smallish)
      }.to raise_error(ArgumentError, "smallish not found. Expected one of small, medium, large")
    end

    context "quality is specified" do
      it "returns the variant name for the size and quality combination" do
        expect(ImageVariants.variant_name_for_image(image, quality: :lossless)).to eq(
          :medium_lossless
        )
      end
    end

    context "quality is not specified" do
      context "image is a PNG" do
        let(:image) { instance_double(ActiveStorage::Blob, content_type: "image/png") }

        it "returns lossless variants" do
          expect(ImageVariants.variant_name_for_image(image, size: :large)).to eq(
            :large_lossless
          )
        end
      end

      context "image is a lossy type" do
        it "returns lossy variants" do
          expect(ImageVariants.variant_name_for_image(image, size: :large)).to eq(
            :large_lossy
          )
        end
      end
    end
  end

  describe ".variants_for_style" do
    it "returns a hash with all possible variants for a given style" do
      expect(ImageVariants.variants_for_style(:header)).to eq(
        {
          small_lossy: ImageVariants::HEADER[:small].merge(ImageVariants::QUALITIES[:lossy]),
          medium_lossy: ImageVariants::HEADER[:medium].merge(ImageVariants::QUALITIES[:lossy]),
          large_lossy: ImageVariants::HEADER[:large].merge(ImageVariants::QUALITIES[:lossy]),
          small_lossless: ImageVariants::HEADER[:small].merge(ImageVariants::QUALITIES[:lossless]),
          medium_lossless: ImageVariants::HEADER[:medium].merge(ImageVariants::QUALITIES[:lossless]),
          large_lossless: ImageVariants::HEADER[:large].merge(ImageVariants::QUALITIES[:lossless]),
        }
      )
      expect(ImageVariants.variants_for_style(:square)).to eq(
        {
          small_lossy: ImageVariants::SQUARE[:small].merge(ImageVariants::QUALITIES[:lossy]),
          medium_lossy: ImageVariants::SQUARE[:medium].merge(ImageVariants::QUALITIES[:lossy]),
          large_lossy: ImageVariants::SQUARE[:large].merge(ImageVariants::QUALITIES[:lossy]),
          small_lossless: ImageVariants::SQUARE[:small].merge(ImageVariants::QUALITIES[:lossless]),
          medium_lossless: ImageVariants::SQUARE[:medium].merge(ImageVariants::QUALITIES[:lossless]),
          large_lossless: ImageVariants::SQUARE[:large].merge(ImageVariants::QUALITIES[:lossless]),
        }
      )
    end

    it "raises if you specify an invalid style" do
      expect {
        ImageVariants.variants_for_style(:duck_shaped)
      }.to raise_error(ArgumentError, "duck_shaped not found. Expected one of header, square")
    end
  end
end
