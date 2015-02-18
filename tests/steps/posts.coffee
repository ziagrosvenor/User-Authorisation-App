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

  @Then /^I can edit the post to read "([^"]*)", "([^"]*)"$/, (newTitle, newContent) ->
    @Widget.click('.postList .post:first-child #editBtn')
      .then () =>
        PostForm = @Widget.Form.extend
          root: '.postForm'
          submitSelector: ->
            @find('button')

        form = new PostForm

        form.submitWith title: newTitle, content: newContent

    @Widget.click('#hamburgerIcon')
      .then () =>
        @Widget.click('.sideNavItem:nth-child(2)')
          .then () =>
            @Widget.read
              selector: '.postList .post:first-child h2'
            .should.eventually.eql(newTitle)

            @Widget.read
              selector: '.postList .post:first-child p'
            .should.eventually.eql(newContent)


  @Then /^I can delete the post$/, ->
    @Widget.click('.postList .post:first-child #deleteBtn')
      .then () =>
        @Widget.isPresent('.postList .post:first-child')
      .should.eventually.eql(false)