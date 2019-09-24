const assert = require('assert');
const greetings = require('./hello.js');

assert.strictEqual(greetings.sayHelloInEnglish(), 'HELLO', 'our "Hello" function works');
assert.strictEqual(greetings.sayHelloInSpanish(),'Hola','our "Hola" function works');
assert.strictEqual(greetings.sayHelloInFrench(),'Bonjour','our "Bonjour" function works');
