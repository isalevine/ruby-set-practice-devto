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


# filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
# "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
# ]

# filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
#     "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
# ]

# replace_set = Set["big", "sword", "knight"]

# replace_array = ["big", "sword", "knight"]

# sub_set = Set["a", "they", "at"]

# sub_array = ["a", "they", "at"]

# match_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
# "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
# ]

# match_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
#     "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
# ]


n = 5000000
# n = 1000000


filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
Benchmark.bm(34) do |x|
    x.report("Set   .include? (beginning)       :")     { n.times do; filter_set.include?("a")   ; end}
    x.report("Array .include? (beginning)       :")     { n.times do; filter_array.include?("a")   ; end}
    x.report("Set   .include? (middle)          :")     { n.times do; filter_set.include?("they"); end}
    x.report("Array .include? (middle)          :")     { n.times do; filter_array.include?("they"); end}
    x.report("Set   .include? (end)             :")     { n.times do; filter_set.include?("at")  ; end}
    x.report("Array .include? (end)             :")     { n.times do; filter_array.include?("at")  ; end}
end


puts


filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
Benchmark.bm(34) do |x|
    x.report("Set   .add  (successful)          :") { 
        n.times do
            set = filter_set
            set.add("big")
        end
    }
    x.report("Array .push (successful)          :") { 
        n.times do
            array = filter_array
            array.push("big")                                     
        end
    }
    x.report("Set   .add  (failed)              :") { 
        n.times do
            set = filter_set
            set.add("they")
        end
    }
    x.report("Array .push (if not present)      :") { 
        n.times do
            array = filter_array
            if !array.include?("they")
                array.push("they")
            end   
        end
    }
end


puts


filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]

# NO IDEA why this line is giving a NoMethodError (array is nil?) for array.delete() ...
    # x.report("Array .delete (beginning)         :")     { n.times do; array = filter_array && array.delete("a")    ; end}
Benchmark.bm(34) do |x|
    x.report("Set   .delete (beginning)         :") { 
        n.times do 
            set = filter_set
            set.delete("a")           
        end
    }
    x.report("Array .delete (beginning)         :") { 
        n.times do
            array = filter_array
            array.delete("a")
        end
    }
    x.report("Set   .delete (middle)            :") { 
        n.times do 
            set = filter_set
            set.delete("they")        
        end
    }
    x.report("Array .delete (middle)            :") { 
        n.times do
            array = filter_array
            array.delete("they")  
        end
    }
    x.report("Set   .delete (end)               :") { 
        n.times do 
            set = filter_set
            set.delete("at")          
        end
    }
    x.report("Array .delete (end)               :") { 
        n.times do
            array = filter_array
            array.delete("at")    
        end
    }
end


puts


filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
sub_set = Set["a", "they", "at"]
sub_array = ["a", "they", "at"]
replace_set = Set["big", "sword", "knight"]
replace_array = ["big", "sword", "knight"]
Benchmark.bm(34) do |x|
    x.report("Set   .subset?          (true)    :")     { n.times do; sub_set.subset?(filter_set)                       ; end}
    x.report("Array (a1 & a2) == a2   (true)    :")     { n.times do; (filter_array & sub_array) == sub_array           ; end}
    x.report("Set   .subset?          (false)   :")     { n.times do; replace_set.subset?(filter_set)                   ; end}
    x.report("Array (a1 & a2) == a2   (false)   :")     { n.times do; (filter_array & replace_array) == replace_array   ; end}    
end


puts


filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
replace_set = Set["big", "sword", "knight"]
replace_array = ["big", "sword", "knight"]
# .replace for Sets is actually SLOWER?!?
Benchmark.bm(34) do |x|
    x.report("Set   .replace                    :")     { n.times do; filter_set.replace(replace_set)       ; end}
    x.report("Array .replace                    :")     { n.times do; filter_array.replace(replace_array)   ; end}
end


puts


filter_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
filter_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
match_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
match_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
replace_set = Set["big", "sword", "knight"]
replace_array = ["big", "sword", "knight"]
# == for Sets is actually SLOWER?!?
Benchmark.bm(34) do |x|
    x.report("Set   ==  (true)                  :")     { n.times do; filter_set == match_set       ; end}
    x.report("Array ==  (true)                  :")     { n.times do; filter_array == match_array   ; end}
    x.report("Set   ==  (false)                 :")     { n.times do; filter_set == replace_set     ; end}
    x.report("Array ==  (false)                 :")     { n.times do; filter_array == replace_array ; end}
end


# OUTPUT:
# ================================================================================

# [20:50:29] (master) devto-set-introduction
# // ♥ ruby sets.rb 
#                                          user     system      total        real
# Set   .include? (beginning)       :  0.807254   0.003145   0.810399 (  0.815409)
# Array .include? (beginning)       :  0.643563   0.002758   0.646321 (  0.649162)
# Set   .include? (middle)          :  0.839632   0.004164   0.843796 (  0.848407)
# Array .include? (middle)          :  1.308361   0.006144   1.314505 (  1.321314)
# Set   .include? (end)             :  0.849066   0.007143   0.856209 (  0.866563)
# Array .include? (end)             :  2.744591   0.023800   2.768391 (  2.817630)

#                                          user     system      total        real
# Set   .add  (successful)          :  1.054612   0.008337   1.062949 (  1.076742)
# Array .push (successful)          :  0.940725   0.103405   1.044130 (  1.048352)
# Set   .add  (failed)              :  1.024388   0.039030   1.063418 (  1.069405)
# Array .push (if not present)      :  1.400026   0.010127   1.410153 (  1.431480)

#                                          user     system      total        real
# Set   .delete (beginning)         :  0.907326   0.009437   0.916763 (  0.935422)
# Array .delete (beginning)         :  2.011303   0.013726   2.025029 (  2.056089)
# Set   .delete (middle)            :  0.883195   0.006221   0.889416 (  0.904483)
# Array .delete (middle)            :  2.283526   0.015207   2.298733 (  2.352525)
# Set   .delete (end)               :  0.853483   0.001496   0.854979 (  0.858217)
# Array .delete (end)               :  2.344214   0.009447   2.353661 (  2.437685)

#                                          user     system      total        real
# Set   .subset?          (true)    :  2.188807   0.008591   2.197398 (  2.258545)
# Array (a1 & a2) == a2   (true)    :  8.366246   0.254859   8.621105 (  8.750982)
# Set   .subset?          (false)   :  1.620218   0.004993   1.625211 (  1.642964)
# Array (a1 & a2) == a2   (false)   :  5.618176   0.025675   5.643851 (  5.734110)

#                                          user     system      total        real
# Set   .replace                    :  2.409822   0.015146   2.424968 (  2.460318)
# Array .replace                    :  0.450724   0.001970   0.452694 (  0.454624)

#                                          user     system      total        real
# Set   ==  (true)                  :  7.522211   0.042412   7.564623 (  7.666843)
# Array ==  (true)                  :  4.191919   0.015160   4.207079 (  4.232901)
# Set   ==  (false)                 :  1.116277   0.000686   1.116963 (  1.117678)
# Array ==  (false)                 :  0.387012   0.000397   0.387409 (  0.388069)






# array = string.split(" ")

# set = Set.new
# array.each do |str|
#     if !filter_set.include?(str)
#         set.add(str)
#     end
# end

# puts set


