dependencies = [
  'ngRoute',
#  'ngAnimate',
#  'mgcrea.ngStrap',
  'ui.bootstrap',
  'myApp.filters',
  'myApp.services',
  'myApp.controllers',
  'myApp.directives',
  'myApp.common',
  'myApp.routeConfig'
]

angular.module('ngAnimate', []).factory '$$animateReflow', [
  '$window'
  '$timeout'
  ($window, $timeout) ->
    requestAnimationFrame = $window.requestAnimationFrame or $window.webkitRequestAnimationFrame or (fn) ->
      $timeout fn, 10, false
    cancelAnimationFrame = $window.cancelAnimationFrame or $window.webkitCancelAnimationFrame or (timer) ->
      $timeout.cancel timer
    (fn) ->
      id = requestAnimationFrame(fn)
      ->
        cancelAnimationFrame id
        return
]

app = angular.module('myApp', dependencies)

angular.module('myApp.routeConfig', ['ngRoute'])
.config ($routeProvider) ->
  $routeProvider
  .when('/', {
      templateUrl: '/assets/partials/view.html'
    })
  .when('/users/create', {
      templateUrl: '/assets/partials/create.html'
    })
  .when('/users/edit/:id', {
      templateUrl: '/assets/partials/update.html'
    })
  .when('/users/profile/:id', {
      templateUrl: '/assets/partials/profile.html'
      controller: 'ProfileCtrl'
      controllerAs: 'pc'
    })
  .when('/users/edit', {
      templateUrl: '/assets/partials/users.html'
    })
  .when('/admin', {
      templateUrl: '/assets/partials/admin.html'
    })
  .otherwise({redirectTo: '/'})
.config ($locationProvider) ->
  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false
  })

@commonModule = angular.module('myApp.common', [])
@controllersModule = angular.module('myApp.controllers', [])
@servicesModule = angular.module('myApp.services', [])
@modelsModule = angular.module('myApp.models', [])
@directivesModule = angular.module('myApp.directives', [])
@filtersModule = angular.module('myApp.filters', [])