class UpdateUserCtrl

  constructor: (@$log, @$location, @$routeParams, @UserService) ->
      @$log.debug "constructing UpdateUserController"
      @user = {}
      @findUser()

  updateUser: () ->
      @$log.debug "updateUser()"
      @user.active = true
      @UserService.updateUser(@user)
      .then(
          (data) =>
            @$log.debug "Promise returned #{data} User"
            @user = data
            @$location.path("/")
        ,
        (error) =>
            @$log.error "Unable to update User: #{error}"
      )

  findUser: () ->
      # route params must be same name as provided in routing url in app.coffee
      id = @$routeParams.id
      @$log.debug "findUser route params: #{id}"

      @UserService.listUsers()
      .then(
        (data) =>
          @$log.debug "Promise returned #{data.length} Users"

          # find a user with the name of firstName and lastName
          # as filter returns an array, get the first object in it, and return it
          @user = (data.filter (user) -> user.id is id)[0]
      ,
        (error) =>
          @$log.error "Unable to get Users: #{error}"
      )

controllersModule.controller('UpdateUserCtrl', UpdateUserCtrl)