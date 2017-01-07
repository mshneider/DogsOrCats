angular.module('testapp')
    .factory('GuessService', function($resource, $q, $location, $log) {

    var guessService = {};

    guessService.submitGuess = function(json, successCallback, errorCallback) {
        var api = $resource('/guess/submit', {}, {
            save: {
                method: 'POST',
                isArray: false
            }
        });

        return api.save({}, json, successCallback, errorCallback);
    };

    guessService.confirmGuess = function(json, successCallback, errorCallback) {
        var api = $resource('/guess/confirm', {}, {
            update: {
                method: 'PUT',
                isArray: false
            }
        });

        return api.update({}, json, successCallback, errorCallback);
    };

    return guessService;
});
