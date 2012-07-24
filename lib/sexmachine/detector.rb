module SexMachine

  class Detector
    def initialize(fname=nil)
      fname ||= File.expand_path('../data/nam_dict.txt', __FILE__)
      parse fname
    end
    
    def parse(fname)
      @names = {}
      open(fname, "r:iso8859-1:utf-8") { |f|
        f.each_line { |line|
          eatNameLine line
        }
      }
    end
    
    def get_gender(name)
      @names.fetch(name, :andy)
    end
  
    private
    def eatNameLine(line)
      return if line.start_with?("#") or line.start_with?("=")
      
      parts = line.split(" ").select { |p| p.strip != "" }
      
      if parts[0].include? "F"
        set parts[1], :female
      elsif parts[0].include? "M"
        set parts[1], :male
      else
        set parts[1], :andy
      end
    end

    def set(name, gender)
      # go w/ first option, don't reset
      return if @names.has_key? name
      
      if name.include? "+"
        [ '', '-', ' ' ].each { |replacement|
          set name.gsub("+", replacement), gender
        }
      else
        @names[name] = gender
      end
    end
  end

end
