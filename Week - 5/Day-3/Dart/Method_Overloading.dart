class Calculator{
  add(dynamic a, dynamic b,{dynamic c=0}){
    print(a+b+c);
  }
}
void main(){
  Calculator myCalculator = new Calculator();
  myCalculator.add(10, 20,c: 3);
}