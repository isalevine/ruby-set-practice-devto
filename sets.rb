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
            set = filter_set && set.add("big")
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
            set = filter_set && set.add("they")
        end
    }
    x.report("Array .push (if not present)      :") { 
        n.times do
            array = filter_array
            if !filter_array.include?("they")
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
            set = filter_set && set.delete("a")           
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
            set = filter_set && set.delete("they")        
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
            set = filter_set && set.delete("at")          
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

# [20:38:19] (master) devto-set-introduction
# // ♥ ruby sets.rb 
#                                          user     system      total        real
# Set   .include? (beginning)       :  0.799968   0.000781   0.800749 (  0.801720)
# Array .include? (beginning)       :  0.624981   0.000473   0.625454 (  0.625898)
# Set   .include? (middle)          :  0.842336   0.002082   0.844418 (  0.846732)
# Array .include? (middle)          :  1.377181   0.010076   1.387257 (  1.401818)
# Set   .include? (end)             :  0.830377   0.002882   0.833259 (  0.836258)
# Array .include? (end)             :  2.690000   0.019396   2.709396 (  2.752856)

#                                          user     system      total        real
# Set   .add  (successful)          :  1.071473   0.007905   1.079378 (  1.095753)
# Array .push (successful)          :  0.971526   0.113874   1.085400 (  1.095646)
# Set   .add  (failed)              :  1.016600   0.030278   1.046878 (  1.048309)
# Array .push (if not present)      :  1.319782   0.001061   1.320843 (  1.321994)

#                                          user     system      total        real
# Set   .delete (beginning)         :  0.847254   0.000844   0.848098 (  0.848870)
# Array .delete (beginning)         :  1.924823   0.004572   1.929395 (  1.934509)
# Set   .delete (middle)            :  0.847730   0.000768   0.848498 (  0.849024)
# Array .delete (middle)            :  2.106035   0.006836   2.112871 (  2.123520)
# Set   .delete (end)               :  0.917233   0.005234   0.922467 (  0.931679)
# Array .delete (end)               :  2.201310   0.001398   2.202708 (  2.204095)

#                                          user     system      total        real
# Set   .replace                    :  2.274481   0.001641   2.276122 (  2.277941)
# Array .replace                    :  0.436824   0.000219   0.437043 (  0.437270)

#                                          user     system      total        real
# Set   .subset?          (true)    :  2.095046   0.001112   2.096158 (  2.097698)
# Array (a1 & a2) == a2   (true)    :  7.874566   0.187823   8.062389 (  8.068185)
# Set   .subset?          (false)   :  1.564256   0.000845   1.565101 (  1.566413)
# Array (a1 & a2) == a2   (false)   :  5.269222   0.012256   5.281478 (  5.289586)

#                                          user     system      total        real
# Set   ==  (true)                  :  7.229199   0.006450   7.235649 (  7.242571)
# Array ==  (true)                  :  4.103569   0.002604   4.106173 (  4.109292)
# Set   ==  (false)                 :  1.097917   0.000701   1.098618 (  1.099354)
# Array ==  (false)                 :  0.386803   0.000315   0.387118 (  0.387464)





# array = string.split(" ")

# set = Set.new
# array.each do |str|
#     if !filter_set.include?(str)
#         set.add(str)
#     end
# end

# puts set


