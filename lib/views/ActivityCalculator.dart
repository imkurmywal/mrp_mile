import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrpmile/utils/Fields.dart';
import 'package:mrpmile/utils/Utils.dart';

class ActivityCalculator extends StatefulWidget {
  @override
  _ActivityCalculatorState createState() => _ActivityCalculatorState();
}

class _ActivityCalculatorState extends State<ActivityCalculator> {
  var _loadedMilesController = TextEditingController();
  var _emptyMilesController = TextEditingController();
  var _averagePricePerGallonController = TextEditingController();
  var _tractorFuelGallonsController = TextEditingController();
  var _defGallonController = TextEditingController();
  var _grossEarningController = TextEditingController();
  var _otherIncomeController = TextEditingController();
  var _weeklyTruckPaymentController = TextEditingController();
  var _weeklyTrailerPaymentController = TextEditingController();
  var _truckInsuranceController = TextEditingController();
  var _medicalInsuranceController = TextEditingController();
  var _workersPremiumController = TextEditingController();
  var _licensePermitsRegistrationsController = TextEditingController();
  var _eldController = TextEditingController();
  var _phoneAndInternetFixedController = TextEditingController();
  var _fuleTractorReeferController = TextEditingController();
  var _defController = TextEditingController();
  var _mealsController = TextEditingController();
  var _phoneAndInternetVariableController = TextEditingController();
  var _bankFeesController = TextEditingController();
  var _permitsTollsAndTaxesController = TextEditingController();
  var _loadingUnloadingController = TextEditingController();
  var _maintenaceAndSuppliesController = TextEditingController();
  var _travelExpensesController = TextEditingController();
  var _factoringFeesController = TextEditingController();
  var _legalServicesController = TextEditingController();
  var _brokerFeesController = TextEditingController();
  var _professionalServicesController = TextEditingController();
  var _driverWagesController = TextEditingController();
  var _payrollTaxesController = TextEditingController();
  var _taxesController = TextEditingController();
  var _advanceFeesController = TextEditingController();
  var _uncollectableController = TextEditingController();
  var _collectionFeesController = TextEditingController();
  var _miscExpansesController = TextEditingController();
  String _errorText = 'Cannot be empty';
  bool _loadedMilesError = false;
  bool _emptyMilesError = false;
  bool _averagePricePerGallonError = false;
  bool _tractorFuelGallonsError = false;
  bool _defGallonError = false;
  bool _grossTruckIncomeError = false;
  bool _otherIncomeError = false;
  bool _weeklyTruckPaymentError = false;
  bool _weeklyTrailerPaymentError = false;
  bool _truckInsuranceError = false;
  bool _medicalInsuranceError = false;
  bool _workersPremiumError = false;
  bool _licensePermitsAndRegistrationError = false;
  bool _eldError = false;
  bool _phoneAndInternetFixedError = false;
  bool _fuleTractorReeferError = false;
  bool _defError = false;
  bool _mealsError = false;
  bool _phoneAndInternetVariableError = false;
  bool _bankFeesError = false;
  bool _permitsTollsAndTaxesError = false;
  bool _loadingAndUnloadingError = false;
  bool _maintenanceAndSuppliesError = false;
  bool _travelExpenseError = false;
  bool _factoringFeesError = false;
  bool _legalServicesError = false;
  bool _brokerFeesError = false;
  bool _professionalServciesError = false;
  bool _driverWagesError = false;
  bool _payrollError = false;
  bool _taxesError = false;
  bool _advanceFeesError = false;
  bool _uncollectableError = false;
  bool _collectionFeesError = false;
  bool _miscError = false;
  final greenColor = Color.fromRGBO(112, 173, 71, 1);
  final darkGreeColor = Color.fromRGBO(84, 130, 53, 1);

  double _fixedWeeklyExpanses = 0.0;
  double _variableWeeklyExpanses = 0.0;
  double _totalGrossIncome = 0.0;
  double _totalNetIncome = 0.0;
  double _totalExpanses = 0.0;
  double _companyTotal = 0.0;
  double _totalMiles = 0.0;
  double _mrpMile = 0.0;
  double _averageMPG = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MRPmile Calculator'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: _getBody(),
      ),
      onWillPop: () {},
    );
  }

  _getBody() {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getTitleContainer('Operation Specifics (Weekly)'),
            Fields.getField(
              controller: _loadedMilesController,
              hint: 'Loaded miles last week',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _loadedMilesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _emptyMilesController,
              hint: 'Empty miles last week',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _emptyMilesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _averagePricePerGallonController,
              hint: 'Average price per gallon',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _averagePricePerGallonError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _tractorFuelGallonsController,
              hint: 'Tractor fuel gallons last week',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _tractorFuelGallonsError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _defGallonController,
              hint: 'DEF gallons last week',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _defGallonError,
              errorMessage: _errorText,
            ),
            SizedBox(
              height: 32.0,
            ),
            _getTitleContainer('Operation Income (Weekly)'),
            Fields.getField(
              controller: _grossEarningController,
              hint: 'Gross trucks\' earning',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _grossTruckIncomeError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _otherIncomeController,
              hint: 'Other income sources',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _otherIncomeError,
              errorMessage: _errorText,
            ),
            SizedBox(
              height: 32.0,
            ),
            _getTitleContainer('Operation Fixed Expenses (Weekly)'),
            Fields.getField(
              controller: _weeklyTruckPaymentController,
              hint: 'Weekly truck payment',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _weeklyTruckPaymentError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _weeklyTrailerPaymentController,
              hint: 'Weekly trailer payment',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _weeklyTrailerPaymentError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _truckInsuranceController,
              hint: 'Truck insurance',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _truckInsuranceError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _medicalInsuranceController,
              hint: 'Medical insurance',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _medicalInsuranceError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _workersPremiumController,
              hint: 'Workers premium',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _workersPremiumError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _licensePermitsRegistrationsController,
              hint: 'Licenses, permits and registrations',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _licensePermitsAndRegistrationError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _eldController,
              hint: 'ELD',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _eldError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _phoneAndInternetFixedController,
              hint: 'Phone and internet',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _phoneAndInternetFixedError,
              errorMessage: _errorText,
            ),
            SizedBox(
              height: 32.0,
            ),
            _getTitleContainer('Operation Variable Expenses (Weekly)'),
            Fields.getField(
              controller: _fuleTractorReeferController,
              hint: 'Fuel - tractor + reefer',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _fuleTractorReeferError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _defController,
              hint: 'DEF',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _defError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _mealsController,
              hint: 'Meals',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _mealsError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _phoneAndInternetVariableController,
              hint: 'Phone and internet',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _phoneAndInternetVariableError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _bankFeesController,
              hint: 'Bank fees',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _bankFeesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _permitsTollsAndTaxesController,
              hint: 'Permits, tolls and taxes',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _permitsTollsAndTaxesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _loadingUnloadingController,
              hint: 'Loading and unloading fees',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _loadingAndUnloadingError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _maintenaceAndSuppliesController,
              hint: 'Maintenance and supplies',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _maintenanceAndSuppliesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _travelExpensesController,
              hint: 'Travel expense',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _travelExpenseError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _factoringFeesController,
              hint: 'Factoring fees',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _factoringFeesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _legalServicesController,
              hint: 'Legal services',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _legalServicesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _brokerFeesController,
              hint: 'Broker fees',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _brokerFeesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _professionalServicesController,
              hint: 'Professional services',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _professionalServciesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _driverWagesController,
              hint: 'Driver wages',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _driverWagesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _payrollTaxesController,
              hint: 'Payroll taxes for employees drivers',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _payrollError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _taxesController,
              hint: 'Taxes',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _taxesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _advanceFeesController,
              hint: 'Advance fees',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _advanceFeesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _uncollectableController,
              hint: 'Uncollectable receivables',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _uncollectableError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _collectionFeesController,
              hint: 'Collection fees',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _collectionFeesError,
              errorMessage: _errorText,
            ),
            Fields.getField(
              controller: _miscExpansesController,
              hint: 'Misc expenses and losses',
              isPassword: false,
              isNumber: true,
              isEmail: false,
              isError: _miscError,
              errorMessage: _errorText,
            ),
            SizedBox(
              height: 32.0,
            ),
            GestureDetector(
              onTap: _calculate,
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                color: Theme.of(context).accentColor,
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _calculate() {
    String loadedMilesLastWeek = _loadedMilesController.text.toString().trim();
    String emptyMilesLastWeek = _emptyMilesController.text.toString().trim();
    String averagePricePerGallon =
        _averagePricePerGallonController.text.toString().trim();
    String tractorFuelsGallonsLastWeek =
        _tractorFuelGallonsController.text.toString().trim();
    String defGallonsLastWeek = _defGallonController.text.toString().trim();
    String grossTrucksEarning = _grossEarningController.text.toString().trim();
    String otherIncome = _otherIncomeController.text.toString().trim();
    String weeklyTruckPayment =
        _weeklyTruckPaymentController.text.toString().trim();
    String weeklyTrailerPayment =
        _weeklyTrailerPaymentController.text.toString().trim();
    String truckInsurance = _truckInsuranceController.text.toString().trim();
    String medicalInsurance =
        _medicalInsuranceController.text.toString().trim();
    String workersPremium = _workersPremiumController.text.toString().trim();
    String licensesPermitsAndRegistrations =
        _licensePermitsRegistrationsController.text.toString().trim();
    String eld = _eldController.text.toString().trim();
    String phoneAndInternetFixed =
        _phoneAndInternetFixedController.text.toString().trim();
    String fuelTractorAndReefer =
        _fuleTractorReeferController.text.toString().trim();
    String def = _defController.text.toString().trim();
    String meals = _mealsController.text.toString().trim();
    String phoneAndInternetVariable =
        _phoneAndInternetVariableController.text.toString().trim();
    String bankFees = _bankFeesController.text.toString().trim();
    String permitsTollsAndTaxes =
        _permitsTollsAndTaxesController.text.toString().trim();
    String loadingAndUnloadingFees =
        _loadingUnloadingController.text.toString().trim();
    String maintenanceAndSupplies =
        _maintenaceAndSuppliesController.text.toString().trim();
    String travelExpenses = _travelExpensesController.text.toString().trim();
    String factoringFees = _factoringFeesController.text.toString().trim();
    String legalServices = _legalServicesController.text.toString().trim();
    String brokerFees = _brokerFeesController.text.toString().trim();
    String professionalServices =
        _professionalServicesController.text.toString().trim();
    String driverWages = _driverWagesController.text.toString().trim();
    String payroll = _payrollTaxesController.text.toString().trim();
    String taxes = _taxesController.text.toString().trim();
    String advanceFees = _advanceFeesController.text.toString().trim();
    String uncollectableReceivables =
        _uncollectableController.text.toString().trim();
    String collectionFees = _collectionFeesController.text.toString().trim();
    String miscExpenses = _miscExpansesController.text.toString().trim();

    setState(() {
      if (loadedMilesLastWeek.isEmpty) {
        _loadedMilesError = true;
      } else {
        _loadedMilesError = false;
      }
      if (emptyMilesLastWeek.isEmpty) {
        _emptyMilesError = true;
      } else {
        _emptyMilesError = false;
      }
      if (averagePricePerGallon.isEmpty) {
        _averagePricePerGallonError = true;
      } else {
        _averagePricePerGallonError = false;
      }
      if (tractorFuelsGallonsLastWeek.isEmpty) {
        _tractorFuelGallonsError = true;
      } else {
        _tractorFuelGallonsError = false;
      }
      if (defGallonsLastWeek.isEmpty) {
        _defGallonError = true;
      } else {
        _defGallonError = false;
      }
      if (grossTrucksEarning.isEmpty) {
        _grossTruckIncomeError = true;
      } else {
        _grossTruckIncomeError = false;
      }
      if (otherIncome.isEmpty) {
        _otherIncomeError = true;
      } else {
        _otherIncomeError = false;
      }
      if (weeklyTruckPayment.isEmpty) {
        _weeklyTruckPaymentError = true;
      } else {
        _weeklyTruckPaymentError = false;
      }
      if (weeklyTrailerPayment.isEmpty) {
        _weeklyTrailerPaymentError = true;
      } else {
        _weeklyTrailerPaymentError = false;
      }
      if (truckInsurance.isEmpty) {
        _truckInsuranceError = true;
      } else {
        _truckInsuranceError = false;
      }
      if (medicalInsurance.isEmpty) {
        _medicalInsuranceError = true;
      } else {
        _medicalInsuranceError = false;
      }
      if (workersPremium.isEmpty) {
        _workersPremiumError = true;
      } else {
        _workersPremiumError = false;
      }
      if (licensesPermitsAndRegistrations.isEmpty) {
        _licensePermitsAndRegistrationError = true;
      } else {
        _licensePermitsAndRegistrationError = false;
      }
      if (eld.isEmpty) {
        _eldError = true;
      } else {
        _eldError = false;
      }
      if (phoneAndInternetFixed.isEmpty) {
        _phoneAndInternetFixedError = true;
      } else {
        _phoneAndInternetFixedError = false;
      }
      if (fuelTractorAndReefer.isEmpty) {
        _fuleTractorReeferError = true;
      } else {
        _fuleTractorReeferError = false;
      }
      if (def.isEmpty) {
        _defError = true;
      } else {
        _defError = false;
      }
      if (meals.isEmpty) {
        _mealsError = true;
      } else {
        _mealsError = false;
      }
      if (phoneAndInternetVariable.isEmpty) {
        _phoneAndInternetVariableError = true;
      } else {
        _phoneAndInternetVariableError = false;
      }
      if (bankFees.isEmpty) {
        _bankFeesError = true;
      } else {
        _bankFeesError = false;
      }
      if (permitsTollsAndTaxes.isEmpty) {
        _permitsTollsAndTaxesError = true;
      } else {
        _permitsTollsAndTaxesError = false;
      }
      if (loadingAndUnloadingFees.isEmpty) {
        _loadingAndUnloadingError = true;
      } else {
        _loadingAndUnloadingError = false;
      }
      if (maintenanceAndSupplies.isEmpty) {
        _maintenanceAndSuppliesError = true;
      } else {
        _maintenanceAndSuppliesError = false;
      }
      if (travelExpenses.isEmpty) {
        _travelExpenseError = true;
      } else {
        _travelExpenseError = false;
      }
      if (factoringFees.isEmpty) {
        _factoringFeesError = true;
      } else {
        _factoringFeesError = false;
      }
      if (legalServices.isEmpty) {
        _legalServicesError = true;
      } else {
        _legalServicesError = false;
      }
      if (brokerFees.isEmpty) {
        _brokerFeesError = true;
      } else {
        _brokerFeesError = false;
      }
      if (professionalServices.isEmpty) {
        _professionalServciesError = true;
      } else {
        _professionalServciesError = false;
      }
      if (driverWages.isEmpty) {
        _driverWagesError = true;
      } else {
        _driverWagesError = false;
      }
      if (payroll.isEmpty) {
        _payrollError = true;
      } else {
        _payrollError = false;
      }
      if (taxes.isEmpty) {
        _taxesError = true;
      } else {
        _taxesError = false;
      }
      if (advanceFees.isEmpty) {
        _advanceFeesError = true;
      } else {
        _advanceFeesError = false;
      }
      if (uncollectableReceivables.isEmpty) {
        _uncollectableError = true;
      } else {
        _uncollectableError = false;
      }
      if (collectionFees.isEmpty) {
        _collectionFeesError = true;
      } else {
        _collectionFeesError = false;
      }
      if (miscExpenses.isEmpty) {
        _miscError = true;
      } else {
        _miscError = false;
      }
    });
    if (loadedMilesLastWeek.isNotEmpty &&
        emptyMilesLastWeek.isNotEmpty &&
        averagePricePerGallon.isNotEmpty &&
        tractorFuelsGallonsLastWeek.isNotEmpty &&
        defGallonsLastWeek.isNotEmpty &&
        grossTrucksEarning.isNotEmpty &&
        otherIncome.isNotEmpty &&
        weeklyTruckPayment.isNotEmpty &&
        weeklyTrailerPayment.isNotEmpty &&
        truckInsurance.isNotEmpty &&
        medicalInsurance.isNotEmpty &&
        workersPremium.isNotEmpty &&
        licensesPermitsAndRegistrations.isNotEmpty &&
        eld.isNotEmpty &&
        phoneAndInternetFixed.isNotEmpty &&
        fuelTractorAndReefer.isNotEmpty &&
        def.isNotEmpty &&
        meals.isNotEmpty &&
        phoneAndInternetVariable.isNotEmpty &&
        bankFees.isNotEmpty &&
        permitsTollsAndTaxes.isNotEmpty &&
        loadingAndUnloadingFees.isNotEmpty &&
        maintenanceAndSupplies.isNotEmpty &&
        travelExpenses.isNotEmpty &&
        factoringFees.isNotEmpty &&
        legalServices.isNotEmpty &&
        brokerFees.isNotEmpty &&
        professionalServices.isNotEmpty &&
        driverWages.isNotEmpty &&
        payroll.isNotEmpty &&
        taxes.isNotEmpty &&
        advanceFees.isNotEmpty &&
        uncollectableReceivables.isNotEmpty &&
        collectionFees.isNotEmpty &&
        miscExpenses.isEmpty) {
    } else {
      _totalMiles = (double.parse(loadedMilesLastWeek) +
          double.parse(emptyMilesLastWeek));
      _totalGrossIncome =
          (double.parse(grossTrucksEarning) + double.parse(otherIncome));
      _fixedWeeklyExpanses = (double.parse(weeklyTruckPayment) +
          double.parse(weeklyTrailerPayment) +
          double.parse(truckInsurance) +
          double.parse(medicalInsurance) +
          double.parse(workersPremium) +
          double.parse(licensesPermitsAndRegistrations) +
          double.parse(eld) +
          double.parse(phoneAndInternetFixed));
      _variableWeeklyExpanses = (double.parse(fuelTractorAndReefer) +
          double.parse(def) +
          double.parse(meals) +
          double.parse(phoneAndInternetVariable) +
          double.parse(bankFees) +
          double.parse(permitsTollsAndTaxes) +
          double.parse(loadingAndUnloadingFees) +
          double.parse(maintenanceAndSupplies) +
          double.parse(travelExpenses) +
          double.parse(factoringFees) +
          double.parse(legalServices) +
          double.parse(brokerFees) +
          double.parse(professionalServices) +
          double.parse(driverWages) +
          double.parse(payroll) +
          double.parse(taxes) +
          double.parse(advanceFees) +
          double.parse(uncollectableReceivables) +
          double.parse(collectionFees) +
          double.parse(miscExpenses));
      _totalExpanses = _fixedWeeklyExpanses + _variableWeeklyExpanses;
      _totalNetIncome = _totalGrossIncome - _totalExpanses;
      _companyTotal = _totalNetIncome;
      _mrpMile = ((_fixedWeeklyExpanses / _totalMiles) +
          (_variableWeeklyExpanses / _totalMiles));
      _averageMPG = (double.parse(loadedMilesLastWeek) +
              double.parse(loadedMilesLastWeek)) /
          double.parse(tractorFuelsGallonsLastWeek);
      print('MRPmile = $_mrpMile');
      print('Gross Income = $_totalGrossIncome');
      print('Gross Expenses = $_totalExpanses');
      print('Net Income = $_totalNetIncome');
      print('Company Total = $_companyTotal');
      _showDialog();
    }
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Results!'),
            content: Container(
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Average MPG'),
                  Text('\$ ${_averageMPG.toStringAsFixed(3)}'),
                  Divider(
                    thickness: 2,
                  ),
                  Text('Gross Income'),
                  Text('\$ $_totalGrossIncome'),
                  Divider(
                    thickness: 2,
                  ),
                  Text('Total Expenses'),
                  Text('\$ $_totalExpanses'),
                  Divider(
                    thickness: 2,
                  ),
                  Text('Total Net Income'),
                  Text('\$ $_totalNetIncome'),
                  Divider(
                    thickness: 2,
                  ),
                  Text('Company Net Profit'),
                  Text('\$ $_companyTotal'),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Cost Per Mile'),
                              Text('\$ ${_mrpMile.toStringAsFixed(3)}'),
                            ],
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.content_copy),
                              onPressed: () async {
                                await ClipboardManager.copyToClipBoard(
                                    '${_mrpMile.toStringAsFixed(3)}');
                                Utils.showToast(message: 'Copied');
                              },
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getTitleContainer(title) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      color: greenColor,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
