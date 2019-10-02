//demo.js is a JS file under tests folder
module.exports = {
    'step one: navigate to google' : function (browser) { //step one
      browser
        .url('https://www.google.com')
        .waitForElementVisible('body', 1000)
        .setValue('input[type=text]', 'nightwatch')
        .waitForElementVisible('input[name=btnK]', 1000)
    },
  
    'step two: click input' : function (browser) { //step two
      browser
        .click('input[name=btnK]')
        .pause(1000)
        .assert.containsText('#main', 'Night Watch')
        .end(); //to close the browser session after all the steps
    }
  };
