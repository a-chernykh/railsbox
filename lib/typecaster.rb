class Typecaster
  def initialize(attrs)
    @attrs = attrs
  end

  def typecasted
    result = {}
    arr = @attrs.map do |k, v|
      v = v == 'true' if ['true', 'false'].include?(v)
      result[k] = v
    end
    result
  end
end
