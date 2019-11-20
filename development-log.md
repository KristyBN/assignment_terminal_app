# Development log

## 14 November 2019 - Split Code

All code is currently working however now needs to be split as currently in one long block. By splitting the code it will help neaten up the code and make it easier to read, it will also help to make it easier to update and change portions of the code without disturbing the rest of the code. 

### Difficulties
It would have been nice to split the destination information out of the main code. <br>
<br>

```ruby 
    bali_do = ["explore and hike volcacnos jungle and waterfalls", "monkey  forest", "relax at the beach", "indulge at world class spas"],
    bali_list = ["swimwear", "light clothing", "hat", "sunglasses",          "sandles/thongs", "sarong"],
    bali_translate = {"thank you" => "terima Kasih", "no" => "tidak", "yes" => "ya", "i dont understand" => "saya tidak mengerti"},
    bali_climate = "tropical warm and humid all year round average 26-27C with 85-90% humidity"
```
Unfortunately as my code refers to this information constantly throughout, it isn't possible to split out and then require.


### Outcome
I have chosen to move the class out which relates to the Country and the related methods which are held within. This can still be called upon importing in via the "require" command <br>
<br>

```ruby
class Country
    attr_reader :phrases, :activities, :climate, :list, :language
    def initialize(activities, phrases, climate, list, language)
        @activities = activities 
        @phrases = phrases
        @climate = climate
        @list = list
        @language = language
    end

    def to_do()
        for activity in @activities do
            puts box = TTY::Box.frame(activity.colorize(:green))
        end
    end

    def translate()
        heading = ["English", @language]
        row = []
        @phrases.each do |au, translation|
            column = [au, translation]
            row.push(column)   
        end
        table = TTY::Table.new(heading, row)
        puts table.render(:unicode)
    end

    def climate()
       puts box = TTY::Box.frame(@climate.colorize(:blue))
    end

    def packing()
        puts @list
    end
  
end
```
## 23 November 2019 - Refactoring Code
### The Problem
While the code works, it doesn't seem to be DRY and probably not as efficient, it also doesn't look very good with in the code. <br>
eg.
<br>

```ruby 
    bali_do = ["explore and hike volcacnos jungle and waterfalls", "monkey  forest", "relax at the beach", "indulge at world class spas"],
    bali_list = ["swimwear", "light clothing", "hat", "sunglasses",          "sandles/thongs", "sarong"],
    bali_translate = {"thank you" => "terima Kasih", "no" => "tidak", "yes" => "ya", "i dont understand" => "saya tidak mengerti"},
    bali_climate = "tropical warm and humid all year round average 26-27C with 85-90% humidity"
```
### The resolve
I have decided to put the information into a hash, as this will be more efficient, easier to read and more accessible. <br>
<br>
```ruby
bali = {
    "do" => ["explore and hike volcacnos jungle and waterfalls", "monkey forest",
        "relax at the beach", "indulge at world class spas"],
    "list" => ["swimwear", "light clothing", "hat", "sunglasses", "sandles/thongs", 
        "sarong"],
    "translate" => {"thank you" => "terima Kasih", "no" => "tidak", "yes" => "ya",
        "i dont understand" => "saya tidak mengerti"},
    "climate" => "tropical warm and humid all year round average 26-27C with 85-90% humidity"
}
```
This was a straight forward change, which has made the code easier to read, is easily accessed and more efficient to run.