// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class UrlLauncherService {
//   UrlLauncherService._();

//   // =========================
//   // INTERNAL HELPERS
//   // =========================

//   static void _showSnackBar(
//     BuildContext context,
//     String message, {
//     Color? color,
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: color ?? Colors.red),
//     );
//   }

//   static Future<void> _withLoading(
//     BuildContext context,
//     Future<void> Function() action,
//   ) async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       await action();
//     } catch (e) {
//       _showSnackBar(context, e.toString());
//     } finally {
//       if (Navigator.canPop(context)) {
//         Navigator.pop(context);
//       }
//     }
//   }

//   // =========================
//   // OPEN URL
//   // =========================

//   static Future<void> openUrl(BuildContext context, String url) async {
//     await _withLoading(context, () async {
//       final uri = Uri.tryParse(url);

//       if (uri == null) {
//         throw 'Invalid URL';
//       }

//       final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

//       if (!ok) {
//         throw 'Could not open URL';
//       }
//     });
//   }

//   // =========================
//   // PHONE CALL
//   // =========================

//   static Future<void> callPhone(BuildContext context, String phone) async {
//     await _withLoading(context, () async {
//       final uri = Uri.parse('tel:$phone');

//       final ok = await launchUrl(uri);

//       if (!ok) {
//         throw 'Could not make call';
//       }
//     });
//   }

//   // =========================
//   // WHATSAPP (with fallback)
//   // =========================

//   static Future<void> openWhatsApp(
//     BuildContext context, {
//     required String phone,
//     String? message,
//   }) async {
//     await _withLoading(context, () async {
//       final formattedPhone = phone.replaceAll('+', '');
//       final text = message != null
//           ? '&text=${Uri.encodeComponent(message)}'
//           : '';

//       final uri = Uri.parse('https://wa.me/$formattedPhone$text');

//       final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

//       if (!ok) {
//         // 🔁 fallback to browser
//         final fallbackUri = Uri.parse(
//           'https://api.whatsapp.com/send?phone=$formattedPhone',
//         );

//         final fallbackOk = await launchUrl(
//           fallbackUri,
//           mode: LaunchMode.externalApplication,
//         );

//         if (!fallbackOk) {
//           throw 'WhatsApp not available';
//         }
//       }
//     });
//   }

//   // =========================
//   // EMAIL
//   // =========================

//   static Future<void> sendEmail(
//     BuildContext context, {
//     required String email,
//     String subject = '',
//     String body = '',
//   }) async {
//     await _withLoading(context, () async {
//       final uri = Uri(
//         scheme: 'mailto',
//         path: email,
//         query: Uri.encodeFull('subject=$subject&body=$body'),
//       );

//       final ok = await launchUrl(uri);

//       if (!ok) {
//         throw 'Could not send email';
//       }
//     });
//   }

//   // =========================
//   // MAPS
//   // =========================

//   static Future<void> openMap(
//     BuildContext context, {
//     required double lat,
//     required double lng,
//   }) async {
//     await _withLoading(context, () async {
//       final uri = Uri.parse(
//         'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
//       );

//       final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

//       if (!ok) {
//         throw 'Could not open map';
//       }
//     });
//   }

//   // =========================
//   // ACTION SHEET (UNIFIED UI)
//   // =========================

//   static void showActionSheet(
//     BuildContext context, {
//     String? phone,
//     String? email,
//     String? url,
//     double? lat,
//     double? lng,
//   }) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         side: BorderSide(color: Color(0xFF000000)),
//       ),
//       builder: (_) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 10),

//               // URL
//               if (url != null)
//                 ListTile(
//                   leading: const Icon(Icons.link),
//                   iconColor: Colors.indigo,
//                   title: const Text('Open Link'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     openUrl(context, url);
//                   },
//                 ),

//               // Call
//               if (phone != null)
//                 ListTile(
//                   leading: const Icon(Icons.call),
//                   iconColor: Colors.blue,
//                   title: const Text('Call'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     callPhone(context, phone);
//                   },
//                 ),

//               // WhatsApp
//               if (phone != null)
//                 ListTile(
//                   leading: const Icon(Icons.chat),
//                   iconColor: Colors.green,
//                   title: const Text('WhatsApp'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     openWhatsApp(context, phone: phone);
//                   },
//                 ),

//               // Email
//               if (email != null)
//                 ListTile(
//                   leading: const Icon(Icons.email),
//                   iconColor: Colors.red,
//                   title: const Text('Email'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     sendEmail(context, email: email);
//                   },
//                 ),

//               // Map
//               if (lat != null && lng != null)
//                 ListTile(
//                   leading: const Icon(Icons.map),
//                   iconColor: Colors.deepOrange,
//                   title: const Text('Open Map'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     openMap(context, lat: lat, lng: lng);
//                   },
//                 ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  UrlLauncherService._();

  // =========================
  // INTERNAL HELPERS
  // =========================

  static void _showSnackBar(
    BuildContext context,
    String message, {
    Color? color,
  }) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color ?? Colors.red),
    );
  }

  static Future<void> _withLoading(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    // 1️⃣ إظهار مؤشر التحميل
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await action();
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, e.toString());
      }
    } finally {
      // 2️⃣ إغلاق الـ Dialog بأمان شديد من الـ rootNavigator دون إغلاق الشاشة
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  // =========================
  // OPEN URL
  // =========================

  static Future<void> openUrl(BuildContext context, String url) async {
    await _withLoading(context, () async {
      final uri = Uri.tryParse(url);

      if (uri == null) {
        throw 'Invalid URL';
      }

      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!ok) {
        throw 'Could not open URL';
      }
    });
  }

  // =========================
  // PHONE CALL
  // =========================

  static Future<void> callPhone(BuildContext context, String phone) async {
    await _withLoading(context, () async {
      final uri = Uri.parse('tel:$phone');

      final ok = await launchUrl(uri);

      if (!ok) {
        throw 'Could not make call';
      }
    });
  }

  // =========================
  // WHATSAPP (with fallback)
  // =========================

  static Future<void> openWhatsApp(
    BuildContext context, {
    required String phone,
    String? message,
  }) async {
    await _withLoading(context, () async {
      final formattedPhone = phone.replaceAll('+', '');
      final text = message != null
          ? '&text=${Uri.encodeComponent(message)}'
          : '';

      final uri = Uri.parse('https://wa.me/$formattedPhone$text');

      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!ok) {
        // 🔁 fallback to browser
        final fallbackUri = Uri.parse(
          'https://api.whatsapp.com/send?phone=$formattedPhone',
        );

        final fallbackOk = await launchUrl(
          fallbackUri,
          mode: LaunchMode.externalApplication,
        );

        if (!fallbackOk) {
          throw 'WhatsApp not available';
        }
      }
    });
  }

  // =========================
  // EMAIL
  // =========================

  static Future<void> sendEmail(
    BuildContext context, {
    required String email,
    String subject = '',
    String body = '',
  }) async {
    await _withLoading(context, () async {
      final uri = Uri(
        scheme: 'mailto',
        path: email,
        query: Uri.encodeFull('subject=$subject&body=$body'),
      );

      final ok = await launchUrl(uri);

      if (!ok) {
        throw 'Could not send email';
      }
    });
  }

  // =========================
  // MAPS
  // =========================

  static Future<void> openMap(
    BuildContext context, {
    required double lat,
    required double lng,
  }) async {
    await _withLoading(context, () async {
      final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );

      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!ok) {
        throw 'Could not open map';
      }
    });
  }

  // =========================
  // ACTION SHEET (UNIFIED UI)
  // =========================

  static void showActionSheet(
    BuildContext context, {
    String? phone,
    String? email,
    String? url,
    double? lat,
    double? lng,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF000000)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),

              // URL
              if (url != null)
                ListTile(
                  leading: const Icon(Icons.link),
                  iconColor: Colors.indigo,
                  title: const Text('Open Link'),
                  onTap: () {
                    Navigator.pop(context);
                    openUrl(context, url);
                  },
                ),

              // Call
              if (phone != null)
                ListTile(
                  leading: const Icon(Icons.call),
                  iconColor: Colors.blue,
                  title: const Text('Call'),
                  onTap: () {
                    Navigator.pop(context);
                    callPhone(context, phone);
                  },
                ),

              // WhatsApp
              if (phone != null)
                ListTile(
                  leading: const Icon(Icons.chat),
                  iconColor: Colors.green,
                  title: const Text('WhatsApp'),
                  onTap: () {
                    Navigator.pop(context);
                    openWhatsApp(context, phone: phone);
                  },
                ),

              // Email
              if (email != null)
                ListTile(
                  leading: const Icon(Icons.email),
                  iconColor: Colors.red,
                  title: const Text('Email'),
                  onTap: () {
                    Navigator.pop(context);
                    sendEmail(context, email: email);
                  },
                ),

              // Map
              if (lat != null && lng != null)
                ListTile(
                  leading: const Icon(Icons.map),
                  iconColor: Colors.deepOrange,
                  title: const Text('Open Map'),
                  onTap: () {
                    Navigator.pop(context);
                    openMap(context, lat: lat, lng: lng);
                  },
                ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
