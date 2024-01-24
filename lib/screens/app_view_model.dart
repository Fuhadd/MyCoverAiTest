import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_design/utils/enum.dart';

final verificationStepProvider = StateProvider.autoDispose<CarVerificationStep>(
    (ref) => CarVerificationStep.leftSidePreCapture);
