import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).top + 40),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Icon(
                CupertinoIcons.person_alt_circle_fill,
                size: 180,
                color: Color(0xff343c60),
              ),
              SizedBox(height: 20),
              Text(
                'Sidiq',
                style: const TextStyle(
                  color: Color(0xffE5E7EB),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'ID: 202406172025',
                  style: const TextStyle(
                    color: Color(0xff9CA3AF),
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                'Enginer',
                style: const TextStyle(color: Color(0xff9CA3AF), fontSize: 16),
              ),

              menuWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget menuWidget() {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(142, 52, 60, 96),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Logout',
            style: const TextStyle(
              color: Color(0xffE5E7EB),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            CupertinoIcons.forward,
            color: Color.fromARGB(63, 229, 231, 235),
          ),
        ],
      ),
    );
  }
}
