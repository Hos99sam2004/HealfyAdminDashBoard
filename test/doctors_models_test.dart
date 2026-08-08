import 'package:flutter_test/flutter_test.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_review_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_verification_model.dart';

void main() {
  group('Doctor models', () {
    test('DoctorReviewModel parses review payloads correctly', () {
      final review = DoctorReviewModel.fromMap({
        'id': 'r1',
        'patient_name': 'Sara',
        'rating': 5,
        'comment': 'Excellent care',
        'created_at': '2026-07-20T09:00:00.000Z',
      });

      expect(review.id, 'r1');
      expect(review.patientName, 'Sara');
      expect(review.rating, 5);
      expect(review.comment, 'Excellent care');
    });

    test('DoctorVerificationModel parses status and timeline data', () {
      final verification = DoctorVerificationModel.fromMap({
        'id': 'v1',
        'status': 'approved',
        'verified_by': 'Admin Team',
        'verified_at': '2026-07-22T10:00:00.000Z',
        'reason': 'All documents verified',
      });

      expect(verification.id, 'v1');
      expect(verification.status, 'approved');
      expect(verification.verifiedBy, 'Admin Team');
      expect(verification.reason, 'All documents verified');
    });
  });
}
