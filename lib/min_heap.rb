class HeapNode
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

# concept - reference: https://www.interviewcake.com/concept/java/heap
# https://learn-2.galvanize.com/cohorts/2173/blocks/867/content_files/06-heaps/01-heaps.md

class MinHeap

  def initialize
    @store = []
  end

  # This method adds a HeapNode instance to the heap
  # Time Complexity: O(log n) => because adding a value to the end of the array is O(1) + calling the heap_up method will take O(log n) since heap is built on a complete binary tree O(log n)
  # Space Complexity: O(log n) => because of the system stack from the heap_up method
  def add(key, value = key)
    node = HeapNode.new(key, value)
    @store << node

    new_idx = @store.length - 1
    heap_up(new_idx) if @store.length > 1 # heap up only if there is something to sort
  end

  # This method removes and returns an element from the heap
  #   maintaining the heap structure
  # Time Complexity: O(log n) => because heap is built on a complete binary tree 
  # Space Complexity: O(log n)

  def remove()
    return if @store.empty? # do nothing

    swap(0, -1) # swap the first and the last (Take the bottom level's right-most item and move it to the top, to fill in the hole.)
    removed = @store.pop

    heap_down() if @store.length > 1 # only if there is something to heap down
    return removed.value
  end


  # Used for Testing
  def to_s
    return "[]" if @store.empty?

    output = "["
    (@store.length - 1).times do |index|
      output += @store[index].value + ", "
    end

    output += @store.last.value + "]"
      
    return output
  end

  # This method returns true if the heap is empty
  # Time complexity: O(1)
  # Space complexity: O(1)
  def empty?
    return @store.length == 0
  end

  private

  # This helper method takes an index and
  #  moves it up the heap, if it is less than it's parent node.
  #  It could be **very** helpful for the add method.
  # Time complexity: O(log n) => because heap is built on a complete binary tree
  # Space complexity: O(log n) => because of the system stack
  # recursive way
  def heap_up(index)
    return if index == 0 # do nothing

    parent_idx = (index - 1) / 2  

    if @store[index].key < @store[parent_idx].key
      swap(index, parent_idx)
      heap_up(parent_idx)
    end
  end

  # This helper method takes an index and 
  #  moves it up the heap if it's smaller
  #  than it's parent node.
  # recursive way
  def heap_down(parent_index=0)
    return if @store.empty?
    
    left_idx = (2 * parent_index) + 1
    right_idx = (2 * parent_index) + 2
    
    return if @store[left_idx].nil?

    if @store[right_idx]
      @store[left_idx].key < @store[right_idx].key ? heap_down_helper(left_idx, parent_index) : heap_down_helper(right_idx, parent_index)
    elsif (@store[right_idx].nil? && @store[left_idx].key < @store[parent_index].key) 
      heap_down_helper(left_idx, parent_index) 
    end
  end

  def heap_down_helper(child_idx, parent_idx)
    swap(child_idx, parent_idx)
    heap_down(child_idx)
  end

  # If you want a swap method... you're welcome
  def swap(index_1, index_2)
    temp = @store[index_1]
    @store[index_1] = @store[index_2]
    @store[index_2] = temp
  end
end