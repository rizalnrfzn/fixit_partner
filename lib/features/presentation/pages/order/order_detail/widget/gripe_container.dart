import 'package:fixit_partner/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GripeContainer extends StatefulWidget {
  const GripeContainer({
    super.key,
    required this.gripe,
  });

  final List<String> gripe;

  @override
  State<GripeContainer> createState() => _GripeContainerState();
}

class _GripeContainerState extends State<GripeContainer> {
  bool isOpen = false;

  void onTap() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.all(Dimens.space16),
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.space24,
        vertical: Dimens.space12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Theme.of(context).hintColor.withOpacity(0.3),
      ),
      child: isOpen
          ? Column(
              children: [
                InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimens.space8,
                      horizontal: Dimens.space8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.of(context)!.gripe,
                          style: textTheme.bodyLarge,
                        ),
                        const Icon(Icons.keyboard_arrow_up),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    widget.gripe.length,
                    (index) => Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.space20,
                            vertical: Dimens.space12,
                          ),
                          child: Container(
                            width: Dimens.space8,
                            height: Dimens.space8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: Dimens.space12),
                            child: Text(widget.gripe[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimens.space8,
                  horizontal: Dimens.space8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.of(context)!.gripe,
                      style: textTheme.bodyLarge,
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
    );
  }
}
