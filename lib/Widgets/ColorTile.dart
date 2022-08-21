part of './Widgets.dart';

class ColorTile extends StatelessWidget {
  final Color? color;
  final dynamic title;
  final dynamic subtitle;
  final IconData? icon;
  final VoidCallback? onTap;
  const ColorTile(
      {Key? key, this.color = Colors.grey, this.title, this.subtitle, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: InkWell(
        splashColor: color,
        onTap: onTap,
        child: Card(
          elevation: 0,
          color: color?.withOpacity(0.03),
          shadowColor: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: color),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: title,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        color: color,
                      ),
                      Txt(
                        text: subtitle,
                        maxLines: 1,
                        color: color,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Widgets.arrow(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
