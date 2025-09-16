import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:yeong_mood_tracker/constants/colors.dart';
import 'package:yeong_mood_tracker/constants/gaps.dart';
import 'package:yeong_mood_tracker/constants/sizes.dart';
import 'package:yeong_mood_tracker/constants/text.dart';
import 'package:yeong_mood_tracker/view_models/c_login_vm.dart';
import 'package:yeong_mood_tracker/widgets/bottom_auth.dart';
import 'package:yeong_mood_tracker/widgets/form_button.dart';
import 'package:yeong_mood_tracker/widgets/input_clear_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "login";
  static const routeUrl = "/login";
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};
  bool _obscureText = true;

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
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

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(loginProvider.notifier).login(
              context: context,
              email: formData["email"]!,
              password: formData["password"]!,
            );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUpTap() {
    context.pop();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.d32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Image.asset("assets/images/clover.png"),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 15,
                  child: Column(
                    children: [
                      TtitleLarge20("Log in", fontSize: Sizes.d24),
                      Gaps.v20,
                      TbodyLarge18(
                        "당신의 일상은 클로바로 가득해요",
                        color: AppColors.neutral600,
                      ),
                      Gaps.v40,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "email@example.com",
                                suffix: _email.isNotEmpty
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InputClearButton(
                                            controller: _emailController,
                                          ),
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
                            Gaps.v10,
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "password",
                                suffix: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (_password.isNotEmpty) ...[
                                      InputClearButton(
                                          controller: _passwordController),
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
                            Gaps.v32,
                            FormButton(
                              title: "로그인",
                              onTap: _onSubmitTap,
                              disabled: _email.isEmpty ||
                                  _password.isEmpty ||
                                  ref.watch(loginProvider).isLoading,
                            ),
                            Gaps.v32,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAuth(
          title: "계정이 없으신가요?",
          buttonTitle: "회원가입",
          onTap: _onSignUpTap,
        ),
      ),
    );
  }
}
