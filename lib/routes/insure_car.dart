import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/models/vehicle_underwriters_attributes.dart';
import 'package:hilleninsure/widgets/form_complete.dart';
import 'package:provider/provider.dart';

class VehicleInsuranceForm extends StatefulWidget {
  static const routeName = "/VehicleInsuranceForm";

  @override
  _VehicleInsuranceFormState createState() => _VehicleInsuranceFormState();
}

class _VehicleInsuranceFormState extends State<VehicleInsuranceForm> {
  int currentStep = 0;
  bool isCompleted = false;
  final _formKey = GlobalKey<FormState>();
  var _vehicleMake = '';
  var _vehicleModel = '';
  var _yearofManufacture = '';
  var _registrationNumber = '';
  int? _estimatedValue;
  String? _selectedCoverage;
  bool? _selectedScope;
  bool? value = true;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print(_vehicleMake);
      print(_vehicleModel);
      print(_yearofManufacture);
      print(_registrationNumber);
      print(_estimatedValue);
      // Use those values to send our auth request ...
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicleinsurer = Provider.of<VehicleInsurer>(context);
    List<Step> getSteps() =>
        [
          Step(
              state: currentStep > 0 ? StepState.complete : StepState.indexed,
              isActive: currentStep >= 0,
              title: Text("Vehicle Details"),
              content: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: 150,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            key: ValueKey('Make'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Make';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _vehicleMake = value!;
                            },
                            decoration: InputDecoration(
                                labelText: "Make",
                                hintText: "Toyota",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: 150,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            key: ValueKey('Model'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Model';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _vehicleModel = value!;
                            },
                            decoration: InputDecoration(
                                labelText: "Model",
                                hintText: "Land cruiser V8",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: 150,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            key: ValueKey('Year of manufacture'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Vehicle has to be manufactured';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _yearofManufacture = value!;
                            },
                            decoration: InputDecoration(
                                labelText: "Year of manufacture",
                                hintText: "2015",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: 150,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            key: ValueKey('Registration Number'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter registration number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _registrationNumber = value!;
                            },
                            decoration: InputDecoration(
                                labelText: "Registration number",
                                hintText: "KAO 001A",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .75,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Estimated value is missed';
                              }
                              return null;
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                                labelText: "Estimated value",
                                hintText: "1000000",
                                border: UnderlineInputBorder()
                            ),
                            onSaved: (value) {
                              _estimatedValue = value! as int;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButton<String>(
                            items: [
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
                            hint: Text('Comprehensive?'),
                            value: _selectedCoverage,
                          ),
                          SizedBox(width: 5,),
                          DropdownButton<bool>(
                            items: [
                              DropdownMenuItem<bool>(
                                child: Text('Yes'),
                                value: true,
                              ),
                              DropdownMenuItem<bool>(
                                child: Text('No'),
                                value: false,
                              ),
                            ],
                            onChanged: (bool? value) {
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
                  ],
                ),
              )),
          Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text("Underwriters"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},/*=> Navigator.pushNamed(context, ProductDetails.routeName,
                    arguments: productsAttributes.id),*/
                child: Container(
                  width: 250,
                  height: 290,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).backgroundColor),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Container(
                                  width: double.infinity,
                                  constraints: BoxConstraints(
                                      minHeight: 100,
                                      maxHeight:
                                      MediaQuery.of(context).size.height * 0.3),
                                  child: Image.network(
                                    vehicleinsurer.imageUrl,
                                    //   fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              vehicleinsurer.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'KES. ${_selectedScope! ? _estimatedValue! * vehicleinsurer.comprehensive_rate : vehicleinsurer.third_party_rate }',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Step(
              state: currentStep > 2 ? StepState.complete : StepState.indexed,
              isActive: currentStep >= 2,
              title: Text("Extra features"),
              content: Container(child: Text("Second step"))),
          Step(
              state: currentStep > 3 ? StepState.complete : StepState.indexed,
              isActive: currentStep >= 3,
              title: Text("Extra question"),
              content: Container(
                child: Text("Step 3"),
              )),
          Step(
              state: currentStep > 4 ? StepState.complete : StepState.indexed,
              isActive: currentStep >= 4,
              title: Text("Complete"),
              content: Container(
                child: Text("Confirm information"),
              )),
          Step(
              isActive: currentStep >= 5,
              title: Text("Pay"),
              content: Container()),
        ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Insure vehicle"),
      ),
      body: isCompleted
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
              // Send data to server
            } else {
              setState(() => currentStep += 1);
            }
          },
          onStepCancel: currentStep == 0
              ? null
              : () => setState(() => currentStep -= 1),
          /*controlsBuilder: (context, {onStepContinue, onStepCancel}) {
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
                },*/
          onStepTapped: (step) => setState(() => currentStep = step),
        ),
      ),
    );
  }
}
