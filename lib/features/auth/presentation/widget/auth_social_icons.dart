
import 'package:chat_master/features/auth/presentation/widget/social_login_button.dart';
import 'package:flutter/material.dart';



class AuthSocialIcons extends StatelessWidget {
  const AuthSocialIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginButton(
          onPressed: () {
            // BlocProvider.of<AuthCubit>(context).loginWithGoogle();
          },
          image: 'assets/images/google.png',
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          onPressed: () {
            // BlocProvider.of<AuthCubit>(context).loginWithFacebook();
          },
          image: 'assets/images/facebook.png',
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          onPressed: () {
            // BlocProvider.of<AuthCubit>(context).loginWithTwitter();
          },
          image: 'assets/images/twitter.png',
        ),
      ],
    );
  }
}
