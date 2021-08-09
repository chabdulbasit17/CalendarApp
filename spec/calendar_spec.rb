require("./calendar")


describe Calendar do
  it "returns success on AddEvent called" do 
      cal = Calendar.new
      expect(cal.AddEvent("26/08/2021", "1:30", "Meeting", "Lahore")).to eq "success"
  end

end
