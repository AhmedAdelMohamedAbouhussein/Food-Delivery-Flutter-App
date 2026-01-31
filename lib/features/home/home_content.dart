import 'package:final_proj/core/models/restaurant_model.dart';
import 'package:final_proj/features/home/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/resources/app_colors.dart';
import 'homeLogic/home_cubit.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        } else if (state is HomeError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        } else if (state is HomeLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().fetchHomeData(),
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  _topBar(),
                  const SizedBox(height: 16),
                  _searchBar(),
                  const SizedBox(height: 18),
                  _categories(),
                  const SizedBox(height: 24),
                  _sectionTitle("Fastest"),
                  const SizedBox(height: 12),
                  _buildDynamicList(context, state.fastest),
                  const SizedBox(height: 28),
                  _sectionTitle("Recommended for You"),
                  const SizedBox(height: 12),
                  _buildDynamicList(context, state.recommended),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildDynamicList(BuildContext context, List<RestaurantModel> list) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return FoodCard(
            image: item.image,
            title: item.title,
            rating: item.rating,
            reviews: item.reviews,
            distance: item.distance,
            time: item.time,
            onTap: () => _openDetailPage(context, item),
          );
        },
      ),
    );
  }

  void _openDetailPage(BuildContext context, RestaurantModel restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RestaurantDetailPage(restaurant: restaurant),
      ),
    );
  }

  // --- Static UI Components ---
  Widget _topBar() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Color(0xFF22C55E)),
        const SizedBox(width: 6),
        const Text("Wherever You Want",
            style: TextStyle(color: AppColors.whiteColor, fontSize: 16, fontWeight: FontWeight.w600)),
        const Spacer(),
        IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(color: AppColors.iconBackground, borderRadius: BorderRadius.circular(24)),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Food, groceries, etc.",
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _categories() {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryItem(icon: Icons.verified, title: "Acclaimed", active: true),
          CategoryItem(icon: Icons.local_florist, title: "Healthy"),
          CategoryItem(icon: Icons.local_pizza, title: "Pizza"),
          CategoryItem(icon: Icons.ramen_dining, title: "Ramen"),
          CategoryItem(icon: Icons.lunch_dining, title: "Burger"),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.whiteColor));
  }
}

// ───────────────────────── CATEGORY ITEM ─────────────────────────
class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;
  const CategoryItem({super.key, required this.icon, required this.title, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: active ? AppColors.greenIcon : AppColors.iconBackground, shape: BoxShape.circle),
            child: Icon(icon, color: active ? Colors.white : Colors.green),
          ),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, color: active ? AppColors.greenIcon : AppColors.whiteColor)),
        ],
      ),
    );
  }
}

// ───────────────────────── FOOD CARD ─────────────────────────
class FoodCard extends StatelessWidget {
  final String image;
  final String title;
  final String rating;
  final String reviews;
  final String distance;
  final String time;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.image, required this.title, required this.rating, required this.reviews, required this.distance, required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: SizedBox(
          width: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(image, height: 140, width: 260, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.whiteColor)),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text("$rating ($reviews)", style: const TextStyle(fontSize: 12, color: AppColors.whiteColor)),
                  const SizedBox(width: 8),
                  Text("• $distance • $time", style: const TextStyle(fontSize: 12, color: AppColors.whiteColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}