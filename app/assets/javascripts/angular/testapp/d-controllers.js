angular.module('testapp')
    .controller('AskController', ['$scope', '$location', '$resource', '$log', 'GuessService',
        
    function($scope, $location, $resource, $log, GuessService) {    	

    	$scope.submitGuess = function() {
    		$scope.clearMessages();
    		$scope.clearGuessInfo();

    		GuessService.submitGuess($scope.measurements, function(successResponse) {
    			$scope.guessInfo.id  = successResponse.guessId;
    			$scope.guessInfo.likes = successResponse.likes;
    		}, function(errorResponse) {
    			$scope.messages.error = 'There was an error submitting your measurements, please try again';
    		});
    	};

    	$scope.confirmGuess = function(confirmed) {
    		$scope.clearMessages();

    		var params = {
    			guessId: $scope.guessInfo.id,
    			confirmed: confirmed
    		};

    		GuessService.confirmGuess(params, function(successResponse) {
    			$scope.messages.success = 'Thank you for confirming your guess!';

    			$scope.clearMeasurementInfo();
    			$scope.clearGuessInfo();

    		}, function(errorResponse) {
    			$scope.messages.error = 'There was an error confirming your guess, please try again';
    		});
    	};

    	$scope.clearMessages = function() {
    		$scope.messages = {
	    		success: null,
	    		error: null
	    	};
    	};

    	$scope.clearMeasurementInfo = function() {
    		$scope.measurements = {
	    		height: null,
	    		weight: null
    		};
    	};

    	$scope.clearGuessInfo = function() {
    		$scope.guessInfo = {
	    		id: null,
	    		likes: null
	    	};
    	};

    	$scope.clearMessages();
    	$scope.clearMeasurementInfo();
    	$scope.clearGuessInfo();
    }
]);