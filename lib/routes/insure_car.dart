import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/services/global_methods.dart';
import 'package:uuid/uuid.dart';

class VehicleInsuranceForm extends StatefulWidget {
  static const routeName = "/VehicleInsuranceForm";

  @override
  _VehicleInsuranceFormState createState() => _VehicleInsuranceFormState();
}

class _VehicleInsuranceFormState extends State<VehicleInsuranceForm> {
  int currentStep = 0;
  bool isCompleted = false;
  GlobalMethods _globalMethods = GlobalMethods();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _modelFocusNode = FocusNode();
  final FocusNode _yearofManufactureFocusNode = FocusNode();
  final FocusNode _registrationNumberFocusNode = FocusNode();
  final FocusNode _estimatedValueFocusNode = FocusNode();
  var _vehicleMake = '';
  var _vehicleModel = '';
  var _yearofManufacture = '';
  var _registrationNumber = '';
  var _insurer = 'Not selected';
  var _paymentStatus = 'Not paid';
  var _premium = '0.00';
  String? _estimatedValue;
  String? _selectedCoverage;
  String? _selectedScope;
  DateTime _requestedAt = DateTime.now();
  // DateTime _expiryDate = _expiryDate.difference(_requestedAt);
  bool? value = true;
  bool _isLoading = false;
  var uuid = Uuid();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void dispose() {
    _modelFocusNode.dispose();
    _yearofManufactureFocusNode.dispose();
    _registrationNumberFocusNode.dispose();
    _estimatedValueFocusNode.dispose();
    super.dispose();
  }
  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_vehicleMake == null) {
          _globalMethods.authErrorHandle('Please enter make', context);
        } else {
          setState(() {
            _isLoading = true;
          });

          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          final vehicleId = uuid.v4();
          await FirebaseFirestore.instance
              .collection('InsuredVehicles')
              .doc(vehicleId)
              .set({
            'vehicleId': vehicleId,
            'vehicleMake': _vehicleMake,
            'vehicleModel': _vehicleModel,
            'registrationNumber': _registrationNumber,
            'yearofManufacture': _yearofManufacture,
            'insurer': _insurer,
            'paymentStatus': _paymentStatus,
            'estimatedValue': _estimatedValue,
            'selectedScope': _selectedScope,
            'vehiclePremium': _premium,
            'userId': _uid,
            'requestMade': _requestedAt,
            // 'expiryDate':
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        // _globalMethods.authErrorHandle(error.message, context);
        print('An Error Occurred ${error}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsConsts.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: _submitForm,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text('Submit',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
                GradientIcon(
                  Icons.file_upload_outlined,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      // Colors.yellow[800],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Insure vehicle"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                key: ValueKey('Vehcile Make'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Make cannot be null';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_modelFocusNode),
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.label_outlined),
                  labelText: 'Vehicle Make',
                ),
                onSaved: (value) {
                  _vehicleMake = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                key: ValueKey('Vehicle Model'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter model';
                  }
                  return null;
                },
                focusNode: _modelFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_yearofManufactureFocusNode),
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    prefixIcon: Icon(Icons.percent_outlined),
                    labelText: 'Vehicle Model',
                    fillColor: Theme.of(context).backgroundColor),
                onSaved: (value) {
                  _vehicleModel = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                key: ValueKey('Year of manufacture'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter year of manufacture';
                  }
                  return null;
                },
                focusNode: _yearofManufactureFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context)
                    .requestFocus(_registrationNumberFocusNode),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    prefixIcon: Icon(Icons.attach_money_outlined),
                    labelText: 'Year of manufacture',
                    fillColor: Theme.of(context).backgroundColor),
                onSaved: (value) {
                  _yearofManufacture = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                key: ValueKey('Registration number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter registration number';
                  }
                  return null;
                },
                focusNode: _registrationNumberFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_estimatedValueFocusNode),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'KAU 026B',
                    border: const UnderlineInputBorder(),
                    filled: true,
                    prefixIcon: Icon(Icons.attach_money_outlined),
                    labelText: 'Registration number',
                    fillColor: Theme.of(context).backgroundColor),
                onSaved: (value) {
                  _registrationNumber = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                key: ValueKey('Estimated value'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter estimated value';
                  }
                  return null;
                },
                focusNode: _estimatedValueFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    prefixIcon: Icon(Icons.attach_money_outlined),
                    labelText: 'Estimated value',
                    fillColor: Theme.of(context).backgroundColor),
                onSaved: (value) {
                  _estimatedValue = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  DropdownButton<String>(
                    items: const [
                      DropdownMenuItem<String>(
                        child: Text('Private'),
                        value: 'Private',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('PSV'),
                        value: 'PSV',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('TSV'),
                        value: 'TSV',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Motorcycle'),
                        value: 'Motorcycle',
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCoverage = value;
                        //_controller.text= _productCategory;
                        print(_selectedCoverage);
                      });
                    },
                    hint: Text('Select Coverage'),
                    value: _selectedCoverage,
                  ),
                  SizedBox(width: 70),
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem<String>(
                        child: Text('Comprehensive'),
                        value: 'Comprehensive',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Third party'),
                        value: 'Third party',
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        _selectedScope = value!;
                        //_controller.text= _productCategory;
                        print(_selectedScope);
                      });
                    },
                    hint: Text('Select Scope'),
                    value: _selectedScope,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*Text("Forgot password?", style: TextStyle(
                            color: Colors.orangeAccent[700],
                          ),),*/
                ],
              ),
            ),
            // SizedBox(height: 20,),
          ],
        ),

        /*isCompleted
            ? CompletedForm()
            : Theme(
          data: Theme.of(context).copyWith(
              colorScheme:
              ColorScheme.light(primary: ColorsConsts.stepperColor)),
          child: Stepper(
            // type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                setState(() {
                  isCompleted = true;
                });
                print('Completed');
                _submitForm;// Send data to server
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            */ /*controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                  return Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text("NEXT"),
                            onPressed: onStepContinue,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        if (currentStep != 0)
                          Expanded(
                            child: ElevatedButton(
                              child: Text("BACK"),
                              onPressed: onStepCancel,
                            ),
                          ),
                      ],
                    ),
                  );
                },*/ /*
            onStepTapped: (step) => setState(() => currentStep = step),
          ),
        ),*/
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
