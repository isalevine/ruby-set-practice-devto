require 'set'

str_array = ["i", "am", "watching", "the", "office", "right", "now", "now", "now"]
int_array = [2, 6, 1, 4, 7, 2, 3, 3, 3, 1, 0, 5]
# mixed_array = [2, "i", 6, "am", 1, "watching", 4, "the", 7, "office", 2]



str_sorted_set = SortedSet.new(str_array)
int_sorted_set = SortedSet.new(int_array)
# mixed_sorted_set = SortedSet.new(mixed_array)



str_set = Set.new(str_array)
int_set = Set.new(int_array)
# mixed_set = Set.new(mixed_array)

str_sorted_set = SortedSet.new(str_set)
int_sorted_set = SortedSet.new(int_set)
# mixed_sorted_set = SortedSet.new(mixed_set)



require 'matrix'

str_vector = Vector["i", "am", "watching", "the", "office", "right", "now", "now", "now"]
int_vector = Vector[2, 6, 1, 4, 7, 2, 3, 3, 3, 1, 0, 5]

str_sorted_set = SortedSet.new(str_vector)
int_sorted_set = SortedSet.new(int_vector)







puts str_sorted_set
puts int_sorted_set
# puts mixed_sorted_set