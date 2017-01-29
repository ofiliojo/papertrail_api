export class ExpensesController {
  constructor ($scope, Expense) {
    'ngInject';

    Expense.query().then(expenses => $scope.expenses = expenses);
  }
}
