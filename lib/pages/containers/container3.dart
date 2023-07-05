import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';

class Cointainer3 extends StatefulWidget {
  const Cointainer3({Key? key}) : super(key: key);

  @override
  _Cointainer3State createState() => _Cointainer3State();
}

class _Cointainer3State extends State<Cointainer3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        //width: double.infinity,
        //height: 700,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 80),
        //margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 50),
            Text(
              'Hear From Our Customers',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: w! / 30,
                  height: 1.1,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50),
            Row(
              //crossAxisAlignment: WrapCrossAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TestimonialCard(
                    testimonial:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget. Mauris pulvinar malesuada ullamcorper. Morbi volutpat tincidunt lectus et tempor. Curabitur fermentum massa non urna posuere, non hendrerit ipsum tempus. Proin consequat consectetur lacus. Curabitur viverra sollicitudin vulputate. Nullam nec hendrerit tortor, eget pulvinar erat. Donec eget placerat enim. Sed tincidunt, diam id lacinia placerat, urna libero ultricies ante, non pretium elit diam non ex.',
                    name: 'Divij Singh',
                    profession: 'Digital Marketer'),
                TestimonialCard(
                    testimonial:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget. Mauris pulvinar malesuada ullamcorper. Morbi volutpat tincidunt lectus et tempor. Curabitur fermentum massa non urna posuere, non hendrerit ipsum tempus. Proin consequat consectetur lacus. Curabitur viverra sollicitudin vulputate. Nullam nec hendrerit tortor, eget pulvinar erat. Donec eget placerat enim. Sed tincidunt, diam id lacinia placerat, urna libero ultricies ante, non pretium elit diam non ex.',
                    name: 'Karen Adams',
                    profession: 'HR Executive'),
                TestimonialCard(
                    testimonial:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas facilisis pretium mauris, in ornare est tristique eget. Mauris pulvinar malesuada ullamcorper. Morbi volutpat tincidunt lectus et tempor. Curabitur fermentum massa non urna posuere, non hendrerit ipsum tempus. Proin consequat consectetur lacus. Curabitur viverra sollicitudin vulputate. Nullam nec hendrerit tortor, eget pulvinar erat. Donec eget placerat enim. Sed tincidunt, diam id lacinia placerat, urna libero ultricies ante, non pretium elit diam non ex.',
                    name: 'Vladmir Koshir',
                    profession: 'Software Developer'),
              ],
            ),
            // SizedBox(height: 30),
          ],
        ));
  }
}

class TestimonialCard extends StatelessWidget {
  String testimonial, name, profession;
  String? image;
  TestimonialCard(
      {required this.testimonial,
      required this.name,
      required this.profession});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 350,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Icon(
                Icons.chat_outlined,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                testimonial,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                ),
                title: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  profession,
                  style: TextStyle(fontSize: 14, color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
