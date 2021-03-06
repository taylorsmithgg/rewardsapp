
class UserService

    @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
    @defaultConfig = { headers: @headers }

    constructor: (@$log, @$http, @$q) ->
        @$log.debug "constructing UserService"

    listUsers: () ->
        @$log.debug "listUsers()"
        deferred = @$q.defer()

        @$http.get("/users")
        .success((data, status, headers) =>
                @$log.info("Successfully listed Users - status #{status}")
                deferred.resolve(data)
            )
        .error((data, status, headers) =>
                @$log.error("Failed to list Users - status #{status}")
                deferred.reject(data)
            )
        deferred.promise

    createUser: (user) ->
        deferred = @$q.defer()

        if(!user.emailAlert?)
          user.emailAlert = false

        if(!user.textAlert?)
          user.textAlert = false

        @$log.debug "createUser #{angular.toJson(user, true)}"

        @$http.post('/users', user)
        .success((data, status, headers) =>
                @$log.info("Successfully created User - status #{status}")
                deferred.resolve(data)
            )
        .error((data, status, headers) =>
                @$log.error("Failed to create user - status #{status}")
                deferred.reject(data)
            )
        deferred.promise

    updateUser: (user) ->
      @$log.debug "updateUser #{angular.toJson(user, true)}"
      deferred = @$q.defer()

      @$http.put("/users/#{user.id}", user)
      .success((data, status, headers) =>
              @$log.info("Successfully updated User - status #{status}")
              @$log.debug(user)
              deferred.resolve(data)
            )
      .error((data, status, header) =>
              @$log.error("Failed to update user - status #{status}")
              deferred.reject(data)
            )
      deferred.promise

    deleteUser: (user) ->
        @$log.debug "deleteUser #{angular.toJson(user, true)}"
        deferred = @$q.defer()

        @$http.delete("/users/#{user.id}", user)
        .success((data, status, headers) =>
          @$log.info("Successfully deleted User - status #{status}")
          deferred.resolve(data)
        )
        .error((data, status, headers) =>
          @$log.error("Failed to delete user - status #{status}")
          deferred.reject(data)
        )
        deferred.promise

    getUser: (id) ->
      @$log.debug "getUser: #{id}"
      deferred = @$q.defer()

      @$http.get("/users/#{id}")
      .success((data, status, headers) =>
        @$log.info("Successfully retrieved User - status #{status}")
        deferred.resolve(data)
      )
      .error((data, status, header) =>
        @$log.error("Failed to retrieve user - status #{status}")
        deferred.reject(data)
      )
      deferred.promise

servicesModule.service('UserService', UserService)