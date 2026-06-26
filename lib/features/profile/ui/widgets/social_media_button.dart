import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const SocialMediaButton({
    super.key,
    required this.icon,
    this.gradientColors = const [],
    this.backgroundColor = Colors.blue,
    this.onTap,
  });

  factory SocialMediaButton.instagram({VoidCallback? onTap}) {
    return SocialMediaButton(
      icon: Icons.camera_alt_outlined,
      gradientColors: const [
        Color(0xFFFACC15),
        Color(0xFFEF4444),
        Color(0xFF9333EA),
      ],
      onTap: onTap,
    );
  }

  factory SocialMediaButton.facebook({VoidCallback? onTap}) {
    return SocialMediaButton(
      icon: Icons.facebook,
      backgroundColor: const Color(0xFF2563EB),
      onTap: onTap,
    );
  }

  factory SocialMediaButton.twitter({VoidCallback? onTap}) {
    return SocialMediaButton(
      icon: Icons.alternate_email,
      backgroundColor: const Color(0xFF38BDF8),
      onTap: onTap,
    );
  }

  factory SocialMediaButton.youtube({VoidCallback? onTap}) {
    return SocialMediaButton(
      icon: Icons.play_arrow,
      backgroundColor: const Color(0xFFDC2626),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gradientColors.isNotEmpty
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                )
              : null,
          color: gradientColors.isEmpty ? backgroundColor : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
