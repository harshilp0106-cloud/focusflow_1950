import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

import '../core/app_export.dart';

// V3 — Glassmorphism AppBar — BackdropFilter + transparent — LOCKED

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showAvatar;
  final bool showBell;
  final List<Widget>? actions;
  final bool isItalic;

  const AppBarWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.showAvatar = true,
    this.showBell = true,
    this.actions,
    this.isItalic = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 80 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 20,
            right: 16,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0F).withAlpha(179),
            border: const Border(
              bottom: BorderSide(color: Color(0xFF2C2C2E), width: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.manrope(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        fontStyle: isItalic
                            ? FontStyle.italic
                            : FontStyle.normal,
                        color: const Color(0xFFE8E8ED),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actions != null) ...actions!,
              if (showBell) ...[
                const SizedBox(width: 8),
                _GlassIconButton(
                  iconName: 'notifications_outlined',
                  onTap: () {},
                ),
              ],
              if (showAvatar) ...[const SizedBox(width: 8), _AvatarButton()],
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final String iconName;
  final VoidCallback onTap;

  const _GlassIconButton({required this.iconName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFF3A3A3C), width: 0.5),
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: iconName,
            color: const Color(0xFFAEAEB2),
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0xFFF97316).withAlpha(128),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: CustomImageWidget(
          imageUrl:
              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          semanticLabel:
              'Professional headshot of young man with short dark hair',
        ),
      ),
    );
  }
}
