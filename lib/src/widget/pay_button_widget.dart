
import 'package:flutter/material.dart';

Widget payButton({required VoidCallback onPressed, required Map<String, dynamic>  link}) {
  return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), 
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF412889),
                  Color(0xFFFFC1F5),
                ],
                stops: [0.0, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Row(
                  children: [
                     SizedBox(
                      width: 55,
                      height: 55,
                      
                      child: Center(
                        child: Image(image: NetworkImage(link['iconUrl'])),
                      ),
                    ),
                    const SizedBox(width: 15),
                     Text(link['name'], style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),),
                        
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("RP 25.000.00", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              margin: const EdgeInsets.all(10),
                              child: const Icon(Icons.remove_red_eye_outlined,color: Colors.white,)),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ));
}

Widget tambahPayButton(VoidCallback onPressed)
{

      return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Circular border radius
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color:  Color(0xFF412889),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 60,
                          
                          child: Center(
                            child: Icon(Icons.add,color: Colors.white, size: 40,) ),
                        ),
                          ]),
                ),
              ),
            ),
            const SizedBox(width: 20,),
            const Text('Tambah e-Wallet',style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF412889),
              fontSize: 16
            ),),
            
            const SizedBox(width: 80,),
            const Icon(Icons.payment),
            const SizedBox(width:10,),
            const Icon(Icons.payment)
          ],
        ),
      ));

}
