=begin
    This terminal app is designed to help the user select a country
    to travel to and access information about the destination and then
    link to a site to book the holiday
=end

require "./country_class" #Have moved class to new file country_class
require "tty-prompt" #used for a menu prompt
require "tty-table" #used to display translations as a table
require "tty-font" #gives the larger font for destination
require "colorize" #gives text colour throughout
require "launchy" #links to a booking site

prompt = TTY::Prompt.new
font = TTY::Font.new(:doom)


#information for the countries, relate to things to do, what to pack, common phrases and climate
bali = {
    "do" => ["explore and hike volcacnos jungle and waterfalls", "monkey forest",
        "relax at the beach", "indulge at world class spas"],
    "list" => ["swimwear", "light clothing", "hat", "sunglasses", "sandles/thongs", 
        "sarong"],
    "translate" => {"thank you" => "terima Kasih", "no" => "tidak", "yes" => "ya",
        "i dont understand" => "saya tidak mengerti"},
    "climate" => "tropical warm and humid all year round average 26-27C with 85-90% humidity"
}


japan = {
    "do" => ["universal studios Disney Sea or Disneyland", "Explore the temples", 
   "Cherry blosssom festival", "skiing", "view the atomic bomb dome and museum"],
"list" => ["light cool clothes in summer", "hat", "sunglasses", "sandles/thongs",
    "warmer clothes for winter", "thermals", "jackets", "snow gear", "gloves scarf",
     "rain jacket"],
"translate" => {"hello" => "konnichiwa", "no" => "iie", "yes" => "hai",
    "do you speak English?" => "seigo o hanasemasu ka", "please" => "o-negai shimasu",
     "thank you" => "arigato"},
"climate" => "tropical warm and humid summer especially in the south June to August 
    cold winter December to February particularly in the north with snow"
}

france = {
"do" => ["Eiffel tower", "Explore the Lourve museum", "cruise the Seine river", "see the Arc de Triomph",
    "fun at Disneyland", "indulge in pastries, cheese and sample the wine from the different wine regions",
     "try escargot or Grenouille"],
"list" => ["light cool clothes in summer", "hat", "sunglasses", "sandals", "a blazer", "an umbrella",
    "warmer clothes for winter", "layer warm clothing", "jackets", "snow gear", "gloves and scarf", "an umbrella"],
"translate" => {"hello" => "bonjour", "no" => "non", "yes" => "oui", "do you speak English?" => "parlez-vous anglais",
    "please" => "S'il vous plait", "thank you" => "merci", "I love you" => "je t'aime"},
"climate" => "warm summer especially in coastal regions cold snowy winters particularly in mountainous areas"
}

germany = {
"do" => ["visit Dachau concentration camp memorial site", "Explore castles", "visit the memorial of the Berlin wall",
    "see Cologne cathedral", "enjoy the East Side Gallery"],
"list" => ["light cool clothes in summer", "hat", "sunglasses", "sandles/thongs", "warmer clothes for winter",
    "thermals", "jackets", "snow gear", "gloves scarf", "rain jacket"],
"translate" => {"Do you speak English" => "sprechen sie English", "no" => "nein", "yes" => "ja",
    "I'm lost" => "Ich habe mich ver laufen", "please" => "bitte", "thank you" => "danke"},
"climate" => "mild Summer June to August with average maximum temps around 22-24C 
    very cold winters December to February with average daily temps around 0C and with cold waves from Siberia it can drop to -20C"
}

italy = {
"do" => ["indulge in pizza and pasta", "Explore the valley of temples, the coliseum, Saint Mark's Basilica",
    "climb Mt Vesuvius", "hold up The Leaning Tower of Pisa", "throw a coin in the Trevi Fountain", "trip to Pompeii"],
"list" => ["light cool clothes in summer", "hat", "sunglasses", "comfy shoes", "pashmina or shawl for religious sites",
    "warmer clothes for winter", "jackets", "gloves and scarf"],
"translate" => {"Do you speak English" => "parla inglese?", "no" => "no", "yes" => "si",
    "can I have the menu please?" => "potrei avere il menu, per favore?", "please" => "per favoure",
     "thank you" => "grazie", "hello/goodbye" => "ciao"},
"climate" => "warm dry Summers June to August with average maximum temps around 28-33C, but can be up around 40C 
Northern and mountainous regions have colder winters December to February while southern Italy is more mild"
}

maldives = {
"do" => ["indulge in massage at the spa", "relax  by the pool or on the beach", "go snorkelling or diving",
    "take a cruise", "enjoy a party", "indulge at an underwater spa"],
"list" => ["light cool cotton or linen clothes ", "hat", "sunglasses", "thongs/sandals", "swimwear"],
"translate" => {"Do you speak English" => "ingireysin vaahaka dhakkan ingeytha?", "no" => "noon", "yes" => "aan",
    "hello" => "assalaamu alaikum"},
"climate" => "hot tropical climate year round, average highs around 30C and lows around 25C humidity around 80%"
}

nz = {
"do" => ["take in the picturesque lanscape", "often referred to as an adventure playground", "bungy jumping", "jet boating",
    "skiing", "take in some Maori culture", "hiking"],
"list" => ["light cool cotton or linen clothes ", "hat", "sunglasses", "thongs/sandals", "swimwear"],
"translate" => {"added to most sentences as in it was cold today eh" => "Eh", "good, awesome, cool, cheers" => "chur",
    "referring to a mate" => "cuzzy or bro", "thongs or sandals"  => "jandals", "an eski or cooler" => "chilly bin"},
"climate" => "known as the land of the long white cloud expect mild temps and fairly high rainfall inland alpine regions
 of the south island can be as cold as -10C while coastal regions are more mild with max temps around 10-15C 
 in winter June to August Summer December to February average max temps between 20-30C"
}

# Class file would be here if in one file. Have moved class to new file country_class

puts "Welcome, if you are looking for a travel destination suggestion lets begin"

#putting in user preferences regarding budget, climate and experience prefrences
begin
    puts "What is your budget?"
    budget = gets.chomp.to_i
    if budget < 1000
        puts font.write("you are off to Bali").colorize(:green)
        destination = "bali"    
    else
        puts "do you prefer warm or cold climates?"
        climate = gets.chomp.downcase
        if climate == "cold"
            puts "do you most prefer adventure, history or food?"
            activity = gets.chomp.downcase
            if (climate == "cold" && activity == "adventure") && (budget < 2000)
                puts font.write("your off to NZ").colorize(:green)
                destination = "nz"
            elsif (climate == "cold" && activity == "history") && (budget > 2000)
                puts font.write("your off to Germany").colorize(:green)
                destination = "germany"
            elsif (climate == "cold" && activity == "food") && (budget > 3000)
                puts font.write("your off to France").colorize(:green)
                destination = "france"
            else
                puts font.write("your going to Japan").colorize(:green)
                destination = "japan"
            end 

        else
            puts "do you prefer history, food or relaxation?"
            activity = gets.chomp.downcase
            if (climate == "warm" && activity == "history" || activity == "food" ) && (budget > 4000)
                puts font.write("your off to Italy").colorize(:green)
                destination = "italy"
            elsif (climate == "warm" && activity == "relaxation") && (budget > 4000)
                puts font.write("your off to the Maldives").colorize(:green)
                destination = "maldives"
            else 
                puts font.write("your going to Japan").colorize(:green)
                destination = "japan"
            end 
            
        end
    end 
rescue 
    puts "please enter a valid entry"
end


# created destinations
bali = Country.new(bali["do"], bali["translate"], bali["climate"], bali["list"], "Balinese")
japan = Country.new(japan["do"], japan["translate"], japan["climate"], japan["list"], "Japanese")
france = Country.new(france["do"], france["translate"], france["climate"], france["list"], "French")
germany = Country.new(germany["do"], germany["translate"], germany["climate"], germany["list"], "Germen")
italy = Country.new(italy["do"], italy["translate"], italy["climate"], italy["list"], "Italian")
maldives = Country.new(maldives["do"], maldives["translate"], maldives["climate"], maldives["list"], "Maldives")
nz = Country.new(nz["do"], nz["translate"], nz["climate"], nz["list"], "Kiwi")

destination_list = {'bali' => bali, 'japan' => japan, 'france' => france, 'germany' => germany, 'italy' => italy,
    'maldives' => maldives, 'nz' => nz}


country = destination_list[destination]

=begin 
    once the user has been given their destination they can then choose to see information about:
    1. activities to do in the country
    2. some local translations of common phrases
    3. Basic climate information
    4. a list of clothes or items they should pack
    the user can continue to click through these until they click quit
=end

quit = false
    until quit do
        user_input = prompt.select("please select from the following options") do |menu|
        menu.choice "What to do"
        menu.choice "Get some common local phrases"
        menu.choice "need some climate info"
        menu.choice "What to pack"
        menu.choice "book my flights"
        menu.choice "quit"
    end

    case user_input

        when "What to do"
            country.to_do()
        when "Get some common local phrases"
            country.translate()
        when "need some climate info"
            country.climate()
        when "What to pack"
            country.packing()
        when "book my flights"
            Launchy.open("https://www.expedia.com.au/")
        when "quit"
            quit = true
        end
end


