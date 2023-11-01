import 'package:flutter/material.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'config.dart';
import 'navBar.dart';
import 'package:testeflutter/Classes/ClassUser.dart';


Future<void> main() async {
  ClassUser user = await DbTableUser.GetLastUser();
  runApp(Profile(user: user));
}

class Profile extends StatelessWidget {
  final ClassUser user;
  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Perfil",
      routes:  {
        "/config": (context)=>
        const ConfigScreen(),
        /*"/agenda": (context) =>    descomentar quando tiver a tela de agenda
              const Agenda(),*/
      },
      home: ProfileStateful(user: user),
    );
  }
}
class ProfileStateful extends StatefulWidget {
  final ClassUser user;
  const ProfileStateful({super.key, required this.user});

  @override
  State<ProfileStateful> createState() => _ProfileStatefulState(user: user);
}

class _ProfileStatefulState extends State<ProfileStateful> {
  final ClassUser user;
  _ProfileStatefulState({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarExample(),
      backgroundColor: Color(0xffFAF1E4),
    );
  }
}

// Future<void> main() async {
//   ClassUser user = await DbTableUser.GetLastUser();
//   runApp(ProfileOriginal(user: user));
// }

class ProfileOriginal extends StatefulWidget {
  final ClassUser user;

  const ProfileOriginal({
    super.key,
    required this.user,
  });

  @override
  State<ProfileOriginal> createState() => _ProfileOriginal(user: user);
}

class _ProfileOriginal extends State<ProfileOriginal> {
  final ClassUser user;
  _ProfileOriginal({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D0C7),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                children: <Widget>[
                  Text(
                    "Perfil",
                    style: TextStyle(
                      color: Color(0xFF7E72A6),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.person_rounded, color: Color(0xFF7E72A6), size: 36)
                ],
              ),
              const SizedBox(height: 20.0),
              //NOME E FOTO DE PERFIL
              Row(
                children: [
                  Image.asset("imagens/fotoperfil2.png", width: 150, height: 100),
                  Text(
                    user.getName(),
                    style: const TextStyle(
                        color: Color(0xFF7E72A6),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              //NÚMERO de CELULAR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                              Icons.call_rounded,
                              color: Color(0xFF7E72A6),
                              size: 24,
                          ),
                          Text(
                            user.getTelephone(),
                            style: const TextStyle(
                              color: Color(0xFF7E72A6),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              
                ],
              ),
              const SizedBox(height: 10.0),
              //EMAIL
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                              Icons.mail_rounded,
                              color: Color(0xFF7E72A6),
                              size: 24,
                          ),
                          Text(
                            user.getEmail(), 
                            style: const TextStyle(   
                              color: Color(0xFF7E72A6),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              //AGENDA
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                            Icons.calendar_month,
                            color: Color(0xFF7E72A6),
                            size: 20,
                        ),
                        SizedBox(width: 5),
                        ButtonSchedule(),
                      ],
                    ),
                  )
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                            Icons.mail_rounded,
                            color: Color(0xFF7E72A6),
                            size: 20,
                        ),
                        SizedBox(width: 5),
                        ButtonConfig()
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.logout_outlined, color: Colors.red, size: 30),
                  SizedBox(width: 5),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonSchedule extends StatefulWidget {
  const ButtonSchedule({super.key});
  @override
  State<ButtonSchedule> createState() => _ButtonScheduleState();
}

class _ButtonScheduleState extends State<ButtonSchedule> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 250,
        child:TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffFFFFFF)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7E72A6)),
          ),
          onPressed: (){
            //VAI PARA A TELA DA AGENDA
          },
          child: const Text(
            "Agenda",
            style: TextStyle(fontSize: 20)
          ),
        )
    );
  }
}


class ButtonConfig extends StatefulWidget {
  const ButtonConfig({super.key});
  @override
  State<ButtonConfig> createState() => _ButtonConfigState();
}

class _ButtonConfigState extends State<ButtonConfig> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 250,
        child: ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFFFFFFFF)),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF7E72A6)),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/config");
          }, //VAI PARA A TELA DE CONFIGURAÇÕES
          child: const Text("Configurações",
              style: TextStyle(fontSize: 20, fontFamily: "Kanit")),
        )
    );
  }
}







