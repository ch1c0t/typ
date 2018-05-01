def initialize type, params
  @type, @params = type, params

  @check = if @params.empty?
             -> it { it.is_a? @type }
           else
             key_type, value_type = params.first
             -> it {
               it.is_a?(@type) &&
                 it.keys.all? {|k| k.is_a? key_type } &&
                 it.values.all? {|v| v.is_a? value_type }
             }
           end
end

def === it
  @check === it
end

def to_s
  if @params.empty?
    @type.to_s
  else
    "#{@type}, #{params}"
  end
end
