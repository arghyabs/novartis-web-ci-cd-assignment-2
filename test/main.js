var ip = require("ip");

const hostname = ip.address();
const siteUrl = 'http://'+hostname+':3000/';

console.log(siteUrl);
module.exports = {
  'Checking application index page in Chrome': function (browser) {
    console.log(siteUrl)
    browser
      .url(siteUrl)
      .pause(2000)
      .expect.element('body').to.be.present;
       //.assert.titleContains('Novartis')
      //.pause(2000)
  },
  after: function (browser) {
    browser
      .end();
  }
};
