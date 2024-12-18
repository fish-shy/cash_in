import 'package:cash_in/src/settings/payment_logo.dart';
import 'package:flutter/material.dart';
import 'package:cash_in/src/widget/pay_button_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height/ 3,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 2,
                  child: Image.asset(
                    'assets/images/placeholderPlace.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const BackButton(color: Colors.black,),
              const Positioned(
                bottom: 30,
                right: 1,
                left: 1,
                child: Column(
                  children: [
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Icon(Icons.tab),
                      ),
                    ),
                    Text("Nama Warung"),
                  ],
                ),
              ),
            ],
          ),
          Container(

            margin: const EdgeInsets.all(22),
            child: const  Text("Bentuk Pembayaran",style: TextStyle(
              fontSize: 30
            
            ),),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return index == 3? tambahPayButton( (){}): payButton(onPressed: () {},link: paymentMethods['payment'][index]);
              },
            ),
          )
        ],
      ),
    ));
  }
}
