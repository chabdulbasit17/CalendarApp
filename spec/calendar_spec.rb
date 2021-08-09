require("./calendar")


describe Calendar do
  it "returns success on AddEvent called" do 
      cal = Calendar.new
      expect(cal.AddEvent()).to eq "success"
  end

end
