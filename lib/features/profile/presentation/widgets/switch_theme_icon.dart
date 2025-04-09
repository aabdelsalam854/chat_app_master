import 'package:chat_master/features/app/presentation/cubits/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchThemeIcon extends StatelessWidget {
  const SwitchThemeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        context.read<AppCubit>().changeTheme();
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(
              isDark ? 'assets/images/dark.png' : 'assets/images/light.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: isDark ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  isDark ? "assets/images/mon.png" : "assets/images/sun.png",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
 
    final isArabic = context.read<AppCubit>().state.locale.languageCode == 'ar';
    return GestureDetector(
      onTap: () {
   isArabic? context.read<AppCubit>().toEnglish() :     context.read<AppCubit>().toArabic();
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            color: isArabic ? Colors.blue : Colors.grey.shade300,
        ),
        child: Stack(
          alignment: Alignment.center,
   children: [
            // Texts for AR/EN in the background
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "AR",
                  style: TextStyle(
                    color: isArabic ? Colors.white : Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  "EN",
                  style: TextStyle(
                    color: isArabic ? Colors.black38 : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment:
                  isArabic ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    isArabic ? "AR" : "EN",
                    style: TextStyle(
                      color: isArabic ? Colors.blue : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





