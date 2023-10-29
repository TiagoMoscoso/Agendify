import 'package:flutter/material.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'config.dart';
import 'navBar.dart';

Future<void> main() async {
  ClassUser User = await DbTableUser.GetLastUser();
  runApp(MaterialApp(
    home: Profile(User: User),
  ));
}


class Profile extends StatelessWidget {
  final ClassUser User;
  const Profile({super.key, required this.User});

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
        home: ProfileStateful(User: User),
    );
  }
}
class ProfileStateful extends StatefulWidget {
  final ClassUser User;
  const ProfileStateful({super.key, required this.User});

  @override
  State<ProfileStateful> createState() => _ProfileStatefulState(User : User);
}

class _ProfileStatefulState extends State<ProfileStateful> {
  final ClassUser User;
  _ProfileStatefulState({required this.User});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil",
          style: TextStyle(
            fontSize: 20.0,
            color: Color(0xff252B48),
          ),
        ),
        centerTitle: true,
        backgroundColor:const Color(0xff9EDDFF),
      ),
      body: Column(
        children: [
          //NOME E FOTO DE PERFIL
          Row(
            children: [
              Image.asset("imagens/fotoperfil2.png", width: 150, height: 100),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Text(
                    User.getName(),
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "Kanit"),
                  )
              )
            ],
          ),
          //NÚMERO de CELULAR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffEBE4D1),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(
                            Icons.call
                        ),
                        Text(User.getTelephone(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Kanit"))
                      ],
                    ),
                  )
              ),

            ],
          ),
          //EMAIL
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffEBE4D1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                        Icons.mail
                    ),
                    Text(User.getEmail(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Kanit"))
                  ],
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
                        Icons.calendar_month
                    ),
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
                        Icons.settings
                    ),
                    ButtonConfig()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xffFAF1E4),
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
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff2E8B57)),
          ),
          onPressed: (){

          },//VAI PARA A TELA DA AGENDA
          child: const Text("Agenda", style: TextStyle(fontSize: 20, fontFamily: "Kanit")),
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
                const Color(0xff000000)),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xffc1c0c0)),
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


class AppBarTest extends StatefulWidget {
  const AppBarTest({super.key});
  @override
  State<AppBarTest> createState() => _AppBarTestState();
}

class _AppBarTestState extends State<AppBarTest>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavigationBarExample(),
    );
  }
}







