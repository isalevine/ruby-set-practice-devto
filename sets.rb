# originally copied/based on Friendly Character Generator backend-api's seeds.rb file


require 'set'

string = "When you choose this domain at 1st level, you gain proficiency with heavy armor."

regex1 = /(-)|(--)|(\.\.\.)|(_)/
regex2 = /([.,:;?!"'`@#$%^&*()+={}-])/

string.downcase!
string.gsub!(regex1, " ")
string.gsub!(regex2, "")
array = string.split(" ")
set = Set.new(array)




# filter_words = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
#     "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
# ]