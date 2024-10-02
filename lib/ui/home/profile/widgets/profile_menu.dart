import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    this.icon,
    this.isGuest = false,
  });

  final String title, value;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 2, right: 18),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: MyColors.grey,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black45,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Icon
              if(!isGuest) IconButton(
                icon: Icon(icon, size: 19),
                onPressed: icon == null ? null : onPressed,
              ),

              const Spacer(),

              // Value
              Expanded(
                flex: 9,
                child: Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
