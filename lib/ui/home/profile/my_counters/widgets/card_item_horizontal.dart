import 'package:flutter/material.dart';
import '../../../../../data/models/counter.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/screen_util.dart';
import '../../../../shared_widgets/rounded_container.dart';
import '../../../../shared_widgets/rounded_image.dart';

class CardItemHorizontal extends StatelessWidget {
  final Counter counter;

  const CardItemHorizontal({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Container(
            width: ScreenUtil().screenWidth,
            height: 145,
            padding: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              color: MyColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image
                Expanded(
                  flex: 2,
                  child: RoundedContainer(
                    height: 145,
                    width: double.infinity,
                    backgroundColor: MyColors.light,
                    child: RoundedImage(
                      imgUrl: counter.imageUrl,
                      applyImgRadius: true,
                      backgroundColor: MyColors.darkGrey,
                      fit: BoxFit.cover,
                      isNetworkImage: true,
                    ),
                  ),
                ),
                // Details
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                counter.title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: MyColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        // Daily Income
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(MyImages.dollarAnimation, height: 22),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                '${counter.dailyIncome.toDouble()} : ${MyTexts.dailyIncome}',
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Price
                        Flexible(
                          child: Text(
                            '\$ ${counter.price} : ${MyTexts.counterPrice}',
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // Expire
                        Flexible(
                          child: Text(
                            '${MyTexts.counterExpire} : ${counter.expireDate}',
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // // Buy Times
                        // Flexible(
                        //   child: Text(
                        //     '${MyTexts.counterBuyTimes} : ${counter.buysNumber}',
                        //     maxLines: 1,
                        //     textAlign: TextAlign.end,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: const TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (!counter.isAvailable)
            Container(
              width: ScreenUtil().screenWidth,
              height: 145,
              padding: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'العداد لم يعد يعمل',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
