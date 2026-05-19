import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Home/view/widget/chalenges.dart';
import 'package:diety/features/profile/view/profile.dart';
import 'package:flutter/material.dart';

class HomeChallenges extends StatelessWidget {
  static const List<CardItem> _challenges = [
    CardItem(
      urlImage:
          "https://images.emojiterra.com/google/noto-emoji/unicode-15.1/color/share/1f36b.jpg",
      title: 'No Chocolate',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://www.dictionary.com/e/wp-content/uploads/2018/11/lollipop-emoji.png",
      title: 'No Sugar',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://static.wikia.nocookie.net/emoji5546/images/9/93/Bombono.png/revision/latest?cb=20230810175804",
      title: 'No sweets',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://media.sketchfab.com/models/f62974b78d244172b4162bce312188b3/thumbnails/d71e95bb20b843e4973d966b32836742/798f3664b8fc4b7da851cb7063bd0122.jpeg",
      title: 'No Fast Food',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/hot-beverage.png",
      title: 'No Coffee',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/wine-glass.png",
      title: 'No Alcohol',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIBzdHb33w560vmwTp-EI38sZAyi6FW9WrclzUUKNyuA&s",
      title: 'No Pizza',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://images.emojiterra.com/google/noto-emoji/unicode-15.1/color/share/1f969.jpg",
      title: 'No Meat ',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage: "https://cdn-icons-png.flaticon.com/512/2836/2836507.png",
      title: 'No Chips',
      subtitle: "Strat Challenge",
    ),
    CardItem(
      urlImage:
          "https://em-content.zobj.net/source/apple/391/cigarette_1f6ac.png",
      title: 'No Cigarettes',
      subtitle: "Strat Challenge",
    ),
  ];

  const HomeChallenges({super.key, this.items = _challenges});

  final List<CardItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 13),
          child: const Text(
            'Challenges',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 150,
          color: AppColors.background,
          child: ListView.separated(
            padding: const EdgeInsets.all(4),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _buildCard(context, item: items[index]),
            separatorBuilder: (context, _) => const SizedBox(
              width: 8,
            ),
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, {required CardItem item}) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 5 / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.white,
                child: Ink.image(
                  image: NetworkImage(item.urlImage),
                  fit: BoxFit.contain,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Chalengspage(
                            item: item,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          item.subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
