export class SignUpController {
  constructor ($scope, $location, $auth) {
    'ngInject';

    $scope.$on('auth:registration-email-success', function() {
      $location.path('/expenses');
    });
    $scope.$on('auth:registration-email-error', function(ev, reason) {
      $scope.error = reason.errors[reason.errors.length - 1];
    });
    $scope.register = function() {
      $auth.submitRegistration($scope.registrationForm)
        .then(function() {
          $auth.submitLogin({
            name: $scope.registrationForm.name,
            email: $scope.registrationForm.email,
            password: $scope.registrationForm.password
          });
        });
    };
  }
}
