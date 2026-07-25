// lib/Feature/Onbording/Onboarding.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_layout.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = const [
    {
      'titleKey': 'onboardingTitle1',
      'descriptionKey': 'onboardingDescription1',
      'image': 'assets/images/onbo1.jpeg',
    },
    {
      'titleKey': 'onboardingTitle2',
      'descriptionKey': 'onboardingDescription2',
      'image': 'assets/images/onbo2.jpeg',
    },
    {
      'titleKey': 'onboardingTitle3',
      'descriptionKey': 'onboardingDescription3',
      'image': 'assets/images/onbo3.jpeg',
    },
  ];

  Future<void> _finish() async {
    await sl<Prefs>().setBool('showOnboarding', true);
    if (!mounted) return;
    context.go(Routes.login);
  }

  void _next() {
    if (_currentIndex == _pages.length - 1) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // ── Skip button ───────────────────────────────────────────
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: AppSpacing.pagePaddingH(context),
                      top: AppSpacing.sm,
                    ),
                    child: TextButton(
                      onPressed: () => _controller.animateToPage(
                        _pages.length - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child: Text(
                        S.of(context).skip,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                // ── PageView ──────────────────────────────────────────────
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (ctx, index) {
                      final titles = [
                        S.of(context).onboardingTitle1,
                        S.of(context).onboardingTitle2,
                        S.of(context).onboardingTitle3,
                      ];
                      final descs = [
                        S.of(context).onboardingDescription1,
                        S.of(context).onboardingDescription2,
                        S.of(context).onboardingDescription3,
                      ];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.pagePaddingH(context),
                        ),
                        child: isDesktop
                            ? _DesktopPage(
                                image: _pages[index]['image']!,
                                title: titles[index],
                                description: descs[index],
                              )
                            : _MobilePage(
                                image: _pages[index]['image']!,
                                title: titles[index],
                                description: descs[index],
                              ),
                      );
                    },
                  ),
                ),

                // ── Dots ──────────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (i) {
                    final active = _currentIndex == i;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: active ? 28 : 8,
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ),

                // ── Next / Get Started ────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.pagePaddingH(context),
                    vertical: AppSpacing.lg,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                            context.responsive(mobile: double.infinity, tablet: 360.0, desktop: 400.0),
                      ),
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _next,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _currentIndex == _pages.length - 1
                                ? S.of(context).onboardingGetStarted
                                : S.of(context).onboardingNext,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Desktop layout: side-by-side ─────────────────────────────────────────────
class _DesktopPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const _DesktopPage({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(image, fit: BoxFit.cover, height: double.infinity),
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Mobile / Tablet layout: stacked ──────────────────────────────────────────
class _MobilePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const _MobilePage({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(image, width: double.infinity, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
