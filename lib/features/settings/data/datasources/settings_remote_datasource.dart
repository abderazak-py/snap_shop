import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsRemoteDatasource {
  final ISupabaseService supabaseService;

  SettingsRemoteDatasource(this.supabaseService);

  //update name
  Future<Either<Failure, void>> changeName(String name) async {
    try {
      await supabaseService.client.auth.updateUser(
        UserAttributes(data: {'name': name}),
      );
      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to update name: ${e.message}'));
    } catch (e) {
      return Left(Failure('Failed to update name: ${e.toString()}'));
    }
  }

  //change password
  Future<Either<Failure, void>> changePassword(String password) async {
    try {
      await supabaseService.auth.updateUser(UserAttributes(password: password));
      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to change password: ${e.message}'));
    } catch (e) {
      return Left(Failure('Failed to change password: ${e.toString()}'));
    }
  }

  //change email
  Future<Either<Failure, void>> changeEmail(String email) async {
    try {
      await supabaseService.auth.updateUser(UserAttributes(email: email));
      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to change email: ${e.message}'));
    } catch (e) {
      return Left(Failure('Failed to change email: ${e.toString()}'));
    }
  }

  Future<Either<Failure, void>> changeAvatar(File imageFile) async {
    try {
      final userId = supabaseService.client.auth.currentUser?.id;

      if (userId == null) {
        return Left(Failure('User not authenticated'));
      }

      // Use a fixed filename per user (simpler approach)
      final fileExt = imageFile.path.split('.').last;
      final filePath = '$userId/profile.$fileExt';

      // Upload with upsert: true to automatically replace old file
      await supabaseService.client.storage
          .from('profile_pictures')
          .upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true, // Automatically replaces old file
            ),
          );

      // Get the public URL
      final imageUrl = supabaseService.client.storage
          .from('profile_pictures')
          .getPublicUrl(filePath);

      // Update user metadata
      await supabaseService.client.auth.updateUser(
        UserAttributes(data: {'profile_picture': imageUrl}),
      );

      return const Right(null);
    } on StorageException catch (e) {
      return Left(Failure('Storage error: ${e.message}'));
    } on AuthException catch (e) {
      return Left(Failure('Auth error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }
}
