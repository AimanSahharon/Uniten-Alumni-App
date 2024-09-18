import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> posterImages = [
    'lib/assets/posters/alumni-waqf-fund.png',
    'lib/assets/posters/keistimewaan-berwakaf.png',
    'lib/assets/posters/rak-al-quran.jpg',
    'lib/assets/posters/spg.jpg',
    'lib/assets/posters/wakaf-alquran.png',
  ];

  final List<String> posterLinks = [
    'https://www.uniten.edu.my/scholarship-plus-aid/yayasan-canselor-uniten-ycu/contribute-to-ycu/',
    'https://www.amanahuniten.my/index.php',
    'https://www.uniten.edu.my/about-uniten/centres/uniten-islamic-centre-uic/wakaf/',
  ];

  final List<String> adImages = [
    'lib/assets/ads/ad1.jpg',
    'lib/assets/ads/ad2.jpg',
    'lib/assets/ads/ad3.jpg',
  ];

  // Launch URL function
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 128, 0, 255),
            ],
          ),
        ),
        child: SingleChildScrollView( // Allows for scrolling when content exceeds the screen height
          child: Column(
            children: [
              _buildCareerPortalCard(),
              const Divider(color: Colors.white, thickness: 1), // Horizontal line between cards
              _buildDonationCard(),
              const Divider(color: Colors.white, thickness: 1), // Horizontal line between cards
              _buildIRCCard(),
              const Divider(color: Colors.white, thickness: 1), // Horizontal line between cards
              _buildAdvertisementCard(),
              const Divider(color: Colors.white, thickness: 1), // Horizontal line between cards
              _buildSocialMediaCard(),
              const Divider(color: Colors.white, thickness: 1), // Horizontal line between cards
              _buildInfoCard(),
              const Divider(color: Colors.white, thickness: 1), // Horizontal line between cards
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareerPortalCard() {
    return Center(
      child: Container(
        width: double.infinity, // Match the width to the first card
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'UNITEN Career Portal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () => _launchURL('http://careers.uniten.edu.my/unicap/'),
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/logo/career_portal.png',
                    width: 300,
                    height: 100,
                  ),
                  const SizedBox(height: 8),
                  const Text('UNITEN Career Portal'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationCard() {
    return Center(
      child: Container(
        width: double.infinity, // Set to full width
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                'Donation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogoButton('YCU', 'lib/assets/logo/ycu.jpg', 'https://www.uniten.edu.my/scholarship-plus-aid/yayasan-canselor-uniten-ycu/contribute-to-ycu/'),
                  const SizedBox(width: 8),
                  _buildLogoButton('TAZU', 'lib/assets/logo/tazu.jpg', 'https://www.amanahuniten.my/index.php'),                
                  const SizedBox(width: 30),
                  //_buildLogoButton('WAKAF', 'lib/assets/logo/donation.png', 'https://www.uniten.edu.my/about-uniten/centres/uniten-islamic-centre-uic/wakaf/'),
                   InkWell(
                  onTap: () => _launchURL('https://www.uniten.edu.my/about-uniten/centres/uniten-islamic-centre-uic/wakaf/'),
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/logo/donation.png',
                        width: 50,
                        height: 100,
                      ),
                      const SizedBox(height: 8),
                      const Text('WAKAF'),
                    ],
                  ),
                ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: posterImages.length,
                itemBuilder: (BuildContext context, int index, int realIdx) {
                  return GestureDetector(
                    onTap: () => _launchURL(posterLinks[index]),
                    child: Image.asset(
                      posterImages[index],
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIRCCard() {
    return Center(
      child: Container(
        width: double.infinity, // Match the width to the first card
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'IRC',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () => _launchURL('https://lib.uniten.edu.my/ulib/'),
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/logo/irc.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 8),
                  const Text('IRC'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvertisementCard() {
    return Center(
      child: Container(
        width: double.infinity, // Match the width to the previous cards
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Advertisements',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            CarouselSlider.builder(
              itemCount: adImages.length,
              itemBuilder: (BuildContext context, int index, int realIdx) {
                return Image.asset(
                  adImages[index],
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                );
              },
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard() {
    return Center(
      child: Container(
        width: double.infinity, // Match the width to the previous cards
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Follow Us on Social Media',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogoButton('Instagram', 'lib/assets/logo/instagram.png', 'https://www.instagram.com/uniten.alumni?igsh=ajg3bjg1cnU1cXA2'),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _launchURL('https://www.facebook.com/UNITEN.ALUMNI'),
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/logo/facebook.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 8),
                      const Text('Facebook'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Center(
      child: Container(
        width: double.infinity, // Match the width to the previous cards
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the Column's content vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Centers the Column's content horizontally
          children: <Widget>[
            Text(
              'Alumni Relations, Career and Industry Linkage Department.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Centers text within the Text widget
            ),
            SizedBox(height: 8.0), // Adds space between the texts
            Text(
              'University Tenaga Nasional (UNITEN)',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Centers text within the Text widget
            ),
            SizedBox(height: 8.0), // Adds space between the texts
            Text(
              '| Putrajaya Campus |',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Centers text within the Text widget
            ),
            SizedBox(height: 8.0), // Adds space between the texts
            Text(
              'Level 2, Administration Building, Jalan IKRAM-UNITEN, 43000 Kajang, Selangor, Malaysia',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Centers text within the Text widget
            ),
            SizedBox(height: 8.0), // Adds space between the texts
            Text(
              'Tel: +603–89212020 (ext. 7549)',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Centers text within the Text widget
            ),
            SizedBox(height: 8.0), // Adds space between the texts
            Text(
              'Email : mshaufi@uniten.edu.my',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Centers text within the Text widget
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoButton(String title, String imagePath, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}
