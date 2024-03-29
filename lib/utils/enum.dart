import 'package:test_design/constants/custom_string.dart';

enum PageViewContent {
  displayPlainColor,
  displayGreenColor,
  displayTextAndList
}

enum CarVerificationStep {
  leftSidePreCapture,
  leftSideCapture,
  leftSideVerify,

  rightSidePreCapture,
  rightSideCapture,
  rightSideVerify,

  frontSidePreCapture,
  frontSideCapture,
  frontSideVerify,

  verificationLoading,
  verificationCompleted,
}

String getSideName(CarVerificationStep step) {
  switch (step) {
    case CarVerificationStep.leftSidePreCapture:
    case CarVerificationStep.leftSideCapture:
    case CarVerificationStep.leftSideVerify:
      return 'Left';

    case CarVerificationStep.rightSidePreCapture:
    case CarVerificationStep.rightSideCapture:
    case CarVerificationStep.rightSideVerify:
      return 'Right';

    case CarVerificationStep.frontSidePreCapture:
    case CarVerificationStep.frontSideCapture:
    case CarVerificationStep.frontSideVerify:
      return 'Front';

    case CarVerificationStep.verificationCompleted:
      return 'Completed';

    default:
      return 'Unknown';
  }
}

String getSideImage(CarVerificationStep step) {
  switch (step) {
    case CarVerificationStep.leftSidePreCapture:
    case CarVerificationStep.leftSideCapture:
    case CarVerificationStep.leftSideVerify:
      return ConstantString.carLeftViewNoBg;

    case CarVerificationStep.rightSidePreCapture:
    case CarVerificationStep.rightSideCapture:
    case CarVerificationStep.rightSideVerify:
      return ConstantString.carRightViewNoBg;

    case CarVerificationStep.frontSidePreCapture:
    case CarVerificationStep.frontSideCapture:
    case CarVerificationStep.frontSideVerify:
      return ConstantString.carFrontViewNoBg;

    case CarVerificationStep.verificationCompleted:
      return ConstantString.carLeftViewNoBg;

    default:
      return ConstantString.carLeftViewNoBg;
  }
}
