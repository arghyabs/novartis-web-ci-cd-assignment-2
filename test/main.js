const ip = req.header('x-forwarded-for') || req.connection.remoteAddress;

const siteUrl = 'http://${ip}:3000'

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
