import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/presentation/explore/blocs/event/event_bloc.dart';
import 'package:travelly/presentation/explore/blocs/event_category/event_category_bloc.dart';
import 'package:travelly/presentation/explore/widgets/content_event.dart';
import 'package:travelly/presentation/explore/widgets/custom_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String query = "All";
  @override
  void initState() {
    super.initState();
    context
        .read<EventCategoryBloc>()
        .add(const EventCategoryEvent.getEventCategories());
    context.read<EventBloc>().add(const EventEvent.getEvents());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarBrightness: Brightness.dark,
    ));
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      Assets.images.banner1.path,
                      width: context.deviceWidth,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: context.deviceHeight * 0.22,
                      left: 16.0,
                      right: 16.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 0),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 10.0,
                              color: Colors.black.withAlpha(25),
                            ),
                          ],
                        ),
                        height: 44,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length > 3) {
                              context
                                  .read<EventBloc>()
                                  .add(EventEvent.searchEvent(value));
                            }
                            if (value.isEmpty) {
                              context
                                  .read<EventBloc>()
                                  .add(const EventEvent.fetchAllFromState());
                            }
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              // color: Color(0xff9CA3AF),
                              color: AppColors.textBlack2,
                            ),
                            hintText: "Tiket Wisata",
                            hintStyle: TextStyle(
                              fontSize: 12.0,
                              // color: Color(0xffD1D5DB),
                              color: AppColors.textBlack2,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: Column(
            children: [
              BlocBuilder<EventCategoryBloc, EventCategoryState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return const LoadingIndicator();
                    },
                    success: (data) {
                      return Container(
                        color: AppColors.white,
                        child: Builder(
                          builder: (context) {
                            final TabController controller =
                                DefaultTabController.of(context);
                            controller.addListener(() {
                              if (controller.index == 0) {
                                query = "All";
                              } else {
                                final selectedCategory =
                                    data.data![controller.index - 1];
                                query = selectedCategory.name!;
                              }
                              log("Selected Query: $query");

                              context
                                  .read<EventBloc>()
                                  .add(EventEvent.getEventsByCategory(query));
                              setState(() {});
                            });

                            return AnimatedBuilder(
                              animation: controller,
                              builder: (context, _) {
                                return TabBar(
                                    indicatorColor: AppColors.primary,
                                    labelColor: AppColors.primary,
                                    unselectedLabelColor: AppColors.disable,
                                    tabs: [
                                      CustomTab(
                                        iconPath: Assets.icons.all.path,
                                        isSelected: controller.index == 0,
                                        label: "Semua",
                                      ),
                                      ...data.data!.map((e) {
                                        String iconPath =
                                            Assets.icons.culture.path;
                                        query = e.name!;
                                        if (e.name == 'Pantai') {
                                          iconPath = Assets.icons.beach.path;
                                        } else if (e.name == 'Gunung') {
                                          iconPath = Assets.icons.mountain.path;
                                        } else if (e.name == 'Permainan') {
                                          iconPath = Assets.icons.games.path;
                                        } else {
                                          iconPath = Assets.icons.culture.path;
                                        }
                                        return CustomTab(
                                          iconPath: iconPath,
                                          label: e.name!,
                                          isSelected: controller.index == e.id,
                                        );
                                      })
                                    ]);
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ContentEvent(),
                    ContentEvent(),
                    ContentEvent(),
                    ContentEvent(),
                    ContentEvent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
