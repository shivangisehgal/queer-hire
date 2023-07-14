import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Container3 extends StatefulWidget {
  const Container3({Key? key}) : super(key: key);

  @override
  State<Container3> createState() => _Container3State();
}

class _Container3State extends State<Container3> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){

          if(constraints.maxWidth < 1155)
            return MobileContainer3();

          else
            return DesktopContainer3();
        }
    );
  }
}

class DesktopContainer3 extends StatefulWidget {
  const DesktopContainer3({Key? key}) : super(key: key);

  @override
  _DesktopContainer3State createState() => _DesktopContainer3State();
}

class _DesktopContainer3State extends State<DesktopContainer3> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        width: double.infinity,
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
                  fontSize: 50,
                  height: 1.1,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 650,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 500,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 1,
                      autoPlay: true,
                      viewportFraction: 0.4,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    items: [
                      TestimonialCard(
                        testimonial: 'Being a digital marketer, I\'m always on the lookout for platforms that promote inclusivity and provide equal opportunities. I came across QueerHire, and I must say, it exceeded my expectations. The job application process was incredibly user-friendly and streamlined, saving me time and effort. The scholarship application feature was a great bonus, helping individuals pursue their dreams without financial constraints. The free training programs offered valuable resources to enhance my skills.',
                        name: 'Divij Singh',
                        profession: 'Digital Marketer',
                        image: review1,
                      ),
                      TestimonialCard(
                        testimonial: 'I applaud QueerHire for its commitment to diversity and inclusion. I stumbled upon this queer job portal while searching for resources to promote equality within my organization. The platform offers a seamless job application process, scholarships, and valuable training programs',
                        name: 'Karen Adams',
                        profession: 'HR Executive',
                        image: review2,
                      ),
                      TestimonialCard(
                        testimonial: 'As a software developer, I\'m thrilled to see a job portal specifically tailored for the queer community. The user experience of this platform is top-notch. The interface is intuitive and visually appealing, making it a joy to navigate. I appreciate the emphasis on privacy and security, ensuring that personal information remains confidential',
                        name: 'Vladmir Koshir',
                        profession: 'Software Developer',
                        image: review3,
                      ),
                    ],

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Container(
                          height: 12,
                          width: 12,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: currentIndex == i ? Colors.black54 : Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                        )
                    ],
                  ),

                ],
              ),
            ),
            // SizedBox(height: 30),
          ],
        ));
  }
}

class TestimonialCard extends StatelessWidget {
  String testimonial, name, profession;
  String image;
  TestimonialCard(
      {required this.testimonial,
      required this.name,
      required this.profession,
      required this.image});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Icon(
                Icons.chat_outlined,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            Expanded(
              child: Padding(
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(image),
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


class MobileContainer3 extends StatefulWidget {


  @override
  State<MobileContainer3> createState() => _MobileContainer3State();
}

class _MobileContainer3State extends State<MobileContainer3> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 1000,
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hear From Our Customers',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 35,
              height: 1.1,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 650,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 500,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 1,
                    autoPlay: true,
                    viewportFraction: 0.65,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: [
                    TestimonialCard(
                      testimonial: 'Being a digital marketer, I\'m always on the lookout for platforms that promote inclusivity and provide equal opportunities. I came across QueerHire, and I must say, it exceeded my expectations. The job application process was incredibly user-friendly and streamlined, saving me time and effort. The scholarship application feature was a great bonus, helping individuals pursue their dreams without financial constraints. The free training programs offered valuable resources to enhance my skills.',
                      name: 'Divij Singh',
                      profession: 'Digital Marketer',
                      image: review1,
                    ),
                    TestimonialCard(
                      testimonial: 'I applaud QueerHire for its commitment to diversity and inclusion. I stumbled upon this queer job portal while searching for resources to promote equality within my organization. The platform offers a seamless job application process, scholarships, and valuable training programs',
                      name: 'Karen Adams',
                      profession: 'HR Executive',
                      image: review2,
                    ),
                    TestimonialCard(
                      testimonial: 'As a software developer, I\'m thrilled to see a job portal specifically tailored for the queer community. The user experience of this platform is top-notch. The interface is intuitive and visually appealing, making it a joy to navigate. I appreciate the emphasis on privacy and security, ensuring that personal information remains confidential',
                      name: 'Vladmir Koshir',
                      profession: 'Software Developer',
                      image: review3,
                    ),
                  ],

                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                        height: 12,
                        width: 12,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: currentIndex == i ? Colors.black54 : Colors.grey.shade200,
                            shape: BoxShape.circle,
                            ),
                      )
                  ],
                ),

              ],
            ),

          ),
        ],
      ),
    );
  }
}


