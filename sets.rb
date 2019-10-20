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
sub_set = Set["a", "they", "at"]
sub_array = ["a", "they", "at"]
# .subset is faster for TRUE, but slower for FALSE -- how/why?!?!
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
match_set = Set["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
"them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
match_array = ["a", "an", "the", "and", "is", "of", "to", "be", "in", "they", "their", 
    "them", "or", "if", "this", "like", "had", "but", "what", "with", "at",
]
# == for Sets is actually SLOWER?!?
Benchmark.bm(34) do |x|
    x.report("Set   ==  (true)                  :")     { n.times do; filter_set == match_set       ; end}
    x.report("Array ==  (true)                  :")     { n.times do; filter_array == match_array   ; end}
    x.report("Set   ==  (false)                 :")     { n.times do; filter_set == replace_set     ; end}
    x.report("Array ==  (false)                 :")     { n.times do; filter_array == replace_array ; end}
end


# OUTPUT:
# ================================================================================

# [01:14:46] (master) devto-set-introduction
# // ♥ ruby sets.rb 
#                                          user     system      total        real
# Set   .include? (beginning)       :  0.799191   0.001007   0.800198 (  0.804688)
# Array .include? (beginning)       :  0.628433   0.000581   0.629014 (  0.630779)
# Set   .include? (middle)          :  0.814844   0.000616   0.815460 (  0.816231)
# Array .include? (middle)          :  1.281331   0.000903   1.282234 (  1.284204)
# Set   .include? (end)             :  0.832735   0.000770   0.833505 (  0.834607)
# Array .include? (end)             :  2.466209   0.002007   2.468216 (  2.472335)

#                                          user     system      total        real
# Set   .delete (beginning)         :  0.808267   0.000663   0.808930 (  0.809997)
# Array .delete (beginning)         :  1.917106   0.001497   1.918603 (  1.921334)
# Set   .delete (middle)            :  0.879153   0.000658   0.879811 (  0.880859)
# Array .delete (middle)            :  2.056807   0.001768   2.058575 (  2.062143)
# Set   .delete (end)               :  0.863566   0.000757   0.864323 (  0.865941)
# Array .delete (end)               :  2.209409   0.001800   2.211209 (  2.216760)

#                                          user     system      total        real
# Set   .replace                    :  2.300247   0.001421   2.301668 (  2.306044)
# Array .replace                    :  0.442213   0.000345   0.442558 (  0.444019)

#                                          user     system      total        real
# Set   .subset?          (true)    :  1.506719   0.001545   1.508264 (  1.510730)
# Array .(a1 - a2) == a2  (true)    :  2.626033   0.001873   2.627906 (  2.631523)
# Set   .subset?          (false)   :  2.158126   0.001394   2.159520 (  2.162242)
# Array .(a1 - a2) == a2  (false)   :  1.013175   0.000991   1.014166 (  1.016036)

#                                          user     system      total        real
# Set   ==  (true)                  :  1.106354   0.001037   1.107391 (  1.109885)
# Array ==  (true)                  :  0.397442   0.000256   0.397698 (  0.397973)
# Set   ==  (false)                 :  2.975989   0.002164   2.978153 (  2.983041)
# Array ==  (false)                 :  1.260872   0.000936   1.261808 (  1.265367)





# array = string.split(" ")

# set = Set.new
# array.each do |str|
#     if !filter_set.include?(str)
#         set.add(str)
#     end
# end

# puts set


