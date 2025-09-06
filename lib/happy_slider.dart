import 'package:flutter/material.dart';

/// A customizable slide-to-confirm widget that provides a smooth sliding interaction.
///
/// The HappySlider allows users to slide a button from left to right to confirm an action.
/// It supports extensive customization including colors, text, icons, and button content.
///
/// Example usage:
/// ```dart
/// HappySlider(
///   width: 300,
///   height: 60,
///   text: 'Slide to confirm',
///   onSlideComplete: () => print('Slide completed!'),
/// )
/// ```
class HappySlider extends StatefulWidget {
  /// Total width of the slider widget
  final double width;

  /// Width of the draggable slider button
  final double sliderWidth;

  /// Height of the slider widget
  final double height;

  /// Callback function executed when slide is completed (reaches threshold)
  final VoidCallback onSlideComplete;

  /// Color of the widget border
  final Color borderColor;

  /// Background color of the slider button
  final Color buttonColor;

  /// Background color of the slider container
  final Color backgroundColor;

  /// Width of the border stroke
  final double borderWidth;

  /// Text displayed in the background of the slider
  final String text;

  /// Style for the background text
  final TextStyle? textStyle;

  /// Style for the button text (when using buttonText)
  final TextStyle? buttonTextStyle;

  /// Border radius for rounded corners
  final double borderRadius;

  // Button customization properties

  /// Custom widget to replace the entire slider button content
  final Widget? sliderButton;

  /// Text to display on the slider button
  final String? buttonText;

  /// Custom icon to display on the slider button
  final Widget? buttonIcon;

  /// Spacing between button text and icon
  final double? buttonIconSpacing;

  /// Whether to show the default arrow icon when no custom icon is provided
  final bool showDefaultIcon;

  /// Color of the default arrow icon
  final Color? defaultIconColor;

  /// Size of the default arrow icon
  final double? defaultIconSize;

  /// Horizontal alignment of button content
  final MainAxisAlignment buttonContentAlignment;

  /// Vertical alignment of button content
  final CrossAxisAlignment buttonCrossAxisAlignment;

  const HappySlider({
    super.key,
    required this.width,
    required this.height,
    required this.onSlideComplete,
    this.borderColor = Colors.grey,
    this.buttonColor = Colors.orange,
    this.backgroundColor = Colors.transparent,
    this.borderWidth = 2.0,
    this.text = 'Slide to confirm',
    this.textStyle,
    this.buttonTextStyle,
    this.borderRadius = 25.0,
    this.sliderWidth = 160,
    this.sliderButton,
    this.buttonText,
    this.buttonIcon,
    this.buttonIconSpacing = 14.0,
    this.showDefaultIcon = true,
    this.defaultIconColor = Colors.black,
    this.defaultIconSize = 24.0,
    this.buttonContentAlignment = MainAxisAlignment.center,
    this.buttonCrossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  State<HappySlider> createState() => _HappySliderState();
}

class _HappySliderState extends State<HappySlider>
    with SingleTickerProviderStateMixin {
  /// Current horizontal position of the draggable button
  double _dragPosition = 0.0;

  /// Flag to track if user is currently dragging the button
  bool _isDragging = false;

  /// Controller for the reset animation when slide is not completed
  late AnimationController _animationController;

  /// Animation that smoothly returns the button to start position
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Handles the start of drag gesture
  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  /// Updates button position during drag gesture
  void _onPanUpdate(DragUpdateDetails details) {
    final spacing = widget.borderWidth;
    final maxDragDistance = widget.width - widget.sliderWidth - (4 * spacing);

    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(
        0.0,
        maxDragDistance,
      );
    });
  }

  /// Handles the end of drag gesture and determines completion
  void _onPanEnd(DragEndDetails details) {
    final spacing = widget.borderWidth;
    final maxDragDistance = widget.width - widget.sliderWidth - (2 * spacing);
    final threshold = maxDragDistance * 0.8; // 80% of available distance

    if (_dragPosition >= threshold) {
      // Slide completed successfully
      widget.onSlideComplete();
      _resetToOriginalPosition();
    } else {
      // Slide not completed, return to start
      _resetToOriginalPosition();
    }

    setState(() {
      _isDragging = false;
    });
  }

  /// Animates the button back to its original position
  void _resetToOriginalPosition() {
    _animation = Tween<double>(begin: _dragPosition, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.reset();
    _animationController.forward();

    _animation.addListener(() {
      setState(() {
        _dragPosition = _animation.value;
      });
    });
  }

  /// Builds the default arrow icon (rotated double arrow pointing right)
  Widget _buildDefaultIcon() {
    return Transform.rotate(
      angle: 3.14159, // 180 degrees rotation
      child: Icon(
        Icons.keyboard_double_arrow_left,
        color: widget.defaultIconColor,
        size: widget.defaultIconSize,
      ),
    );
  }

  /// Builds the content inside the slider button based on provided properties
  Widget _buildSliderContent() {
    // Use custom slider button if provided
    if (widget.sliderButton != null) {
      return widget.sliderButton!;
    }

    // Build content from individual components
    List<Widget> children = [];

    // Add button text if provided
    if (widget.buttonText != null && widget.buttonText!.isNotEmpty) {
      children.add(
        Text(
          widget.buttonText!,
          style:
              widget.buttonTextStyle ??
              TextStyle(
                color: widget.defaultIconColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
      );
    }

    // Add icon with spacing
    if (widget.buttonIcon != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(width: widget.buttonIconSpacing));
      }
      children.add(widget.buttonIcon!);
    } else if (widget.showDefaultIcon) {
      if (children.isNotEmpty) {
        children.add(SizedBox(width: widget.buttonIconSpacing));
      }
      children.add(_buildDefaultIcon());
    }

    return Row(
      mainAxisAlignment: widget.buttonContentAlignment,
      crossAxisAlignment: widget.buttonCrossAxisAlignment,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Stack(
        children: [
          // Background text centered in the slider
          Positioned.fill(
            child: Center(
              child: Text(
                widget.text,
                style:
                    widget.textStyle ??
                    TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),

          // Draggable slider button positioned based on drag state
          Positioned(
            left: widget.borderWidth + _dragPosition,
            top: widget.borderWidth,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: widget.sliderWidth,
                height: widget.height - (4 * widget.borderWidth),
                decoration: BoxDecoration(
                  color: _isDragging ? Colors.blue : widget.buttonColor,
                  // Change color when dragging
                  borderRadius: BorderRadius.circular(widget.borderRadius - 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: _isDragging ? 8 : 4,
                      // Increase blur when dragging
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildSliderContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
