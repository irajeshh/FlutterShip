part of './Page.dart';

class BlackIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const BlackIconButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Inkk(
        radius: 18,
        onTap: onTap,
        spalshColor: Colors.white70,
        child: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: TeslaColorz.iconBlack,
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
