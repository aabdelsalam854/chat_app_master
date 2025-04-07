import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';


import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  ForgetPasswordBody();
  }
}

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  _ForgetPasswordBodyState createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  // Future<void> _sendResetLink() async {
  //   if (!_formKey.currentState!.validate()) return;

  //   setState(() => _loading = true);

  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(
  //       email: _emailController.text.trim(),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('تم إرسال رابط إعادة تعيين كلمة المرور')),
  //     );
  //     Navigator.pop(context);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
  //     );
  //   }

  //   setState(() => _loading = false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إعادة تعيين كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'أدخل بريدك الإلكتروني لإرسال رابط إعادة تعيين كلمة المرور.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
         CustomTextFormField(
           controller: _emailController,
           hintText: 'Email',
           keyboardType: TextInputType.emailAddress,
         ),

              SizedBox(height: 20),
              CustomButton(onPressed: () {}, text: 'إرسال رابط إعادة تعيين كلمة المرور',),
              SizedBox(height: 20),
              if (_loading) CircularProgressIndicator(),
         
            ],
          ),
        ),
      ),
    );
  }
}
