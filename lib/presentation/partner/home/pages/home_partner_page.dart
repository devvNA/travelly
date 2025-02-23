import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/presentation/home/widgets/nav_item.dart';
import 'package:travelly/presentation/partner/home/pages/scanner_page.dart';
import 'package:travelly/presentation/partner/transaction/pages/transaction_partner_page.dart';
import 'package:travelly/presentation/partner/profile_partner/pages/profile_partner_page.dart';
import 'package:flutter_svg/svg.dart';

class HomePartnerPage extends StatefulWidget {
  const HomePartnerPage({super.key});

  @override
  State<HomePartnerPage> createState() => _HomePartnerPageState();
}

class _HomePartnerPageState extends State<HomePartnerPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const TransactionPartnerPage(),
    const ProfilePartnerPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: const StadiumBorder(),
        onPressed: () {
          context.push(const ScannerPage());
        },
        child: SvgPicture.asset(
          Assets.icons.scan.path,
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        color: AppColors.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icons.transactionPartner.path,
              label: 'Transaksi',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
              iconPath: Assets.icons.profilePartner.path,
              label: 'Profil',
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}
