module Interface
   class InterfaceNotImplementedError < NoMethodError
   end
 
    def self.included(klass)
      klass.send(:include, Interface::Methods)
      klass.send(:extend, Interface::Methods)
    end
    
    module Methods    
 
      def api_not_implemented(klass)
        caller.first.match(/in \`(.+)\'/)
        method_name = $1
        raise Interface::InterfaceNotImplementedError.new("#{klass.class.name} needs to implement '#{method_name}' for interface #{self.name}!")
      end
  
    end
 
end