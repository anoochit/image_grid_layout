# Flutter Image Post Layout

A customizable Flutter widget for displaying image collections in various grid layouts. This package provides an elegant way to showcase multiple images in different arrangements, perfect for galleries, social media feeds, or any image-rich interface.

## Features

- Multiple layout options for displaying image collections
- Automatic "show more" indicator for additional images
- Responsive design that adapts to screen width
- Customizable appearance through theme integration
- Minimum of 5 images required for optimal display

## Layout Types

### Classic Layout
- Top row: 2 equal-sized images
- Bottom row: 3 equal-sized images
- Height is 80% of width
- "+X" counter appears on the last image if there are more than 5 images

### Columns Layout
- Four vertical columns with alternating heights
- Staggered effect with odd-numbered columns offset
- Height is 80% of width
- "+X" counter appears on the last column if there are more than 4 images

### Banner Layout
- Large banner image at the top (3/6 of height)
- Text section in the middle (1/6 of height)
- Row of 4 smaller images at the bottom (2/6 of height)
- "+X" counter appears on the last small image if there are more than 5 images

### Frame Layout
- Two large images on the left (60% of width)
- Three smaller images on the right (40% of width)
- Square aspect ratio
- "+X" counter appears on the last right image if there are more than 5 images

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  image_post_layout: ^1.0.0
```

## Usage

```dart
import 'package:image_post_layout/image_grid_layout.dart';

// Create a list of image URLs (minimum 5 required)
final List<String> imageUrls = [
  'https://example.com/image1.jpg',
  'https://example.com/image2.jpg',
  'https://example.com/image3.jpg',
  'https://example.com/image4.jpg',
  'https://example.com/image5.jpg',
  // ... more images
];

// Use the widget with your preferred layout type
ImageGrid(
  type: ImageGridType.classic,
  images: imageUrls,
)
```

### Layout Types
 
 * `classic` : Traditional 2x2 grid with 3 images below
 * `columns` : Four vertical columns with alternating heights
 * `banner` : Large banner image with text and smaller images below
 * `frame` : Two large images on left, three smaller images on right
 
## Requirements

- Flutter SDK: >=2.12.0
- Dart SDK: >=2.12.0
- Minimum of 5 images in the image list

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.