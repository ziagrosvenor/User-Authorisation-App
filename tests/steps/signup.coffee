module.exports = () ->
  this.Given /^I visit Auth App$/, () ->
    this.driver.get('http://localhost:3000/')

  this.When /^I enter "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)"$/, (fName, lName, email, pass) ->
    this.Widget.find
      root: '#signup-form'
    .then () =>
      this.Widget.fill
        selector: '#firstname'
        value: fName
      this.Widget.fill
        selector: '#surname'
        value: lName
      this.Widget.fill
        selector: '#email'
        value: email
      this.Widget.fill
        selector: '#confirmEmail'
        value: email
      this.Widget.fill
        selector: '#signupPassword'
        value: pass

  this.Then /^I should see "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)"$/, (fName, lName, email, pass) ->
    this.Widget.getValue
      selector: '#firstname'
    .should.eventually.eql(fName)

    this.Widget.getValue
      selector: '#surname'
    .should.eventually.eql(lName)

    this.Widget.getValue
      selector: '#email'
    .should.eventually.eql(email)

    this.Widget.getValue
      selector: '#confirmEmail'
    .should.eventually.eql(email)

    this.Widget.getValue
      selector: '#signupPassword'
    .should.eventually.eql(pass)

  this.Then /^I should see feedback for verified inputs$/, () ->
    # Removes focus from form
    this.Widget.click('body')
      .then () =>
        # Checks that a class was added to the input
        this.Widget.isPresent('#firstname.valid')
      .should
      .eventually
      .eql(true)