import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart' show S;

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController controller = PageController();
  int currentIndex = 0;
  List<Map<String, String>> pages = [
    {
      "titleKey": "onboardingTitle1",
      "descriptionKey": "onboardingDescription1",
      "image": "assets/images/screen1.png",

      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTty_StL4s-czvLRnvjs-f4qazAS57qhtHf8oxwcva5waEL2jUko6RgNA_4LefXT_EvM9LMejqdeNJYGLCEXnTQhE0&s&ec=121532766",
    },

    {
      "titleKey": "onboardingTitle2",
      "descriptionKey": "onboardingDescription2",
      "image": "assets/images/screen2.png",
      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTty_StL4s-czvLRnvjs-f4qazAS57qhtHf8oxwcva5waEL2jUko6RgNA_4LefXT_EvM9LMejqdeNJYGLCEXnTQhE0&s&ec=121532766",
    },

    {
      "titleKey": "onboardingTitle3",
      "descriptionKey": "onboardingDescription3",
      "image": "assets/images/screen3.png",
      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTty_StL4s-czvLRnvjs-f4qazAS57qhtHf8oxwcva5waEL2jUko6RgNA_4LefXT_EvM9LMejqdeNJYGLCEXnTQhE0&s&ec=121532766",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 42, 143, 245),
              Color(0xFF89BDF0),
              Color.fromARGB(255, 159, 189, 218),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    controller.jumpToPage(pages.length - 1);
                  },
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final title = index == 0
                        ? S.of(context).onboardingTitle1
                        : index == 1
                        ? S.of(context).onboardingTitle2
                        : S.of(context).onboardingTitle3;
                    final description = index == 0
                        ? S.of(context).onboardingDescription1
                        : index == 1
                        ? S.of(context).onboardingDescription2
                        : S.of(context).onboardingDescription3;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                pages[index]["image"]!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: title.length > 20 ? 19.sp : 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Text(
                            description,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[200],
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8.h,
                    width: currentIndex == index ? 30 : 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.indigo
                          : const Color.fromARGB(
                              255,
                              5,
                              173,
                              224,
                            ).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: GestureDetector(
                  onTap: () async {
                    if (currentIndex == pages.length - 1) {
                      await sl<Prefs>().setBool("showOnboarding", true);
                      print(
                        "showOnbording ====================================== ${sl<Prefs>().getBool("showOnboarding")}",
                      );
                      context.go(Routes.login);
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300.w),
                      child: Container(
                        height: 48.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF0400F9).withOpacity(0.5),
                              const Color(0xFF0AD7F6).withOpacity(0.6),
                              const Color(0xFF9418EC).withOpacity(0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Text(
                          currentIndex == pages.length - 1
                              ? S.of(context).onboardingGetStarted
                              : S.of(context).onboardingNext,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
