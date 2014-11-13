require 'gender/detector/version'

require "unicode_utils/downcase"

module Gender

  class Detector
    COUNTRIES = [ :great_britain, :ireland, :usa, :italy, :malta, :portugal, :spain, :france, :belgium, :luxembourg, :the_netherlands, :east_frisia,
                  :germany, :austria, :swiss, :iceland, :denmark, :norway, :sweden, :finland, :estonia, :latvia, :lithuania, :poland, :czech_republic,
                  :slovakia, :hungary, :romania, :bulgaria, :bosniaand, :croatia, :kosovo, :macedonia, :montenegro, :serbia, :slovenia, :albania,
                  :greece, :russia, :belarus, :moldova, :ukraine, :armenia, :azerbaijan, :georgia, :the_stans, :turkey, :arabia, :israel, :china,
                  :india, :japan, :korea, :vietnam, :other_countries ]

    ISO_3166_MAPPING = {
      'AE' => :arabia, 'AL' => :albania, 'AM' => :armenia, 'AT' => :austria,
      'AU' => :usa, 'AZ' => :azerbaijan, 'BA' => :bosniaand, 'BE' => :belgium,
      'BG' => :bulgaria, 'BH' => :arabia, 'BY' => :belarus, 'CA' => :usa,
      'CH' => :swiss, 'CN' => :china, 'CZ' => :czech_republic, 'DE' => :germany,
      'DK' => :denmark, 'EE' => :estonia, 'EG' => :arabia, 'ES' => :spain,
      'FI' => :finland, 'FR' => :france, 'GB' => :great_britain, 'GE' => :georgia,
      'GR' => :greece, 'HK' => :china, 'HR' => :croatia, 'HU' => :hungary,
      'IE' => :ireland, 'IL' => :israel, 'IN' => :india, 'IS' => :iceland,
      'IT' => :italy, 'JP' => :japan, 'KP' => :korea, 'KR' => :korea,
      'KZ' => :the_stans, 'LT' => :lithuania, 'LU' => :luxembourg, 'LV' => :latvia,
      'MD' => :moldova, 'ME' => :montenegro, 'MK' => :macedonia, 'MT' => :malta,
      'NL' => :the_netherlands, 'NO' => :norway, 'PL' => :poland, 'PT' => :portugal,
      'QA' => :arabia, 'RO' => :romania, 'RS' => :serbia, 'RU' => :russia,
      'SA' => :arabia, 'SE' => :sweden, 'SI' => :slovenia, 'SK' => :slovakia,
      'TR' => :turkey, 'TW' => :china, 'UA' => :ukraine, 'US' => :usa,
      'UZ' => :the_stans, 'VN' => :vietnam
    }

    def initialize(opts = {})
      opts = {
        :filename => File.expand_path('../detector/data/nam_dict.txt', __FILE__),
        :case_sensitive => true,
        :unknown_value => :andy
      }.merge(opts)
      @filename = opts[:filename]
      @case_sensitive = opts[:case_sensitive]
      @unknown_value = opts[:unknown_value]
      parse opts[:filename]
    end

    def parse(fname)
      @names = {}
      open(fname, "r:iso8859-1:utf-8") { |f|
        f.each_line { |line|
          eat_name_line line
        }
      }
    end

    def knows_country?(country)
      COUNTRIES.include?(country) or ISO_3166_MAPPING.include?(country)
    end

    def name_exists?(name)
      name = UnicodeUtils.downcase(name) unless @case_sensitive
      @names.has_key?(name) ? name : false
    end

    def get_gender(name, country = nil)
      name = UnicodeUtils.downcase(name) unless @case_sensitive

      if not name_exists?(name)
        @unknown_value
      elsif country.nil?
        most_popular_gender(name) { |country_values|
          country_values.split("").select { |l| l.strip != "" }.length
        }
      elsif COUNTRIES.include?(country)
        most_popular_gender_in_country(name, country)
      elsif ISO_3166_MAPPING.include?(country)
        most_popular_gender_in_country(name, ISO_3166_MAPPING[country])
      else
        raise "No such country: #{country}"
      end
    end

    def inspect
      "#<#{self.class.name} filename=\"#{@filename}\" case_sensitive=#{@case_sensitive} unknown_value=#{@unknown_value}>"
    end

    private
    def most_popular_gender_in_country(name, country)
      index = COUNTRIES.index(country)
      most_popular_gender(name) { |country_values|
        country_values[index].ord
      }
    end

    def eat_name_line(line)
      return if line.start_with?("#") or line.start_with?("=")

      parts = line.split(" ").select { |p| p.strip != "" }
      country_values = line.slice(30, line.length)
      name = @case_sensitive ? parts[1] : UnicodeUtils.downcase(parts[1])

      case parts[0]
      when "M" then set(name, :male, country_values)
      when "1M", "?M" then set(name, :mostly_male, country_values)
      when "F" then set(name, :female, country_values)
      when "1F", "?F" then set(name, :mostly_female, country_values)
      when "?" then set(name, :andy, country_values)
      else raise "Not sure what to do with a gender of #{parts[0]}"
      end
    end

    def most_popular_gender(name)
      return @unknown_value unless @names.has_key?(name)

      max = 0
      best = @names[name].keys.first
      @names[name].each { |gender, country_values|
        count = yield country_values
        if count > max
          max = count
          best = gender
        end
      }
      best
    end

    def set(name, gender, country_values)
      if name.include? "+"
        [ '', '-', ' ' ].each { |replacement|
          set name.gsub("+", replacement), gender, country_values
        }
      else
        @names[name] ||= {}
        @names[name][gender] = country_values
      end
    end
  end
end
