class Typecaster
  def initialize(attrs)
    @attrs = attrs
  end

  def typecasted
    typecast(@attrs)
  end

  private

  def typecast(hash)
    result = {}
    arr = hash.map do |k, v|
      if v.is_a?(Hash)
        v = typecast(v)
      else
        v = v == 'true' if ['true', 'false'].include?(v)
      end
      result[k] = v
    end
    result
  end
end
