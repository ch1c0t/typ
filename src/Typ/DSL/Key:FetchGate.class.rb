def fetch_check
  @fetch_check ||= begin
                     name = @kwargs[:name]
                     -> it { it[name] }
                   end
end
