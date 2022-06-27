import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_ui/google_ui.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GSearchAppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        keyboardType: TextInputType.number,
        hintText: "Search something here...",
        elevation: 10.0,
        title: 'Leky Transfer',
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: GElevatedButton(
                    'Envoyer',
                    icon: const Icon(Icons.star_border_outlined),
                    onPressed: sendSMS,
                    color: Colors.cyan,
                  )),
              SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: GOutlinedButton(
                    'Outlined Button',
                    icon: const Icon(Icons.star_border_outlined),
                    onPressed: () {},
                  )),
              SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: GTextButton(
                    'Text Button',
                    icon: const Icon(Icons.star_border_outlined),
                    onPressed: () {},
                  )),
              SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: GOutlinedButton(
                    'Outlined Button',
                    icon: const Icon(Icons.star_border),
                    color: Colors.green,
                    onPressed: () {},
                  )),
              GTextFormField(
                labelText: "Username",
                hintText: "Login",
                prefixIcon: Icon(Icons.person),
              ),
              GTextFormField(
                labelText: "Password",
                passwordField: true,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(Icons.password_outlined),
              ),
              GTextFormField(
                labelText: "Date",
                keyboardType: TextInputType.datetime,
                prefixIcon: Icon(Icons.date_range_outlined),
              )

            ],
          ),
        ),
      ),
    );
  }

  sendSMS() async {
    var baseUrl =
    Uri.parse('https://pw1dem.api.infobip.com/sms/2/text/advanced');
    var apiKey =
        '3403ab869e6ba9ab85e16f3f2c16c347-e0f85569-609d-4733-ab4f-c63704e8b24e';

    var name = "Mamadou Yayha Diallo";
    var amount = "1 000 000";
    var currency = "FCFA";
    var code = "2007-2014";
    var num = "+224622476674";

    try {
      var response = await http.post(baseUrl, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader:
        'App $apiKey'
      }, body: jsonEncode({
        "messages": [
          {
            "from": "L Transfer",
            "destinations": [
              {
                "to": "221782932895",
              }
            ],
            "text": "Bienvenu(e) chez Leky Transfer: $name vient de vous envoyé "
                "$amount $currency. \nCode: $code. \nNuméro: $num. Merci !"
          }
        ]
      }));
      var jsonMessage = jsonDecode(response.body);
      print('Debut');
      print(jsonMessage);
      print('Fin');
      print("Status code: "+ response.statusCode.toString());
    } catch (error) {
      print('Error message at : $error');
    }
  }
}
