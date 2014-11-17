class GenderDetector
  class Version
    MAJOR = 0
    MINOR = 1
    PATCH = 2

    def self.to_s
      [MAJOR, MINOR, PATCH].compact.join('.')
    end
  end

  VERSION = Version.to_s
end
