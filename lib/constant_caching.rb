module ConstantCaching  
  def self.clear_constant(const)
    Object.class_eval do
      if const_defined?(const)      
        remove_const(const)
      end
    end
  end
end
