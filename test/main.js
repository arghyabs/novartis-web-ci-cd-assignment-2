module.exports = {
  'Searching nightwatch in google': function (browser) {
    browser
      .url("http://www.google.com/")
      .pause(2000)
      .setValue('#search' , "Nightwatch js")
      .pause(2000)
      .keys(browser.Keys.ENTER)
      .pause(2000)
  },
  after: function (browser) {
    browser
      .end();
  }
};
