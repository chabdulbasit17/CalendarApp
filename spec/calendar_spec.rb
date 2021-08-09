require("./calendar")


describe Calendar do
  it "returns success on add_event called" do 
      cal = Calendar.new
      expect(cal.add_event(Date.parse("26/08/2021"), Time.parse("1:30"), "Meeting", "Lahore")).to eq true
  end

  it "deletes the specified event and array size reduces by one after successful deletion" do
    cal = Calendar.new
    cal.add_event(Date.parse("26/08/2021"), Time.parse("1:30"), "Meeting", "Lahore")
    expect(cal.delete_event(8,1)).to eq true
  end
end
