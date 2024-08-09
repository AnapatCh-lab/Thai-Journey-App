import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:auto_animated/auto_animated.dart';
import '../../constant/constant.dart';
import 'value/list_image.dart';

class SuggestPage extends StatelessWidget {
  const SuggestPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final localization = AppLocalizations.of(context)!;

    // Define your list with translated tags
    final List<SuggestItem> souvenier = [
      SuggestItem(imagePath: 'assets/แคบหมู.png', tag: localization.sou1),
      SuggestItem(imagePath: 'assets/หมูยอ.png', tag: localization.sou2),
      SuggestItem(imagePath: 'assets/ไส้อั่ว.jpg', tag: localization.sou3),
      SuggestItem(imagePath: 'assets/ข้าวแต๋น.jpg', tag: localization.sou4),
      SuggestItem(imagePath: 'assets/ถ้วยกาไก่.jpg', tag: localization.sou5),
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.height(3)),
        child: LiveGrid.options(
          options: const LiveOptions(
            delay: Duration(milliseconds: 100),
            showItemInterval: Duration(milliseconds: 100),
            showItemDuration: Duration(milliseconds: 200),
            reAnimateOnVisibility: true,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 9,
            mainAxisSpacing: 10,
          ),
          itemCount: souvenier.length,
          itemBuilder: (context, index, animation) {
            return buildAnimatedItem(context, index, animation, souvenier);
          },
        ),
      ),
    );
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
    List<SuggestItem> souvenier,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(animation),
          child: GridItemWidget(item: souvenier[index]),
        ),
      );
}

class GridItemWidget extends StatelessWidget {
  final SuggestItem item;

  const GridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.height(0.5)),
            child: Text(
              item.tag,
              style: TextStyle(
                fontSize: SizeConfig.height(2.2),
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
