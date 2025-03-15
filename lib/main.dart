import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ramzi_project/model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

void main() {
  runApp(Ramzi());
}

class Ramzi extends StatelessWidget {
  const Ramzi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'capsule',
          textTheme: TextTheme(
            headlineLarge: TextStyle(
                fontFamily: 'capsule',
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white),
            bodyMedium: TextStyle(
                fontFamily: 'dana',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            bodySmall: TextStyle(
              fontFamily: "dana",
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 203, 203, 203),
            ),
            //red and green botton color
            bodyLarge: TextStyle(
                fontFamily: 'dana',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 255, 132, 0)),
            headlineSmall: TextStyle(
                fontFamily: 'dana',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 38, 255, 3)),
          )),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa'), // Farsi
      ],
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext context) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";

    var value = await http.get(Uri.parse(url));

    developer.log(value.body, name: "main");

    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        // ignore: use_build_context_synchronously
        _showSnackBar(context, "با موفقیت به روز شد");
        developer.log(value.body,
            name: "getResponse", error: convert.jsonDecode(value.body));
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  status: jsonList[i]["status"],
                  changes: jsonList[i]["changes"],
                  price: jsonList[i]["price"]));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    getResponse(context);
    // TODO: implement initState
    super.initState();

    developer.log("InitState", name: "wlife cricle");
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    developer.log("didUpdateWidget", name: "wlife cricle");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    developer.log("didChangeDependencies", name: "wlife cricle");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    developer.log("deactivate", name: "wlife cricle");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    developer.log("dispose", name: "wlife cricle");
  }

  @override
  Widget build(BuildContext context) {
    developer.log("InitState", name: "build");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 33, 33, 33),
          title: Row(
            children: [
              Image.asset("assets/images/R.jpeg"),
              SizedBox(
                width: 9,
              ),
              Text(
                "رمزی",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/images/menu.jpeg"))),
              SizedBox(
                width: 4,
              )
            ],
          )),
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(36, 34, 36, 0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/25,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 107, 107, 107),
                  borderRadius: BorderRadius.circular(100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "نام ارز",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "قیمت",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "تغییر",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            //List
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/2,
                width: double.infinity,
                child: ListFutureBuilder(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 56, 56, 56),
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        child: TextButton.icon(
                          onPressed: () {
                            currency.clear();
                            ListFutureBuilder(context);
                          },
                          icon: Icon(
                            CupertinoIcons.refresh,
                            color: Colors.white,
                          ),
                          label: Text(
                            "به روز رسانی",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromARGB(255, 224, 90, 37)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(33, 0, 0, 0),
                        child: Text(
                          "اخرین به روزرسانی : ${getTime()}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  FutureBuilder<dynamic> ListFutureBuilder(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int position) {
                  return myItem(position, currency);
                },
                itemCount: currency.length,
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 10 == 0) {
                    return Ad();
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )
            : Center(
                child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 132, 0),
                strokeWidth: 5.0,
              ));
      },
      future: getResponse(context),
    );
  }
}

class myItem extends StatelessWidget {
  int position;
  List<Currency> currency;
  myItem(this.position, this.currency);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Container(
        height: 41,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 56, 56, 56),
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              currency[position].title!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              getFarsiNumber(currency[position].price.toString()),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              getFarsiNumber(currency[position].changes.toString()),
              style: currency[position].status == "p"
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}

class Ad extends StatelessWidget {
  const Ad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Container(
        height: 41,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 94, 0),
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "تبلیغات",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: Color.fromARGB(255, 224, 90, 37),
    closeIconColor: Colors.white,
    showCloseIcon: true,
    duration: Duration(seconds: 2),
    dismissDirection: DismissDirection.horizontal,
  ));
}

getTime() {
  // ignore: unused_local_variable
  DateTime dateTime = DateTime.now();
  return DateFormat("kk:mm").format(DateTime.now());
}

String getFarsiNumber(String number) {
  const en = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  const fa = [
    "۰",
    "۱",
    "۲",
    "۳",
    "۴",
    "۵",
    "۶",
    "۷",
    "۸",
    "۹",
  ];

  // ignore: avoid_function_literals_in_foreach_calls
  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });
  return number;
}
