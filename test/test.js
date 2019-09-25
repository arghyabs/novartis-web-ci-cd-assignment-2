// var assert = require('assert'),
//     http = require('http');

// describe('/', function () {
//   it('should return 200', function (done) {
//     http.get('http://localhost:3000', function (res) {
//       assert.equal(200, res.statusCode);
//       done();
//     });
//   });
// });

var  assert = require('assert');
var greetings = require('../hello.js');

describe('Calculator Tests', function() {
	it('our "Hello" function works', function (done) {
		assert.equal('HELLO', greetings.sayHelloInEnglish());
		done();
	});
});

//assert.strictEqual(greetings.sayHelloInEnglish(), 'HELLO', 'our "Hello" function works');
//assert.strictEqual(greetings.sayHelloInSpanish(),'Hola','our "Hola" function works');
//assert.strictEqual(greetings.sayHelloInFrench(),'Bonjour','our "Bonjour" function works');
