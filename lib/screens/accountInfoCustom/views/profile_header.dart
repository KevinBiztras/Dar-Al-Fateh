import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String email;
  final String buttonText;
  final VoidCallback? buttonAction;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.buttonText,
    required this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 90,
                height: 90,
                color: Colors.grey.shade300,
                child: const Icon(Icons.person, color: Colors.white, size: 32),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.mail, size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // commonButton(context, (){}, buttonText),
                ElevatedButton(
                  onPressed: buttonAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFF9A825,
                    ), // saffron gold accent
                    foregroundColor: const Color(0xFF1A3C2B),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
