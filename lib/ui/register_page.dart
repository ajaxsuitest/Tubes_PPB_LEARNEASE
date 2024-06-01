import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pendidikan_milenial/constant/modal.dart';
import 'package:pendidikan_milenial/model/user.dart';
import 'package:pendidikan_milenial/repository/user_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isShow = false;
  TextEditingController namaCtl = TextEditingController();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String selectedTingkatSekolah = '';

  void obsecureText() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 16, 234, 1),
      body: ListView(
        children: [
          SizedBox(
            height: kWidth / 50,
          ),
          registerForm(kWidth),
        ],
      ),
    );
  }

  Widget registerForm(double kWidth) {
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
                height: kWidth / 15,
              ),
              Text(
                'Daftar Akun',
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
                    'Nama',
                    style: TextStyle(
                      fontSize: kWidth / 27,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: namaCtl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harus diisi';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\s]+')),
                ],
                decoration: InputDecoration(
                  hintText: 'Masukkan nama anda',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tingkat Sekolah',
                    style: TextStyle(
                      fontSize: kWidth / 27,
                    ),
                  ),
                ],
              ),
              DropdownButtonFormField(
                  hint: Text(
                    'Pilih tingkat sekolah anda',
                    style: TextStyle(
                      fontSize: kWidth / 30,
                    ),
                  ),
                  items: ['SD', 'SMP', 'SMA']
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedTingkatSekolah = val!;
                    });
                  }),
              SizedBox(
                height: kWidth / 30,
              ),
              SizedBox(
                width: kWidth,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      GlobalModal.loadingModal(kWidth, context);
                      UserRepository.register(
                          User(
                            username: usernameCtl.text,
                            password: passwordCtl.text,
                            nama: namaCtl.text,
                            tingkatSekolah: selectedTingkatSekolah,
                          ),
                          context);
                    }
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kWidth / 27,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kWidth / 27,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
