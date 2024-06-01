import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pendidikan_milenial/constant/modal.dart';
import 'package:pendidikan_milenial/repository/user_repository.dart';
import 'package:pendidikan_milenial/ui/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShow = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();

  void obsecureText() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 88, 212),
      body: ListView(
        children: [
          loginForm(kWidth),
        ],
      ),
    );
  }

  Widget loginForm(double kWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kWidth / 20,
        vertical: kWidth / 2.4,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kWidth / 20,
          vertical: kWidth / 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(kWidth / 20),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tambahkan widget Image di sini
              Image.asset(
                'assets/logo.jpeg', // Ubah dengan path gambar Anda
                width: kWidth / 2, // Sesuaikan dengan lebar yang diinginkan
                height: kWidth / 2, // Sesuaikan dengan tinggi yang diinginkan
              ),
              SizedBox(
                height: kWidth / 50,
              ),
              Text(
                'Selamat datang di ',
                style: TextStyle(
                  fontSize: kWidth / 20,
                ),
              ),
              SizedBox(
                height: kWidth / 50,
              ),
              Text(
                'LearnEase',
                style: TextStyle(
                  fontSize: kWidth / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: kWidth / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: kWidth / 27,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: usernameCtl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harus diisi';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
                decoration: InputDecoration(
                  hintText: 'Masukkan username anda',
                  hintStyle: TextStyle(fontSize: kWidth / 30),
                ),
              ),
              SizedBox(
                height: kWidth / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: kWidth / 27,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: passwordCtl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harus diisi';
                  }
                  return null;
                },
                obscureText: !isShow,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
                decoration: InputDecoration(
                  hintText: 'Masukkan password anda',
                  hintStyle: TextStyle(fontSize: kWidth / 30),
                  suffixIcon: InkWell(
                    onTap: () {
                      obsecureText();
                    },
                    child:
                        Icon(isShow ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              SizedBox(
                height: kWidth / 30,
              ),
              SizedBox(
                width: kWidth,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      GlobalModal.loadingModal(kWidth, context);
                      UserRepository.login(
                        usernameCtl.text,
                        passwordCtl.text,
                        context,
                      );
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kWidth / 27,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  }));
                },
                child: Text(
                  'Daftar Akun',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kWidth / 27,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
