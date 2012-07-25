module SexMachine

  class Detector
    COUNTRIES = [ :great_britain, :ireland, :usa, :italy, :malta, :portugal, :spain, :france, :belgium, :luxembourg, :the_netherlands, :east_frisia,
                  :germany, :austria, :swiss, :iceland, :denmark, :norway, :sweden, :finland, :estonia, :latvia, :lithuania, :poland, :czech_republic,
                  :slovakia, :hungary, :romania, :bulgaria, :bosniaand, :croatia, :kosovo, :macedonia, :montenegro, :serbia, :slovenia, :albania,
                  :greece, :russia, :belarus, :moldova, :ukraine, :armenia, :azerbaijan, :georgia, :the_stans, :turkey, :arabia, :israel, :china,
                  :india, :japan, :korea, :vietnam, :other_countries ]

    def initialize(fname=nil)
      fname ||= File.expand_path('../data/nam_dict.txt', __FILE__)
      parse fname
    end
    
    def parse(fname)
      @names = {}
      open(fname, "r:iso8859-1:utf-8") { |f|
        f.each_line { |line|
          eat_name_line line
        }
      }
    end
    
    def get_gender(name, country = nil)
      if not @names.has_key?(name)
        :andy
      elsif country.nil?
        most_popular_gender(name) { |country_values|
          country_values.split("").select { |l| l.strip != "" }.length
        }
      elsif COUNTRIES.include?(country)
        index = COUNTRIES.index(country)
        most_popular_gender(name) { |country_values|
          country_values[index].ord
        }
      else
        raise "No such country: #{country}"
      end
    end
  
    private
    def eat_name_line(line)
      return if line.start_with?("#") or line.start_with?("=")
      
      parts = line.split(" ").select { |p| p.strip != "" }
      country_values = line.slice(30, line.length)

      case parts[0]
        when "M" then set(parts[1], :male, country_values)
        when "1M", "?M" then set(parts[1], :mostly_male, country_values)
        when "F" then set(parts[1], :female, country_values)
        when "1F", "?F" then set(parts[1], :mostly_female, country_values)
        when "?" then set(parts[1], :andy, country_values)
        else raise "Not sure what to do with a sex of #{parts[0]}"
      end
    end

    def most_popular_gender(name)
      return :andy unless @names.has_key?(name)
      
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
