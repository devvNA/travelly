import 'package:flutter/material.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/presentation/partner/sku/blocs/get_skus/get_skus_bloc.dart';
import 'package:travelly/presentation/partner/sku/pages/add_sku_page.dart';
import 'package:travelly/presentation/partner/sku/widgets/card_sku_partner.dart';
import 'package:travelly/presentation/partner/sku/widgets/empty_sku_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkuPartnerPage extends StatefulWidget {
  const SkuPartnerPage({super.key});

  @override
  State<SkuPartnerPage> createState() => _SkuPartnerPageState();
}

class _SkuPartnerPageState extends State<SkuPartnerPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetSkusBloc>().add(const GetSkusEvent.getSkus());
  }

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
          "Kelola Tiket",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              context.push(const AddSkuPage());
            },
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SpaceWidth(16)
        ],
      ),
      body: BlocBuilder<GetSkusBloc, GetSkusState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const SizedBox.shrink();
          }, loading: () {
            return const LoadingIndicator();
          }, success: (data) {
            if (data.data!.isEmpty) {
              return const EmptySkuWidget();
            }

            return ListView.separated(
              itemCount: data.data!.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SpaceHeight(2);
              },
              itemBuilder: (BuildContext context, int index) {
                return CardSkuPartner(
                  model: data.data![index],
                );
              },
            );
          });
        },
      ),
    );
  }
}
