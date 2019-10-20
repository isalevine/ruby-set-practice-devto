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

# [21:25:07] (master) devto-set-introduction
# // ♥ ruby sets.rb 
#                                          user     system      total        real
# Set   .include? (beginning)       :  0.796039   0.001551   0.797590 (  0.799956)
# Array .include? (beginning)       :  0.632907   0.000869   0.633776 (  0.637059)
# Set   .include? (middle)          :  0.786981   0.000610   0.787591 (  0.788172)
# Array .include? (middle)          :  1.294061   0.001416   1.295477 (  1.298378)
# Set   .include? (end)             :  0.792309   0.000866   0.793175 (  0.795283)
# Array .include? (end)             :  2.476954   0.002786   2.479740 (  2.484839)

#                                          user     system      total        real
# Set   .add  (successful)          :  0.929103   0.000749   0.929852 (  0.931718)
# Array .push (successful)          :  0.909708   0.094546   1.004254 (  1.005897)
# Set   .add  (failed)              :  0.979433   0.029193   1.008626 (  1.011531)
# Array .push (if not present)      :  1.327389   0.001286   1.328675 (  1.330673)

#                                          user     system      total        real
# Set   .delete (beginning)         :  0.812703   0.000889   0.813592 (  0.816582)
# Array .delete (beginning)         :  1.932468   0.001862   1.934330 (  1.938841)
# Set   .delete (middle)            :  0.811337   0.000912   0.812249 (  0.814055)
# Array .delete (middle)            :  2.053270   0.001698   2.054968 (  2.059913)
# Set   .delete (end)               :  0.813986   0.000986   0.814972 (  0.816330)
# Array .delete (end)               :  2.203437   0.002076   2.205513 (  2.210077)

#                                          user     system      total        real
# Set   .subset?          (true)    :  2.076477   0.001450   2.077927 (  2.080519)
# Array (a1 & a2) == a2   (true)    :  7.961141   0.180642   8.141783 (  8.158982)
# Set   .subset?          (false)   :  1.554540   0.001360   1.555900 (  1.558715)
# Array (a1 & a2) == a2   (false)   :  5.280627   0.006986   5.287613 (  5.297066)

#                                          user     system      total        real
# Set   .replace                    :  2.318287   0.001841   2.320128 (  2.327267)
# Array .replace                    :  0.441079   0.000528   0.441607 (  0.442994)

#                                          user     system      total        real
# Set   ==  (true)                  :  7.219614   0.004376   7.223990 (  7.234709)
# Array ==  (true)                  :  4.119128   0.003112   4.122240 (  4.128884)
# Set   ==  (false)                 :  1.097661   0.000751   1.098412 (  1.099235)
# Array ==  (false)                 :  0.391299   0.000482   0.391781 (  0.393029)







# array = string.split(" ")

# set = Set.new
# array.each do |str|
#     if !filter_set.include?(str)
#         set.add(str)
#     end
# end

# puts set


