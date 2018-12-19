module MergeHashes

  def merge_hashes
    @data_file.inject do |total, new|
      #first iteration total is data_file[0] and new is data_file[1]
      #second iteration total is [data_file[0], data_file[1] and new is data_file[2]
      #etc.
      total.merge!(new) do |key, oldval, newval|
        [newval, oldval]
        #its creating a merged array of values with same keys
      end
    end
    new_hash = {}
    @data_file[0].each do |keys, values|
      if new_hash.has_key?(keys)
          new_hash[keys].push(values.flatten.reverse)
      else
          new_hash[keys] = values.flatten.reverse
      end
    end
    @data_file = new_hash
    return @data_file
  end

end
