import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/notifications/data/models/notification_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsRemoteDataSource {
  final ISupabaseService supabaseService;
  NotificationsRemoteDataSource(this.supabaseService);

  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      if (supabaseService.auth.currentUser == null) {
        Left(Failure('User not logged in'));
      }
      final response = await supabaseService
          .from('notifications')
          .select()
          .eq('user_id', supabaseService.auth.currentUser!.id);
      final result = (response as List)
          .map((notification) => NotificationModel.fromMap(notification))
          .toList();
      return Right(result);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch notifications: ${e.message}'));
    } catch (e) {
      return Left(Failure('Failed to fetch notifications: ${e.toString()}'));
    }
  }
}
