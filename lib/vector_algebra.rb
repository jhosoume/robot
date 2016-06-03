module VectorAlgebra

  def self.norm(array)
    Math.sqrt(array.inject(0) { |norm_squared, element| norm_squared + element**2 })
  end

end