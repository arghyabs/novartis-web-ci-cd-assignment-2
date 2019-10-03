const hostname = process.env.HOST;
const siteUrl = 'http://${hostname}:3000/index.html';

console.log(siteUrl);
module.exports = {
  'Checking application index page in Chrome': function (browser) {
    browser
      .url(siteUrl)
      .pause(2000)
      .assert.titleContains('Novartis')
      .pause(2000)
  },
  after: function (browser) {
    browser
      .end();
  }
};
