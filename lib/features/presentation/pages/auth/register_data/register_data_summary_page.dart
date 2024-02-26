import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RegisterDataSummaryPage extends StatelessWidget {
  const RegisterDataSummaryPage({
    super.key,
    required this.userData,
    this.profilePicture,
    required this.images,
    required this.files,
  });

  final AuthUser userData;
  final File? profilePicture;
  final List<File> images;
  final List<File> files;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).extension<MyAppColors>()!;

    return Parent(
      appBar: MyAppBar(context, title: 'Preview detail Teknisi').call(),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: const SizedBox(),
              expandedHeight: 350.w,
              flexibleSpace: FlexibleSpaceBar(
                background: profilePicture != null
                    ? Image.file(profilePicture!)
                    : CachedNetworkImage(
                        imageUrl: userData.profilePicture!,
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimens.space24,
                      Dimens.space24,
                      Dimens.space24,
                      Dimens.space12,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${userData.name}',
                          style: textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SpacerH(value: Dimens.space24),
                        Icon(
                          Icons.star,
                          color: colorTheme.yellow,
                          size: Dimens.space20,
                        ),
                        Text(
                          '0 (0 ${Strings.of(context)!.reviews})',
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimens.space24, vertical: Dimens.space12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: colorTheme.blue,
                        ),
                        SpacerH(value: Dimens.space8),
                        Text.rich(
                          TextSpan(
                            style: textTheme.bodyLarge,
                            children: [
                              TextSpan(text: '${userData.address} '),
                              TextSpan(
                                  style: textTheme.bodySmall, text: '(10 km)'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimens.space24, vertical: Dimens.space12),
                    child: Wrap(
                      children: List.generate(
                        userData.electronics!.length,
                        (index) => ElectronicChip(
                          electronicId: userData.electronics![index],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.space24),
                    child: Divider(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimens.space24, vertical: Dimens.space12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.of(context)!.aboutMe,
                          style: textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SpacerV(value: Dimens.space8),
                        TextWithWrap(
                          text: userData.description!,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.space24,
                      vertical: Dimens.space12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.of(context)!.photosVideos,
                          style: textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SpacerV(value: Dimens.space12),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: Dimens.space8),
                              padding: EdgeInsets.all(Dimens.space8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.3),
                              ),
                              child: StaggeredGrid.count(
                                crossAxisCount:
                                    images.length > 2 ? 2 : images.length,
                                crossAxisSpacing: Dimens.space8,
                                mainAxisSpacing: Dimens.space8,
                                children: List.generate(
                                  images.length,
                                  (index) => StaggeredGridTile.fit(
                                    crossAxisCellCount: 1,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20.r),
                                      onTap: () {
                                        showAdaptiveDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                            image: images[index],
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: SizedBox(
                                          child: Image.file(
                                            images[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimens.space36),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
