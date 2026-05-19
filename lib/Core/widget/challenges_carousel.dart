import 'package:flutter/material.dart';
import '../../features/Home/widget/chalenges.dart';

class CardItem {
  final String urlImage;
  final String title;
  final String subtitle;

  const CardItem({
    required this.urlImage,
    required this.title,
    required this.subtitle,
  });
}

class ChallengesCarousel extends StatelessWidget {
  ChallengesCarousel({Key? key}) : super(key: key);

  final List<CardItem> items = [
    const CardItem(
      urlImage: "https://images.emojiterra.com/google/noto-emoji/unicode-15.1/color/share/1f36b.jpg",
      title: 'No Chocolate',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://www.dictionary.com/e/wp-content/uploads/2018/11/lollipop-emoji.png",
      title: 'No Sugar',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://static.wikia.nocookie.net/emoji5546/images/9/93/Bombono.png/revision/latest?cb=20230810175804",
      title: 'No sweets',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://media.sketchfab.com/models/f62974b78d244172b4162bce312188b3/thumbnails/d71e95bb20b843e4973d966b32836742/798f3664b8fc4b7da851cb7063bd0122.jpeg",
      title: 'No Fast Food',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/hot-beverage.png",
      title: 'No Coffee',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/wine-glass.png",
      title: 'No Alcohol',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIBzdHb33w560vmwTp-EI38sZAyi6FW9WrclzUUKNyuA&s",
      title: 'No Pizza',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://images.emojiterra.com/google/noto-emoji/unicode-15.1/color/share/1f969.jpg",
      title: 'No Meat ',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://cdn-icons-png.flaticon.com/512/2836/2836507.png",
      title: 'No Chips',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://em-content.zobj.net/source/apple/391/cigarette_1f6ac.png",
      title: 'No Cigarettes',
      subtitle: "Strat Challenge",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: const Color(0xff151724),
      child: ListView.separated(
        padding: const EdgeInsets.all(4),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) => _buildCard(context, items[index]),
        separatorBuilder: (context, _) => const SizedBox(width: 8),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CardItem item) {
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
                          return Chalengspage(item: item);
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
