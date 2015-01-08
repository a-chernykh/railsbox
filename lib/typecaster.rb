class Typecaster
  def initialize(attrs)
    @attrs = attrs
  end

  def typecasted
    arr = @attrs.map do |k, v|
      v = v == 'true' if ['true', 'false'].include?(v)
      [k, v]
    end
    Hash[*arr.flatten]
  end
end
