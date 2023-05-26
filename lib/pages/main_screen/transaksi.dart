import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transsave/themes/fonts.dart';
import 'package:transsave/widgets/CustomAppBar.dart';
import 'package:transsave/widgets/home/AppHistoryTransactionItem.dart';
import 'package:transsave/widgets/home/AppTransactionItem.dart';

import '../../constants/api.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  Map<String, dynamic>? transaksiResponse;

  @override
  void initState() {
    getTransaksi();
    super.initState();
  }

  Future<void> getTransaksi() async {
    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsInVzZXJuYW1lIjoiam9rb3dpIiwiaWF0IjoxNjg1MDM3NzQyLCJleHAiOjE2ODUwOTE3NDJ9.sGuF4ONrlKycR4G9LfvBh5LuPe0b1MeBby6Q4ZU8DPY";
    const String url = APIService.base + APIService.transactions;

    final response = await http.get(
      Uri.parse(url),
      headers: {"X-Auth": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> result = json.decode(response.body);
      setState(() {
        transaksiResponse = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leading: null,
        title: 'Transaksi',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Transaksi Berlangsung',
              style: headingStyle,
            ),
            TextButton(onPressed: getTransaksi, child: Text("Get")),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      4,
                      (index) => Row(
                            children: [
                              AppTransactionItem(),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          )),
                )),
            SizedBox(
              height: 25,
            ),
            Text(
              'Riwayat Transaksi',
              style: headingStyle,
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                    4,
                    (index) => Column(
                          children: [
                            AppHistoryTransactionItem(),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        )),
              ),
            )
          ]),
        ),
      )),
    );
  }
}
