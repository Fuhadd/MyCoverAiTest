import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_design/utils/enum.dart';

final verificationStepProvider = StateProvider<CarVerificationStep>(
    (ref) => CarVerificationStep.leftSidePreCapture);

final verifiedCountProvider = StateProvider<int>((ref) => 0);

final selectedImageFileProvider = StateProvider<Uint8List?>((ref) => null);
