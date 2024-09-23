import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationCounterIcon extends StatelessWidget {
  const NotificationCounterIcon({super.key, this.iconColor = Colors.black});

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () async {
            //MyUser? user = await getUserFromLocal();
            //print("______________${user!.email}");
          },
          icon: const Icon(Iconsax.notification5),
          color: iconColor,
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: Colors.white, fontSizeFactor: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
