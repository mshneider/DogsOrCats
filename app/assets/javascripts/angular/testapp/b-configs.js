angular.module('testapp')
    .config(['$routeProvider', function($routeProvider) {

        $routeProvider
	        .when('/guess', {
	        	templateUrl: '/angular/guess.tpl.html',
	        	controller: 'AskController'
	        })
        	.otherwise({
	            resolve: {
	                load: function($q, $resource, $location) {
	                    var defer = $q.defer();

	                    $location.path('/guess');
	                    defer.resolve();

	                    return defer.promise;
	                }
	            }
        	});
    }
]);
