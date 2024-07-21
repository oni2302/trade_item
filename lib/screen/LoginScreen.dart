import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trade_item/common/APIService.dart';
import 'package:trade_item/navigation/BottomNavigation.dart';
import 'package:trade_item/screen/HomeScreen.dart';
import 'package:trade_item/widget/form/login_form.dart';

import '../utils/constants.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Đăng nhập",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: defaultPadding),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: LogInForm(
                    formKey: _formKey,
                    email: email,
                    password: password,
                  ),
                ),
                SizedBox(
                  height:
                      size.height > 700 ? size.height * 0.01 : defaultPadding,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (noValidate|| _formKey.currentState!.validate()) {
                      // Perform login logic here
                      APIService api = APIService();
                      _formKey.currentState!.save();
                      var res = await api.loginUser({
                        'emailUser': email.text,
                        'passwordUser': password.text
                      });
                      print(res.data);
                      bool check = false;
                      if (res.data['status']!=500 && res.data['result']['status'] ==2 ) {
                        check = true;
                      }
                      if(check==true){
                        var box =  await Hive.openBox('user');
                        box.put('info', res.data['result']['info_user']);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigation(key: GlobalKey(),),
                            ), // Change this to your desired screen after login
                                (Route<dynamic> route) => false);
                        }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đăng nhập không thành công!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }

                  },
                  child:
                      const Text("Đăng nhập", style: TextStyle(fontSize: 15)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn chưa có tài khoản?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: const Text("Đăng kí ngay!"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
