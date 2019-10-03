module.exports = {
  'Checking application index page in Chrome': function (browser) {
    browser
      .url("http://localhost:3000/")
      .pause(2000)
      .getTitle(function(title) {
     		this.assert.ok(title.includes("Novartis"));
      })
      .pause(2000)
  },
  after: function (browser) {
    browser
      .end();
  }
};
