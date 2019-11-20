=begin
    class file for travel.rb, compartmentalised. 
    this holds the country class and methods to be used 
=end
require "tty-table"
require "colorize"
require "tty-box"


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
