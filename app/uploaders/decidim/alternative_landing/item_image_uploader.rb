# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    # This class deals with uploading item images to content blocks.
    class ItemImageUploader < RecordImageUploader
      set_variants do
        {
          square: { resize_to_fill: [960, 960] },
          landscape: { resize_to_fill: [960, 540] }
        }
      end

      def max_image_height_or_width
        4000
      end
    end
  end
end
