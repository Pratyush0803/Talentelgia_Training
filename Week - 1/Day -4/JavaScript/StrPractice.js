// You are working on an e-commerce website where users can view the list of products in their cart. The cart is stored as an array:
// The last item in the cart is considered the "most recently added" product
// Use the at() function to get the last item in the cart and display it in the console.

// let cart = ["Laptop", "Phone", "Headphones", "Mouse", "Keyboard"];
//console.log(cart.at(-1));


// charAt()
// Scenario:
// You are creating a name tag generator. Given a user's name, extract and display the first letter of their name using charAt().

// let userName = "Michael";
// console.log(userName.charAt(0));


// charCodeAt()
// Scenario:
// You are developing a security system that needs to generate a numeric identifier for-
//  a user based on the ASCII code of the first letter of their username.

// let username = "Alice";
// console.log(username.charCodeAt(0));


// slice()
// Scenario:
// You have a system that needs to display only the first 5 characters of a product description for preview purposes.

// let description = "Wireless Bluetooth Earphones";
// console.log(description.slice(0, 5));


// substring()
// Scenario:
// You are building a news app where only the headline without the date should be displayed.

// let headline = "2024-02-13: New Technology Launched";
// console.log("News Title: ",headline.substring(12));


// substr()
// Scenario:
// You are building a messaging app that shows message previews.
// You need to extract the first 10 characters of a message to display as a preview.

// let message = "Hello, welcome to our platform!";
// console.log(message.substr(0,10))


// toUpperCase()
// Scenario:
// You are creating a registration form that ensures usernames are always stored in uppercase 
// in the database. Convert a given username to uppercase.

// let username = "john_doe";
// console.log(username.toUpperCase());


// toLowerCase()
// Scenario:
// You are working on an email system that ensures all email addresses are stored in lowercase. 
// Convert the given email to lowercase.

// let email = "UserName@Example.COM";
// console.log(email.toLowerCase());


// join() (Array function)
// Scenario:
// You are developing a weather app that displays the forecast for the next 3 days as a sentence.
//  The data is stored in an array.

// let forecast = ["Sunny", "Cloudy", "Rainy"];
// console.log(forecast.join(", "))
 

// trim()
// Scenario:
// You are working on a login system where users may enter their usernames with extra spaces by mistake.
//  Remove the extra spaces from the input.

// let userInput = "   Alice   ";
// console.log(userInput.trim());


// padStart()
// Scenario:
// You are designing an invoice system where invoice numbers should always be 6 digits long.
//  If an invoice number is shorter than 6 digits, it should be padded with leading zeros (0).

// let invoiceNumber = "123";
// console.log(invoiceNumber.padStart(6, "0"));


// padEnd()
// Scenario:
// You are creating a table display where all product names must be exactly 10 characters long.
//  If a product name is shorter, it should be padded with dots (.) at the end.

// let product = "Mouse";
// console.log(product.padEnd(10,"."))

// repeat()
// Scenario:
// You are developing a chat application where a loading indicator should display dots while messages are being sent.
// The number of dots should be repeated 3 times.

// let loadingDot = ".";
// console.log(loadingDot.repeat(3))


// replace()
// Scenario:
// You are working on a search and replace feature for a text editor. 
// The system should replace the first occurrence of the word "bad" with "good".

// let review = "The product is bad, but the service is great!";
// console.log(review.replace("bad", "good"));


// replaceAll()
// Scenario:
// You are developing a text formatter where all instances of "error" in a log message should be replaced with "warning".

// let logMessage = "System error detected. Please fix the error immediately.";
// console.log(logMessage.replaceAll("error", "warning"));


// split()
// Scenario:
// You are working on a blog platform that needs to extract individual words from a blog title. The words should be stored in an array.


// let blogTitle = "JavaScript String Methods Explained";
// console.log(blogTitle.split(" "));


// indexOf()
// Scenario:
// You are developing a search feature where users can find if a keyword exists in a sentence. 
// If the keyword is found, return its index.

let sentence = "The quick brown fox jumps over the lazy dog.";
let keyword = "fox";
console.log(sentence.indexOf(keyword)); 












