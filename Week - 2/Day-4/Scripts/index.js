// const orderPizza = new Promise((resolve, reject) => {
//     let isPizzaAvailable = true;
  
//     if (isPizzaAvailable) {
//       resolve("Pizza is here!");
//     } else {
//       reject("No pizza today.");
//     }
//   });
  
//   orderPizza
//     .then((message) => {
//       console.log(message);
//     })
//     .catch((error) => {
//       console.error(error);
//     });
  
const myVar = new Promise((resolve, reject)=>{
    const var1 = 10;
    const var2 = 15;
    if(var1 == var2){
        resolve("Fulfilled");
    }else{
        reject("Rejected");
    }
});
myVar.then((message) =>{
console.log(message);
})
.catch((error) => {
    console.error(error);
});