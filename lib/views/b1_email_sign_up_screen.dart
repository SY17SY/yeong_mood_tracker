import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_mood_tracker/constants/colors.dart';
import 'package:yeong_mood_tracker/constants/gaps.dart';
import 'package:yeong_mood_tracker/constants/sizes.dart';
import 'package:yeong_mood_tracker/constants/text.dart';
import 'package:yeong_mood_tracker/view_models/b_sign_up_vm.dart';
import 'package:yeong_mood_tracker/widgets/form_button.dart';
import 'package:yeong_mood_tracker/widgets/input_clear_button.dart';

class EmailSignUpScreen extends ConsumerStatefulWidget {
  const EmailSignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends ConsumerState<EmailSignUpScreen> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _checkController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};
  bool _obscureText = true;

  String _name = "";
  String _email = "";
  String _password = "";
  String _check = "";

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    _checkController.addListener(() {
      setState(() {
        _check = _checkController.text;
      });
    });
  }

  String? _isEmailValid(String? input) {
    if (input == null || input.isEmpty) {
      return "이메일을 작성해 주세요.";
    }
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(input)) {
      return "이메일의 형식이 올바르지 않습니다.";
    }
    return null;
  }

  String? _isPasswordValid(String? input) {
    if (input == null || input.isEmpty) {
      return "비밀번호를 작성해 주세요.";
    }
    final baseRegExp = r"[A-Za-z0-9@$!%*#?&\^]";
    final regExpLen = r"{8,20}";
    final regExpChr = r"(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@$!%*#?&\^])";

    final regExp1 = RegExp(r"^" + regExpChr + baseRegExp);
    if (!regExp1.hasMatch(input)) {
      return "비밀번호의 형식이 올바르지 않습니다.";
    }
    final regExp2 = RegExp(r"^" + baseRegExp + regExpLen);
    if (!regExp2.hasMatch(input)) {
      return "비밀번호는 8~20자로 작성해주세요.";
    }
    return null;
  }

  String? _checkPassword(String? input) {
    if (input == null || input.isEmpty) {
      return "비밀번호를 한 번 더 작성해 주세요.";
    }
    if (input != _password) {
      return "비밀번호가 일치하지 않습니다.";
    }
    return null;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(signUpProvider.notifier).emailSignUp(
              context: context,
              name: formData["name"]!,
              email: formData["email"]!,
              password: formData["password"]!,
            );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: TtitleMedium18("회원가입")),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.d20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Gaps.v28,
                  TtitleMedium18("닉네임", color: AppColors.neutral500),
                  Gaps.v8,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "name",
                      suffix: _name.isNotEmpty
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InputClearButton(controller: _nameController),
                                Gaps.h8,
                              ],
                            )
                          : null,
                    ),
                    controller: _nameController,
                    autocorrect: false,
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['name'] = newValue;
                      }
                    },
                  ),
                  Gaps.v28,
                  TtitleMedium18("이메일", color: AppColors.neutral500),
                  Gaps.v8,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "email@example.com",
                      suffix: _email.isNotEmpty
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InputClearButton(controller: _emailController),
                                Gaps.h8,
                              ],
                            )
                          : null,
                    ),
                    controller: _emailController,
                    autocorrect: false,
                    validator: _isEmailValid,
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    },
                  ),
                  Gaps.v28,
                  TtitleMedium18("비밀번호", color: AppColors.neutral500),
                  Gaps.v8,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "password",
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_password.isNotEmpty) ...[
                            InputClearButton(controller: _passwordController),
                            Gaps.h16,
                          ],
                          GestureDetector(
                            onTap: _toggleObscure,
                            child: FaIcon(
                              _obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: AppColors.neutral400,
                              size: Sizes.d20,
                            ),
                          ),
                          Gaps.h8,
                        ],
                      ),
                    ),
                    controller: _passwordController,
                    autocorrect: false,
                    obscureText: _obscureText,
                    validator: _isPasswordValid,
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['password'] = newValue;
                      }
                    },
                  ),
                  Gaps.v28,
                  TtitleMedium18("비밀번호 확인", color: AppColors.neutral500),
                  Gaps.v8,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "password",
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_check.isNotEmpty) ...[
                            InputClearButton(controller: _checkController),
                            Gaps.h16,
                          ],
                          GestureDetector(
                            onTap: _toggleObscure,
                            child: FaIcon(
                              _obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: AppColors.neutral400,
                              size: Sizes.d20,
                            ),
                          ),
                          Gaps.h8,
                        ],
                      ),
                    ),
                    controller: _checkController,
                    autocorrect: false,
                    obscureText: _obscureText,
                    validator: _checkPassword,
                  ),
                  Gaps.v48,
                  FormButton(
                    title: "회원가입",
                    onTap: _onSubmitTap,
                    disabled: _name.isEmpty ||
                        _email.isEmpty ||
                        _password.isEmpty ||
                        ref.watch(signUpProvider).isLoading,
                  ),
                  Gaps.v48,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
