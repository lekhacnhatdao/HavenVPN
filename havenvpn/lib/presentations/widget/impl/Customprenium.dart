import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openvpn/presentations/page/billing/premium_page.dart';
import 'package:openvpn/resources/assets.gen.dart';

class Custompretimum extends StatefulWidget {
  const Custompretimum({super.key});

  @override
  State<Custompretimum> createState() => _CustompretimumState();
}

class _CustompretimumState extends State<Custompretimum> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumPage()));
      },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height:70,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10),
            ),
                 color: Colors.black,
          ),
 
      child:  Row(
        children: [
          GestureDetector(
            child: const Icon(
              Icons.star,
              size: 20,
              color: Colors.amber,
            ),
          ),
          GestureDetector(
            child: const Icon(
              Icons.star,
              size: 30,
              color: Colors.amber,
            ),
          ),
          GestureDetector(
            child: const Icon(
              Icons.star,
              size: 20,
              color: Colors.amber,
            ),
          ),
          const SizedBox(width: 10,),
          Assets.images.logo.image(),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Go Prenium',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              Text(
                'Unlock all server',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
const Spacer(),
TextButton(onPressed: () {}, child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,) )
        ],
      ),
    ));
  }
}
