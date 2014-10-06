require 'rails_helper'

RSpec.describe Skynet, :type => :model do
  #Para hacerlo un poco mas entretenido en vez de corroborar que no hay nuevos codenames
  it "should raise SkynetIsdesynchronizedWithUs at saving an existing CodeName" do
    CodeName.create(name: "T-504", info_reference:"http://en.wikipedia.org/wiki/Terminator_(character)", damage: 5)
    Skynet.should_receive(:get_central_updates).and_return([{name: "T-504", info_reference:"http://en.wikipedia.org/wiki/Terminator_(character)", damage: 5}])
    expect{Skynet.update_database}.to raise_error{SkynetIsDesyncWithUs}

  end
  #Check that the last one is the same in the stub
  it "should save new CodeName" do
    @name="T-9000"
    @info="http://en.wikipedia.org/wiki/Terminator_(character)/T-9000"
    @damage=5
    Skynet.should_receive(:get_central_updates).and_return([{name: @name, info_reference:@info, damage: @damage}])
    Skynet.update_database

    last=CodeName.last
    expect(last.name).to eq(@name)
    expect(last.info_reference).to eq(@info)
    expect(last.damage).to eq(@damage)

  end
end
