import 'package:demandium/utils/core_export.dart';

class RatingBar extends StatelessWidget {
  final double? rating;
  final double? size;
  final int? ratingCount;
  final Color? color;
  const RatingBar({super.key, required this.rating, this.ratingCount, this.size = 18, this.color});

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int realNumber = rating!.floor();
    int partNumber = ((rating! - realNumber) * 10).ceil();


    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(Icon(Icons.star, color: color ?? Theme.of(context).colorScheme.primary, size: size));
      } else if (i == realNumber) {
        starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: color ?? Theme.of(context).colorScheme.primary, size: size),
              ClipRect(
                clipper: _Clipper(part: partNumber),
                child: Icon(Icons.star,
                    color: Theme.of(context).hintColor,
                    size: size),
              )
            ],
          ),
        ));
      }
      else {
        starList.add(Icon(
            Icons.star,
            color: Theme.of(context).hintColor,
            size: size));
      }
    }
    ratingCount != null ? starList.add(Padding(
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
      child: Directionality(textDirection: TextDirection.ltr, child: Text('($ratingCount)', style: robotoRegular.copyWith(fontSize: size!*0.8, color: Theme.of(context).disabledColor))),
    )) : const SizedBox();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
