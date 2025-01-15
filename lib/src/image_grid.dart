import 'package:flutter/material.dart';
import 'package:image_grid_layout/src/image_grid_type.dart';

/// A customizable grid layout widget for displaying a collection of images in different arrangements.
///
/// This widget provides four different layout types for displaying images:
/// * Classic - A 2x2 grid with an additional row of 3 images below
/// * Columns - Four vertical columns of images with alternating heights
/// * Banner - A large banner image with text and a row of smaller images below
/// * Frame - Two large images on the left and three smaller images on the right
///
/// The widget requires a minimum of 5 images to function properly.
/// For images beyond the visible limit (5 for most layouts, 4 for columns),
/// a count indicator will be displayed showing the number of additional images.
///
class ImageGrid extends StatelessWidget {
  /// Creates an ImageGrid widget.
  ///
  /// The [type] parameter determines the layout style of the grid.
  /// The [images] parameter must contain at least 5 image URLs as strings.
  const ImageGrid({super.key, required this.type, required this.images});

  /// The type of grid layout to be used.
  /// See [ImageGridType] for available options.
  final ImageGridType type;

  /// List of image URLs to be displayed in the grid.
  /// Must contain at least 5 items.
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.length < 5) {
      throw ('image list MUST more than 5 items');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final scWidth = constraints.maxWidth;
        switch (type) {
          case ImageGridType.columns:
            // columns
            return _columnsLayout(scWidth, context);
          case ImageGridType.banner:
            // banner
            return _bannerLayout(scWidth, context);
          case ImageGridType.frame:
            // frame
            return _frameLayout(scWidth, context);
          default:
            // clssic
            return _classicLayout(scWidth, context);
        }
      },
    );
  }

  /// Creates a frame-style layout with two large images on the left
  /// and three smaller images on the right.
  ///
  /// The layout maintains a square aspect ratio with the width.
  Container _frameLayout(double scWidth, BuildContext context) {
    return Container(
      height: scWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 16),
            width: scWidth * 0.6,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 16),
            width: scWidth * 0.4,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          images[index + 2],
                          fit: BoxFit.cover,
                        ),
                      ),
                      (index == 2)
                          ? Center(
                              child: Text(
                                '+${images.length - 5}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: Colors.white),
                              ),
                            )
                          : SizedBox()
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Creates a banner-style layout with one large image at the top,
  /// followed by text and a row of smaller images.
  ///
  /// The layout maintains a square aspect ratio with the width.
  Widget _bannerLayout(double scWidth, BuildContext context) {
    return SizedBox(
      height: scWidth,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              width: scWidth,
              child: Image.network(
                images.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                'text',
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        images[index + 1],
                        fit: BoxFit.cover,
                      ),
                    ),
                    (index == 3)
                        ? Center(
                            child: Text(
                              '+${images.length - 5}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(color: Colors.white),
                            ),
                          )
                        : SizedBox()
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Creates a columns-style layout with four vertical columns of images.
  ///
  /// Alternate columns are offset vertically to create a staggered effect.
  /// The layout height is 80% of its width.
  Widget _columnsLayout(double scWidth, BuildContext context) {
    final scHeight = scWidth * 0.8;
    return SizedBox(
      height: scHeight,
      child: Row(
        children: images
            .asMap()
            .entries
            .take(4)
            .map(
              (e) => Container(
                margin: EdgeInsets.only(top: (e.key.isOdd) ? 32.0 : 0.0),
                width: scWidth / 4,
                height: (scHeight) - 32,
                child: Card(
                  elevation: 0.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          e.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                      (e.key == 3)
                          ? Center(
                              child: Text(
                                '+${images.length - 4}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: Colors.white),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  /// Creates a classic grid layout with two rows:
  /// * Top row: 2 equal-sized images
  /// * Bottom row: 3 equal-sized images
  ///
  /// The layout height is 80% of its width.
  Widget _classicLayout(double scWidth, BuildContext context) {
    final scHeight = scWidth * 0.8;
    return SizedBox(
      width: scWidth,
      height: scHeight,
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // top 2 images
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: images
                  .take(2)
                  .map(
                    (e) => Image.network(
                      e,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
            ),

            // bottom 3 and plus sign
            Row(
              children: images
                  .asMap()
                  .entries
                  .skip(2)
                  .take(3)
                  .map(
                    (e) => SizedBox(
                      height: scWidth * 0.3,
                      width: scWidth / 3,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              e.value,
                              fit: BoxFit.cover,
                            ),
                          ),
                          (e.key == 4)
                              ? Center(
                                  child: Text(
                                    '+${images.length - 5}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(color: Colors.white),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      }),
    );
  }
}
