class Details{
  void age(){
    print("Age:21");
  }
}
class NewDetails extends Details{
  void age(){
    print("Age: 22");
  }
}
void main(){
  Details details = new Details();
  NewDetails newDetails = NewDetails();

  details.age();
  newDetails.age();
}