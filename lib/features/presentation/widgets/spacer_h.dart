import 'package:flutter/material.dart';

import '../../../core/core.dart';

class SpacerH extends StatelessWidget {
  const SpacerH({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: value ?? Dimens.space8,
    );
  }
}
