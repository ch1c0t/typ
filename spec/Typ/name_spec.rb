describe 'Typ#name' do
  let(:t) {
    Class.new do
      include Typ
      is [:>, 0]
    end.new 1
  }

  it 'provides access to the class name by default' do
    expect(t.name).to start_with '#<Class:'
  end

  it 'can be changed' do
    t.name = 'some other name'
    expect(t.name).to eq 'some other name'
  end
end
