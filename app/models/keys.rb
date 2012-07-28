require 'set'

class SortedHash < Hash
  def <=>(hash)
    self[:idx] <=> hash[:idx]
  end
end

class Array
  def allperms(range)
    range.to_a.map do |num|
      self.permkeys(num)
    end.flatten
  end

  def permkeys(num)
    self.permutation(num).to_a.map{ |e| SortedSet.new e }.uniq#.map{ |s| s.to_a.join(" ") }
  end

  def allperms_sorted(range, reference)
    range.to_a.map do |num|
      self.permkeys_sorted(num, reference)
    end.flatten
  end

  def permkeys_sorted(num, ref)
    self.permutation(num).to_a.map do |e|
      e.sort!{ |a, b| ref.index(a) <=> ref.index(b) }
      Set.new e
    end.uniq#.map{ |s| s.to_a.join(" ") }
  end
end

class Keys
  def initialize(keys)
    @keys = keys
  end

  def all
    results = preprocess @keys
    expand results
  end

  private

  def preprocess(array)
    results = []
    array.each_with_index do |key, idx|
      if key.is_a?(String)
        results << SortedHash[ key: key, idx: idx, lvl: 0 ]
      else # array
        keys = key
        keys.each_with_index do |k, sub_idx|
          results << SortedHash[ key: k, idx: idx, sub_idx: sub_idx,  lvl: 1 ]
        end
      end
    end
    results
  end

  def expand(array)
    keys = []
    # single keys
    array.each do |elem|
      keys << elem[:key]
    end
    lv_zero = array.select{|e| e[:lvl] == 0}
    lv_one  = array.select{|e| e[:lvl] == 1}
    # keys += lv_zero.map{ |e| e[:key] }.allperms(2..lv_zero.size)

    sliceds = []
    lv_one.each do |elem|
      slice = lv_zero + [elem]
      sliceds += slice.sort_by{|e| e[:idx]}.map{ |e| e[:key] }.allperms_sorted(2..slice.size, keys)
    end

    # internals
    lv_one.each do |elem|
      slice = lv_one.select{|e| e[:idx] != elem[:idx] }# + [elem]
      arr = slice.map do |el|
        [el, elem].sort_by{|e| e[:idx]}.map{ |e| e[:key] }.allperms_sorted(2..2, keys)
      end
      sliceds += arr.map{ |e| e[0] }
    end
    keys += sliceds.uniq.map{ |s| s.to_a.join(" ") }

    # complete
    completes = []
    lv_one.each do |elem|
      slice = lv_one.select{|e| e[:idx] != elem[:idx] }
      sets = slice.map do |el|
        SortedSet.new [elem, el]
      end
      completes += sets
    end
    completes.uniq!
    completes.each do |comp|
      lv_zero.each do |one|
        comp.add one
        comp.sort_by{|e| e[:idx]}
      end
    end
    completes = completes.uniq.map{ |c| c.to_a.map{ |e| e[:key] }.join(" ") }
    keys += completes

    keys.uniq.sort{|a,b| a.size <=> b.size }
  end
end