export function routerConfig ($stateProvider, $urlRouterProvider) {
  'ngInject';
  $stateProvider
    .state('home', {
      url: '/',
      templateUrl: 'app/views/sign_up.html',
      controller: 'SignUpController',
      controllerAs: 'home'
    }).state('expenses', {
      url: '/expenses',
      templateUrl: 'app/views/expenses.html',
      controller: 'ExpensesController',
      controllerAs: 'expenses'
    });

  $urlRouterProvider.otherwise('/');
}
