require("./calendar")


describe Calendar do
  it "returns success on AddEvent called" do 
      cal = Calendar.new
      expect(cal.AddEvent(Date.parse("26/08/2021"), Time.parse("1:30"), "Meeting", "Lahore")).to eq "success"
  end

end
