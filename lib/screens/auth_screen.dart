// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exception.dart';

import '../providers/auth.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 50, 144, 199).withOpacity(0.5),
                  Color.fromARGB(255, 250, 250, 250).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/images/logo.png')),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 80.0),
                      transform: Matrix4.rotationZ(9 * pi / 170)
                        ..translate(-10.0),
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue.shade400,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: const Text(
                        'Kiến Shop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  /*
  ---------------------------------------------------------- Animation
  */
  AnimationController? _controller;
  Animation<Size>? _heightAnimation;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heightAnimation = Tween<Size>(
            begin: const Size(double.infinity, 260),
            end: const Size(double.infinity, 320))
        .animate(
      CurvedAnimation(parent: _controller!, curve: Curves.decelerate),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, -1.5), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeIn));
    _heightAnimation!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  //xóa listener khi dùng xong

  /*
  ---------------------------------------------------------- 
  */
  var _isLoading = false;
  final _passwordController = TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Có lỗi xảy ra'),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    //đóng hoioj thoại
                    child: const Text('OK'))
              ],
            ));
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false).login(
            _authData['email'] as String, _authData['password'] as String);
        // Log user in
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
            _authData['email'] as String, _authData['password'] as String);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Đăng kí thất bại';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Email này đã được sử dụng để đăng kí tài khoản khác.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Đây không phải địa chỉ email hợp lệ';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Mật khẩu phải trên 6 kí tự.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Không tìm thấy người dùng. Xin hãy thử lại.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Mật khẩu hoặc tài khoản chưa chính xác.';
      }
      _showErrorDialog(errorMessage);
      //chỉ lỗi nếu k xác thực được dữ liệu
      //catch đặc biệt
    } catch (error) {
      var errorMessage = 'Không thể xác minh . Hãy thử lại sau.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
      _controller!.forward();
      //chạy animation
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
      _controller!.reverse();
      //đảo
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: AnimatedBuilder(
          animation: _heightAnimation!,
          builder: (ctx, ch) => Container(
              // height: _authMode == AuthMode.signup ? 320 : 260,
              height: _heightAnimation!.value.height,
              constraints:
                  // BoxConstraints(minHeight: _authMode == AuthMode.signup ? 320 : 260),
                  BoxConstraints(
                minHeight: _heightAnimation!.value.height,
              ),
              width: deviceSize.width * 0.75,
              padding: const EdgeInsets.all(16.0),
              child: ch),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Email không hợp lệ!';
                      }
                      return null;
                      // return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mật khẩu'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Mật khẩu quá ngắn !';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 300),
                    constraints: BoxConstraints(
                        minHeight: _authMode == AuthMode.signup ? 60 : 0,
                        maxHeight: _authMode == AuthMode.signup ? 120 : 0),
                    child: FadeTransition(
                      opacity: _opacityAnimation!,
                      child: SlideTransition(
                        position: _slideAnimation!,
                        child: TextFormField(
                          enabled: _authMode == AuthMode.signup,
                          decoration: const InputDecoration(
                              labelText: 'Nhập lại mật khẩu'),
                          obscureText: true,
                          validator: _authMode == AuthMode.signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Mật khẩu phải giống nhau !';
                                  }
                                  return null;
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        primary: Theme.of(context).primaryColor,
                        // primary: Theme.of(context).primaryTextTheme.button.color,
                      ),
                      child: Text(_authMode == AuthMode.login
                          ? 'Đăng nhập'
                          : 'Đăng kí'),
                    ),
                  TextButton(
                    onPressed: _switchAuthMode,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                        '${_authMode == AuthMode.login ? 'Chưa có tài khoản ?' : 'Đã có tài khoản ?'} '),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
