class Exchange
  include Mongoid::Document
  field :_id, type: String
  field :rate, type: Float
end
