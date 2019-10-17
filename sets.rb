# originally copied/based on Friendly Character Generator backend-api's seeds.rb file



# for text normalization demo:
# ============================

# string = "When you choose this domain at 1st level, you gain proficiency with heavy armor."

# regex1 = /(-)|(--)|(\.\.\.)|(_)/          # separate words joined by hyphens, m-dashes, underscores, and ellipses
# regex2 = /([.,:;?!"'`@#$%^&*()+={}-])/    # remove all other punctuation
# string.gsub!(regex1, " ")
# string.gsub!(regex2, "")
# string.downcase!

# puts string
# #=> "when you choose this domain at 1st level you gain proficiency with heavy armor"



require 'set'

string = "when you choose this domain at 1st level you gain proficiency with heavy armor"

array = string.split(" ")
set = Set.new(array)

# set.each do |str|
#     puts str
# end



name_array = ["big", "sword", "knight"]

# .add
# ==========
# set.add("knight")

# name_array.each do |str|
# 	set.add(str)
# end

# set.add(name_array)



# <<
# ==========
# name_array.each do |str|
# 	set << str
# end



# .merge
# ==========
# set.merge(name_array)



# .add?
# ==========
# set.add?("armor")

# duplicate_counter = 0
# duplicate_array = ["proficiency", "with", "heavy", "armor"]
# duplicate_array.each do |str|
#     if set.add?(str) == nil
#         duplicate_counter += 1
#     end
# end
# puts duplicate_counter





remove_array = ["when", "you", "this", "at", "with"]

# .delete
# ==========
# set.delete("when")

# remove_array.each do |str|
#     set.delete(str)
# end

# set.delete(remove_array)



# .subtract
# ==========
# set.subtract(remove_array)



# .delete?
# ==========
# set.delete?("shield")









# part 2: object lookup
# =====================

# NOTE: Per this thread, do NOT assume Sets are ALWAYS more efficient for these operations
# (or, rather, that these are not necessarily the most useful/accurate metrics to use...)
# https://www.reddit.com/r/ruby/comments/154226/where_is_set_really_faster_than_array/

# include benchmark comparisons for:
#   - include? - (beginning, middle, end)
#   - delete / delete_if (?) - (beginning, middle, end)
#   - replace
#   - .subset? vs. (a1 & a2) == a2 - per: https://stackoverflow.com/a/10567468
#   - == (?)

require 'benchmark'


filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]

filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]

replace_set = Set["big", "sword", "knight"]

replace_array = ["big", "sword", "knight"]

sub_set = Set["a", "they", "at"]

sub_array = ["a", "they", "at"]

match_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]

match_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]


n = 5000000

Benchmark.bm(34) do |x|
    x.report("Set   .include? (beginning)       :")     { n.times do; filter_set.include?("a")   ; end}
    x.report("Array .include? (beginning)       :")     { n.times do; filter_array.include?("a")   ; end}
    x.report("Set   .include? (middle)          :")     { n.times do; filter_set.include?("they"); end}
    x.report("Array .include? (middle)          :")     { n.times do; filter_array.include?("they"); end}
    x.report("Set   .include? (end)             :")     { n.times do; filter_set.include?("at")  ; end}
    x.report("Array .include? (end)             :")     { n.times do; filter_array.include?("at")  ; end}
end

puts

Benchmark.bm(34) do |x|
    x.report("Set   .delete (beginning)         :")     { n.times do; filter_set.delete("a")   ; end}
    x.report("Array .delete (beginning)         :")     { n.times do; filter_array.delete("a")   ; end}
    x.report("Set   .delete (middle)            :")     { n.times do; filter_set.delete("they"); end}
    x.report("Array .delete (middle)            :")     { n.times do; filter_array.delete("they"); end}
    x.report("Set   .delete (end)               :")     { n.times do; filter_set.delete("at")  ; end}
    x.report("Array .delete (end)               :")     { n.times do; filter_array.delete("at")  ; end}
end

puts

# .replace for Sets is actually SLOWER?!?
Benchmark.bm(34) do |x|
    x.report("Set   .replace                    :")     { n.times do; filter_set.replace(replace_set)     ; end}
    x.report("Array .replace                    :")     { n.times do; filter_array.replace(replace_array)   ; end}
end

puts

# .subset is faster for TRUE, but slower for FALSE -- how/why?!?!
Benchmark.bm(34) do |x|
    x.report("Set   .subset?          (true)    :")     { n.times do; sub_set.subset?(filter_set)                       ; end}
    x.report("Array .(a1 - a2) == a2  (true)    :")     { n.times do; (filter_array - sub_array) == sub_array           ; end}
    x.report("Set   .subset?          (false)   :")     { n.times do; replace_set.subset?(filter_set)                   ; end}
    x.report("Array .(a1 - a2) == a2  (false)   :")     { n.times do; (filter_array - replace_array) == replace_array   ; end}    
end

puts

# == for Sets is actually SLOWER?!?
Benchmark.bm(34) do |x|
    x.report("Set   ==  (true)                  :")     { n.times do; filter_set == match_set       ; end}
    x.report("Array ==  (true)                  :")     { n.times do; filter_array == match_array   ; end}
    x.report("Set   ==  (false)                 :")     { n.times do; filter_set == replace_set     ; end}
    x.report("Array ==  (false)                 :")     { n.times do; filter_array == replace_array ; end}
end



# array = string.split(" ")

# set = Set.new
# array.each do |str|
#     if !filter_set.include?(str)
#         set.add(str)
#     end
# end

# puts set


