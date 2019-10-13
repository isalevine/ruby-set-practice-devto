# originally copied/based on Friendly Character Generator backend-api's seeds.rb file



# for text normalization demo:
# ============================

# string = "When you choose this domain at 1st level, you gain proficiency with heavy armor."

# regex1 = /(-)|(--)|(\.\.\.)|(_)/          # separate words joined by hyphens, m-dashes, underscores, and elipses
# regex2 = /([.,:;?!"'`@#$%^&*()+={}-])/    # remove all other punctuation
# string.gsub!(regex1, " ")
# string.gsub!(regex2, "")
# string.downcase!

# puts string
# #=> "when you choose this domain at 1st level you gain proficiency with heavy armor"



require 'set'

string = "when you choose this domain at 1st level you gain proficiency with heavy armor"

# array = string.split(" ")
# set = Set.new(array)

# puts set



filter_words = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]

array = string.split(" ")

set = Set.new
array.each do |str|
    if !filter_words.include?(str)
        set.add(str)
    end
end

puts set


