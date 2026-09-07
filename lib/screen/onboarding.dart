import 'package:flutter/material.dart';
import 'login_page.dart';
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}
class _OnboardingState extends State<Onboarding> {
  PageController controller = PageController();
  int page = 0;
  void openPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('Assets/onboard_screen_image/onboard_logo.png', height: 45),
                      const SizedBox(width: 8),
                      const Text(
                        'Cuisine Circle',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D2013)),
                      ),
                    ],
                  ),
                  if (page < 4)
                    TextButton(
                      onPressed: openPage,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE8E3DC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Color(0xFF2D2013), fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView(controller: controller,
                onPageChanged: (number) {setState(() {
                    page = number;
                  });
                },
                children: [
                  pageStruct(
                    image: 'Assets/onboard_screen_image/onboarding_screen_image1.png',
                    title: 'Discover Delicious Recipes',
                    subtitle: "Explore tasty recipes and discover meals you'll love every day.",
                  ),
                  pageStruct(
                    image: 'Assets/onboard_screen_image/onboarding_screen_image2.png',
                    title: 'Find and Cart Ingriditents',
                    subtitle: 'Find simple recipes and turn everyday ingredients into delicious meals.',
                  ),
                  pageStruct(
                    image: 'Assets/onboard_screen_image/onboarding_screen_image3.png',
                    title: 'Cook Your Own Meals',
                    subtitle: 'Learn to cook with step-by-step instructions and tips from our community of food enthusiasts.',
                  ),
                  pageStruct(
                    image: 'Assets/onboard_screen_image/onboarding_screen_image4.png',
                    title: 'Share Your Favourites',
                    subtitle: 'Save and share your favorite recipes with the Cuisine Circle community.',
                  ),
                  pageStruct(
                    image: 'Assets/onboard_screen_image/onboarding_screen_image5.png',
                    title: 'Enjoy Your Meals And Explore..',
                    subtitle: 'Explore, cook, share and enjoy amazing food with Cuisine Circle.',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(margin: const EdgeInsets.all(4),width: page == index ? 10 : 8,
                  height: page == index ? 10 : 8,
                  decoration: BoxDecoration(color: page == index? const Color(0xFF2D2013): Colors.grey,
                    shape: BoxShape.circle,),
                );
              }),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (page > 0)
                    ElevatedButton(
                      onPressed: () {
                        controller.previousPage(duration: const Duration(milliseconds: 300),curve: Curves.easeIn,);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE8E3DC),foregroundColor: const Color(0xFF2D2013),elevation: 0,
                     shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('← Back'),
                    )
                  else
                    const SizedBox(width: 80),
                  if (page < 4)
                    ElevatedButton(
                      onPressed: () {
                        controller.nextPage( duration: const Duration(milliseconds: 300),curve: Curves.easeIn,);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2D2013),foregroundColor: Colors.white,elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Forward →'),
                    ),
                  if (page == 4)
                    ElevatedButton(
                      onPressed: openPage,style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D2013),foregroundColor: Colors.white,elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Get Started →'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget pageStruct({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(image, fit: BoxFit.contain)),
          const SizedBox(height: 10),
          Text(title,textAlign: TextAlign.center,style: const TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color: Color(0xFF2D2013),),),
          const SizedBox(height: 14),
          Text(subtitle, textAlign: TextAlign.center,style: const TextStyle(fontSize: 19, color: Colors.grey),),
        ],
      ),
    );
  }
}
