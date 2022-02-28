import 'package:flutter/material.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/widgets/form_complete.dart';

class TravelInsuranceApplicationForm extends StatefulWidget {
  static const routeName = "/TravelInsuranceApplicationForm";

  @override
  _TravelInsuranceApplicationFormState createState() => _TravelInsuranceApplicationFormState();
}

class _TravelInsuranceApplicationFormState extends State<TravelInsuranceApplicationForm> {
  int currentStep = 0;
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    List<Step> getSteps() => [
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Basic Info"),
          content: Container(
            // Travellers(senior, individual, family, student, group), destination, date of departure, duration
          )),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Select Insurance company"),
          content: Container()),
      Step(
          isActive: currentStep >= 3,
          title: Text("Pay"),
          content: Container()),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Marine Insurance"),
        centerTitle: true,
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
