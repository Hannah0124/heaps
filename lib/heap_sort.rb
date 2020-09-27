require_relative "min_heap"

# This method uses a heap to sort an array.
# Time Complexity:  O(n log n) => because we iterate over the list O(n) and `add` method take O(log n)
# Space Complexity: O(n) => because we create a heap


def heap_sort(list)
  return list if list.length <= 1

  heap = create_heap(list)
  
  i = 0
  while i < list.length 
    removed = heap.remove() # remove root
    list[i] = removed
    i += 1
  end

  return list
end

def create_heap(list)
  heap = MinHeap.new()

  list.each do |elem| 
    heap.add(elem) 
  end

  return heap
end


# heap sort concept - https://www.interviewcake.com/concept/java/heapsort