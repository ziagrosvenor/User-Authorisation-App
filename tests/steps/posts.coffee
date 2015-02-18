module.exports = () ->
  this.Given /^I visit Auth App$/, () ->
    this.driver.get('http://localhost:3000')

  @When /^I login with "([^"]*)", "([^"]*)"$/, (email, password) ->
    LoginForm = @Widget.Form.extend
      root: '.login-form'
      submitSelector: () ->
        @find('button')

    form = new LoginForm

    form.submitWith username: email, password: password

  @Then /^I can post "([^"]*)", "([^"]*)"$/, (title, content) ->
    PostForm = @Widget.Form.extend
      root: '.postForm'
      submitSelector: ->
        @find('button')

    form = new PostForm

    form.submitWith title: title, content: content

  @Then /^I can see "([^"]*)", "([^"]*)"$/, (title, content) ->
    @Widget.read
      selector: '.postList .post:first-child h2'
    .should.eventually.eql(title)

    @Widget.read
      selector: '.postList .post:first-child p'
    .should.eventually.eql(content)

  @Then /^I can delete the post$/, ->
    @Widget.click('.postList .post:first-child #deleteBtn')
      .then () =>
        @Widget.isPresent('.postList .post:first-child')
      .should.eventually.eql(false)