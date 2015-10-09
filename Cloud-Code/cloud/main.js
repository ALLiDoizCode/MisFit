
var Stripe = require('stripe');
Stripe.initialize('sk_test_YqAC2Btche0e1WBV8K5aZMru'); //replace *** with your key values


Parse.Cloud.define("hello", function(request, response) {

var stripeToken = request.params.token;

 var charge = Stripe.Charges.create({
 amount: 500, // express dollars in cents 
 currency: 'usd',
 card: stripeToken
 }).then(null, function(error) {
 console.log('Charging with stripe failed. Error: ' + error);
 }).then(function() {
   // And we're done!
   response.success('Success');

   });
  });
