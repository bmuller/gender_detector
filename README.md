# Gender Detector

Gender Detector is a Ruby library that will tell you the most likely gender of a person based on first name.  It uses the underlying data from the program "gender" by Jorg Michael (described [here](http://www.autohotkey.com/community/viewtopic.php?t=22000)).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gender_detector'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install gender_detector
```

## Usage

Its use is pretty straightforward:

```ruby
require 'gender_detector'
d = GenderDetector.new

d.get_gender("Bob")
# => :male

d.get_gender("Sally")
# => :female

d.get_gender("Pauley")
# => :andy
```

The result will be one of `:andy` (androgynous), `:male`, `:female`, `:mostly_male`, or `:mostly_female`.  Any unknown names are considered andies.

Gender detection will work for names with non-ASCII characters as well:

```ruby
d.get_gender("Álfrún")
# => :female
```

Additionally, you can give preference to specific countries:

```ruby
d.get_gender("Jamie")
# => :female

d.get_gender("Jamie", :great_britain)
# => :mostly_male
````

If you have an alterative data file, you can pass that in as an optional filename argument to the `GenderDetector`.  Additionally, you can create a detector that is not case sensitive (default *is* to be case sensitive):

```ruby
d = GenderDetector.new(:case_sensitive => false)
d.get_gender "sally"
# => :female

d.get_gender "Sally"
# => :female
```

Try to avoid creating many `GenderDetectors`, as each creation means reading in the data file.

## Licenses
The gender_detector code is distributed under the GPLv3.  The data file nam_dict.txt is released under the GNU Free Documentation License.
