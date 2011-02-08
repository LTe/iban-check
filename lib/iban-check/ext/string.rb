class String
  def switch
    if (65..(65+35)).include? self[0].ord
      (self[0].ord) - 55
    else
      self
    end
  end
end