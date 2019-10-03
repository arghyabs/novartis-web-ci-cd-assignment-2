module.exports = {
  'Checking application index page in Chrome': function (browser) {
    browser
      .url("http://${require(‘ip’).address()}:3000")
      .pause(2000)
      .assert.titleContains('Novartis')
      .pause(2000)
  },
  after: function (browser) {
    browser
      .end();
  }
};
