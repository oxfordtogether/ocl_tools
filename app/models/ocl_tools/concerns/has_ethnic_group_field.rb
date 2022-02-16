module OclTools
  module Concerns
    module HasEthnicGroupField
      extend ActiveSupport::Concern

      class_methods do
        def has_ethnic_group_field(field_name)
          better_options_field field_name do
            option :prefer_not_to_say, "Prefer not to say"
            option :unknown, "Unknown"
            option :english_welsh_scottish_northern_irish_british, "English, Welsh, Scottish, Northern Irish or British"
            option :irish, "Irish"
            option :gypsy_or_irish_traveller, "Gypsy or Irish Traveller"
            option :any_other_white_background, "Any other White background"
            option :white_and_black_caribbean, "White and Black Caribbean"
            option :white_and_black_african, "White and Black African"
            option :white_and_asian, "White and Asian"
            option :any_other_mixed_multiple_ethnic_background, "Any other Mixed or Multiple ethnic background"
            option :indian, "Indian"
            option :pakistani, "Pakistani"
            option :bangladeshi, "Bangladeshi"
            option :chinese, "Chinese"
            option :any_other_asian_background, "Any other Asian background"
            option :african, "African"
            option :caribbean, "Caribbean"
            option :any_other_black_african_caribbean_background, "Any other Black, African or Caribbean background"
            option :arab, "Arab"
            option :any_other_ethnic_group, "Any other ethnic group"
          end

          define_singleton_method "#{field_name}_grouped_options_for_select" do
            GROUPED_ETHNIC_GROUPS
          end
        end
      end

      GROUPED_ETHNIC_GROUPS = [
        [
          nil,
          [
            ["Prefer not to say", :prefer_not_to_say],
            ["Unknown", :unknown],
          ],
        ],
        [
          "White",
          [
            ["English, Welsh, Scottish, Northern Irish or British", :english_welsh_scottish_northern_irish_british],
            ["Irish", :irish],
            ["Gypsy or Irish Traveller", :gypsy_or_irish_traveller],
            ["Any other White background", :any_other_white_background],
          ],
        ],
        [
          "Mixed or Multiple ethnic groups",
          [
            ["White and Black Caribbean", :white_and_black_caribbean],
            ["White and Black African", :white_and_black_african],
            ["White and Asian", :white_and_asian],
            ["Any other Mixed or Multiple ethnic background", :any_other_mixed_multiple_ethnic_background],
          ],
        ],
        [
          "Asian or Asian British",
          [
            ["Indian", :indian],
            ["Pakistani", :pakistani],
            ["Bangladeshi", :bangladeshi],
            ["Chinese", :chinese],
            ["Any other Asian background", :any_other_asian_background],
          ],
        ],
        [
          "Black, African, Caribbean or Black British",
          [
            ["African", :african],
            ["Caribbean", :caribbean],
            ["Any other Black, African or Caribbean background", :any_other_black_african_caribbean_background],
          ],
        ],
        [
          "Other ethnic group",
          [
            ["Arab", :arab],
            ["Any other ethnic group", :any_other_ethnic_group],
          ],
        ],
      ]
    end
  end
end
