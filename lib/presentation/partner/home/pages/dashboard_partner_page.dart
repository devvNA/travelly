import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/presentation/partner/event/pages/event_managemnet_page.dart';
import 'package:travelly/presentation/partner/sku/pages/sku_partner_page.dart';
import 'package:travelly/presentation/profile/pages/status_account_page.dart';

class DashboardPartnerPage extends StatelessWidget {
  const DashboardPartnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Ticket Status",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
                child: _item(context, Assets.icons.eventManagement.path,
                    "Event Management", () {
              context.push(const EventManagemnetPage());
            })),
            const SpaceWidth(16),
            Expanded(
                child: _item(context, Assets.icons.ticketExpired.path,
                    "Ticket Management", () {
              context.push(const SkuPartnerPage());
            })),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String icon,
    String title,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 154,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff00000005),
              blurRadius: 5.5,
              offset: Offset(0, 3.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.cover,
            ),
            const SpaceHeight(10),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
