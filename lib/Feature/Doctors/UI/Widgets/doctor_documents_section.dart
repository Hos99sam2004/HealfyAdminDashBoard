import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/networks/ServiceHelper.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_document_model.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DoctorDocumentsSection extends StatelessWidget {
  final List<DoctorDocumentModel> documents;

  const DoctorDocumentsSection({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) {
      return const Text(
        'No documents available.',
        style: TextStyle(color: AppColors.textSecondary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Documents',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: documents.map((doc) {
            final label = doc.label ?? 'Document';
            return GestureDetector(
              onTap: () {
                if (doc.url != null) {
                  UrlLauncherService.openUrl(context, doc.url!);
                }
              },
              child: Chip(
                label: Text(label),
                backgroundColor: AppColors.secondary.withOpacity(0.12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
