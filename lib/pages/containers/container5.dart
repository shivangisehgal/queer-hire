import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/styles.dart';
import '/utils/constants.dart';

class Container5 extends StatefulWidget {
  bool inGuidancePage = false;
  Container5(this.inGuidancePage);
  @override
  _Container5State createState() => _Container5State();
}

class _Container5State extends State<Container5> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      //padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: h! * 0.2),
      //height: 700,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Reach Out to Us',
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: w! / 30,
                height: 1.1,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Text(
            'Do you need assistance with any queries regarding available opportunities or guidance for your career? \nDo you require a consultant to discuss your concerns and share your thoughts? \n\nWe are here to provide you with the support and assistance you need at all times.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HindSiliguri',
              color: widget.inGuidancePage == false ? Colors.grey.shade400 : Colors.grey[700],
              fontSize: 18,
            ),
          ),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get in touch',
                      style: TextStyle(
                        fontFamily: 'HindSiliguri',
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Send in your details, and we\'ll get back to you!',
                      style: TextStyle(
                        fontFamily: 'HindSiliguri',
                        color: widget.inGuidancePage == false ? Colors.grey.shade400 : Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                  child: ContactForm()),
            ],
          )
        ],
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.primary.withOpacity(0.15),
      ),
      //width: w! / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: CustomFormField(hint: 'Name'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: CustomFormField(hint: 'E-mail Address'),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: CustomFormField(hint: 'Contact No.'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: CustomFormField(hint: 'Subject'),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: 100
              ),
              child: SingleChildScrollView(
                //scrollDirection: Axis.horizontal,
                reverse: true,
                  child: CustomFormField(hint: 'Write your message...'),
              ),
            ),
          ),
          ElevatedButton(
            style: AppButtonStyle,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'SEND MESSAGE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormField extends StatefulWidget {
  CustomFormField({required this.hint});
  String hint;
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hint,
        contentPadding: const EdgeInsets.only(
            left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }
}
