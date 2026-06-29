<div align="center">
<h1>image_capture_field</h1>
<p><strong>A modern, effortless image input field with built-in cropping and fully customizable UI builders.</strong></p>

<p>
  <a href="https://pub.dev/packages/image_capture_field"><img src="https://img.shields.io/pub/v/image_capture_field.svg" alt="pub package"></a>
  <a href="https://github.com/therdm/image_capture_field/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
</p>

*Easy to Use • Inbuilt Cropper • Cross-Platform (Web & Mobile) • Custom UI Builders*

[Quick Start](#quick-start) • [Key Features](#key-features) • [Custom UI Customization](#custom-ui-customization) • [Best Practices](#best-practices) • [Screenshots](#screenshots)
</div>

---

## What is image_capture_field?

`ImageCaptureField` is a lightweight, drop-in replacement for standard image picking workflows. It acts exactly like a `TextField` but is designed specifically for images—complete with a reactive `ImageCaptureController`, automatic permission handling, native dialog sheets, compression options, and built-in cropping constraints.

---

## Installation

Add this to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  image_capture_field: ^0.3.0
```

Then run:

```bash
flutter pub get
```

---

## Quick Start

### Step 1: Create a Controller
Define the controller in your widget state or dependency manager:

```dart
final _controller = ImageCaptureController();
```

### Step 2: Display the Widget
Add the widget anywhere in your layout:

```dart
ImageCaptureField(
  controller: _controller,
)
```

### Step 3: Access Image Data
Access the picked image metadata:

```dart
// Check if an image is selected
final bool isEmpty = _controller.isBlank;

// Retrieve raw image bytes (Uint8List) - works on Android, iOS, and Web
final Uint8List? bytes = _controller.imageData;

// Get image filename or path
final String? filename = _controller.imageName;
final String? filepath = _controller.imagePath;

// Clear the selection/data
_controller.clear();
```

---

## Key Features

### 📸 Camera & Gallery Picker
Seamlessly handles image source sheets on mobile platforms (Camera & Gallery dialogs) and switches to native file picker dialogues on web browsers.

### ✂️ Integrated Image Cropper
Set up crop ratios inline to let users edit images before confirmation:

```dart
ImageCaptureField(
  controller: _controller,
  includeCropper: true,
  cropAspectRatio: 1.0, // Force a 1:1 aspect ratio (Square crop)
)
```

---

## Custom UI Customization

Override the default layout entirely using custom builders while letting the library manage permission requests, bottom sheets, web selectors, and image state.

| Property | Type | Description |
|---|---|---|
| `placeholderBuilder` | `Widget Function(BuildContext, VoidCallback pickImage)?` | UI to display before an image is selected. Call `pickImage` to trigger selection. |
| `imageBuilder` | `Widget Function(BuildContext, Uint8List, VoidCallback pickImage, VoidCallback clearImage)?` | UI to display the selected image. Exposes current image bytes, a `pickImage` callback to pick again, and `clearImage` to reset. |

```dart
ImageCaptureField(
  controller: _controller,
  placeholderBuilder: (context, pickImage) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        width: 250,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.teal.withValues(alpha: 0.04),
          border: Border.all(color: Colors.teal.shade300, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.teal.shade700),
            const SizedBox(height: 8),
            Text('Upload Photo', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade800)),
          ],
        ),
      ),
    );
  },
  imageBuilder: (context, imageData, pickImage, clearImage) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.memory(imageData, width: 250, height: 160, fit: BoxFit.cover),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: clearImage,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: const Icon(Icons.delete, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  },
)
```

---

## Best Practices

### ✅ Do's
- **Use Custom Builders**: Tailor the input field to fit your brand identity seamlessly.
- **Listen to Callback Events**: Use `onImagePathChanged` and `onImageBytesChanged` to update parent states or database tables when changes occur.
- **Use aspect ratios**: Always specify `cropAspectRatio` if your backend expects predefined dimension ratios.

### ❌ Don'ts
- **Avoid manual ImagePicker triggers**: There is no need to implement picker dialogues or state management manually. Use the controller lifecycle instead.
- **Don't force builders for standard inputs**: The default style works immediately and supports customized icons, background colors, and border shapes.

---

## Screenshots

<div style="display: flex; justify-content: space-between; flex-wrap: wrap; gap: 8px;">
    <img src="https://i.postimg.cc/hPTcZctq/1.jpg" width="140px" alt="1"/>
    <img src="https://i.postimg.cc/0yvxLFzK/2.jpg" width="140px" alt="2"/>
    <img src="https://i.postimg.cc/wBTzBNc6/3.jpg" width="140px" alt="3"/>
    <img src="https://i.postimg.cc/857VRV09/4.jpg" width="140px" alt="4"/>
    <img src="https://i.postimg.cc/0NWsKNc7/5.jpg" width="140px" alt="5"/>
    <img src="https://i.postimg.cc/mgSRRj9X/6.jpg" width="140px" alt="6"/>
</div>
