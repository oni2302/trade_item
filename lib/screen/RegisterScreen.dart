import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_item/common/APIService.dart';
import 'package:trade_item/model/user.dart';
import 'package:trade_item/widget/form/register_form.dart';

import '../utils/constants.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password =  TextEditingController();
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
                  "Đăng ký",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: defaultPadding),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: RegisterForm(formKey: _formKey,email: email,password: password,),
                ),
                SizedBox(
                  height: size.height > 700 ? size.height * 0.01 : defaultPadding,
                ),
                ElevatedButton(
                  onPressed: () async{
                    if (noValidate|| _formKey.currentState!.validate()) {
                      // Perform registration logic here
                      APIService api = APIService();
                      User user = User(nameUser: '',emailUser: email.text,passwordUser: password.text,avatarUser: '',phoneUser: '');
                      var  res = await api.createUser(user.toJson());

                      if(res.data['status']!=500 &&res.data['status']==1){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đăng ký không thành công!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }

                    }
                  },
                  child: const Text(
                    "Đăng ký",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn đã có tài khoản?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text("Đăng nhập ngay!"),
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
