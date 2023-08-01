def fetch_check
  @fetch_check ||= begin
                     name = @kwargs[:name]
                     -> it { it.send name }
                   end
end
