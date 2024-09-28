import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../data/datasources/services/user_service.dart';
import '../../data/datasources/user_firebase.dart';
import '../../data/models/user.dart';
import '../../utils/constants/image_strings.dart';
import '../shared_widgets/balance_container.dart';
import '../shared_widgets/home_appbar.dart';
import 'widgets/bottom_nav_container.dart';
import 'widgets/global_timer.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<MyUser?>? _futureUser;
  List<String> bannerImages = [];
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    fetchBannerImages();
    _refreshData();
  }

  Future<void> fetchBannerImages() async {
    bannerImages = await fetchAllAdsImages("banner_images");
    setState(() {});
  }

  Future<void> _refreshData() async {
    setState(() {
      checkCountersAvailability();
      _futureUser = _userService.fetchAndStoreUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Text('ثروتي', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<MyUser?>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            }

            final user = snapshot.data;

            if (user == null) {
              return const Center(child: Text('بيانات المستخدم غير متاحة'));
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: BalanceContainer(
                          image: MyImages.diamondIcon,
                          diamonds: user.diamondsNumber.toString(),
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 5,
                        child: BalanceContainer(
                          image: MyImages.dollarIcon,
                          dollars: user.dollarsNumber.toStringAsFixed(5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Slider
                  PromoSlider(banners: bannerImages),
                  const SizedBox(height: 25),

                  const GlobalTimer(),
                  const SizedBox(height: 15),
                  // Add Ads here
                  //const BannerAds(),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavContainer(),
    );
  }

  Future<List<String>> fetchAllAdsImages(String folderPath) async {
    List<String> imageUrls = [];

    try {
      final ListResult result = await FirebaseStorage.instance.ref(folderPath).listAll();
      for (Reference ref in result.items) {
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    } catch (e) {
      debugPrint('Error fetching images: $e');
    }
    return imageUrls;
  }
}


