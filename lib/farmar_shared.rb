require_relative '../farmar.rb'


class FarMar::Shared

  def self.find(id)
    id.class != Fixnum ? raise(ArgumentError) : id

    self.all.each do |object|
      if object.id == id
        return object 
      end
    end
  end

end
