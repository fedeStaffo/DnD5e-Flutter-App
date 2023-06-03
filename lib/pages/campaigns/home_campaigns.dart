import 'package:flutter/material.dart';

import 'campaign_list_screen.dart';
import 'create_campaigns_screen.dart';
import 'join_campaign_screen.dart';

class HomeCampaigns extends StatefulWidget {
  @override
  _HomeCampaignsState createState() => _HomeCampaignsState();
}

class _HomeCampaignsState extends State<HomeCampaigns> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CampaignListScreen(),
    CreateCampaignScreen(),
    JoinCampaignScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Campagne',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Crea',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Unisciti',
          ),
        ],
      ),
    );
  }
}
