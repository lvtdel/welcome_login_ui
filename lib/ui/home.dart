import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../Constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  // late FocusNode _emailFocusNode;
  // late FocusNode _passwordFocusNode;
  // Dùng khi muốn focus tự do như FocusScope...RequestFocus(_focusNode)
  // Nếu chỉ cần FocusScope....nextFocus() thì không cần

  @override
  void initState() {
    super.initState();

    // _emailFocusNode = FocusNode();
    // _passwordFocusNode = FocusNode();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      _onKeyboardVisibleChange(visible);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(18),
          width: size.width,
          height: size.height + 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: RichText(
                  text: const TextSpan(
                      text: "Your",
                      style: TextStyle(
                          fontSize: 32,
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: " workout partner",
                            style: TextStyle(color: Colors.black87))
                      ]),
                ),
              ),
              SizedBox(
                height: size.height * .3,
                child: Image.asset("assets/workout.png"),
              ),
              Container(
                height: size.height * .3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      )
                    ]),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned(
                        top: 10,
                        left: 20,
                        child: Text(
                          "Login Here",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                    Positioned(
                        top: 50,
                        left: 20,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.mail_outline,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 300,
                                  child: TextField(
                                    // keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    // focusNode: _emailFocusNode,
                                    onEditingComplete: () {
                                      // Focus.of(context).requestFocus(_passwordFocusNode);
                                      FocusScope.of(context).nextFocus();
                                    },
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(color: Colors.black54),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "example@gmail.com"),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: size.width * .8,
                              child: const Divider(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        )),
                    Positioned(
                        top: 120,
                        left: 20,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 300,
                                  child: TextField(
                                    // keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    onEditingComplete: () {
                                      _onClickLogin(context);
                                    },
                                    obscureText: true,
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        letterSpacing: 1.4),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "-----------",
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: size.width * .8,
                              child: const Divider(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        )),
                    Positioned(
                      top: 180,
                      left: 20,
                      child: SizedBox(
                        width: size.width * .8,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create Account",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              "Forgot Password",
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      right: 30,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _onClickLogin(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xff382743),
                                  Color(0xffff4590)
                                ],
                                stops: [
                                  0,
                                  1
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/right-arrow.png"),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onClickLogin(BuildContext context) {
    _showMyDialog(context);
  }

  _onKeyboardVisibleChange(visible) async {
    if (visible == true) {
      await Future.delayed(const Duration(milliseconds: 400));
      _scrollController.animateTo(
          350, duration: const Duration(milliseconds: 200),
          curve: Curves.linear);
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.check_circle,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
                Text('Bạn đã đăng nhập thành công!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
