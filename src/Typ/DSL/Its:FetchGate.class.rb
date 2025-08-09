def fetch_check
  @fetch_check ||= begin
                     name = @kwargs[:name]
                     -> object { object.send name }
                   end
end
