import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/supabase_service.dart';
import '../models/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressRemoteDataSource {
  final ISupabaseService supabaseService;

  AddressRemoteDataSource(this.supabaseService);

  //==============|| Add New Address ||===================
  Future<Either<Failure, void>> addAddress({
    required String street,
    required String state,
    required String city,
    required String country,
    required String postal,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final session = supabaseService.auth.currentSession;
      final user = session?.user;
      if (user == null) {
        return Left(Failure('Please login first'));
      }

      // Validate required fields
      if (street.trim().isEmpty) {
        return Left(Failure('Street address is required'));
      }
      if (city.trim().isEmpty) {
        return Left(Failure('City is required'));
      }
      if (country.trim().isEmpty) {
        return Left(Failure('Country is required'));
      }

      await supabaseService.client.from('user_addresses').insert({
        'user_id': user.id,
        'street': street.trim(),
        'state': state.trim(),
        'city': city.trim(),
        'country': country.trim(),
        'postal': postal.trim(),
        'latitude': latitude,
        'longitude': longitude,
      });

      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return Left(Failure('This address already exists'));
      } else if (e.code == '23503') {
        return Left(Failure('User not found. Please login again'));
      } else if (e.code == '23502') {
        return Left(Failure('Missing required address information'));
      }
      return Left(Failure('Failed to save address. Please try again'));
    } on AuthException {
      return Left(Failure('Authentication error. Please login again'));
    } catch (e) {
      return Left(Failure('An unexpected error occurred. Please try again'));
    }
  }

  //==============|| Get Address ||===================
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    try {
      final session = supabaseService.auth.currentSession;
      final user = session?.user;
      if (user == null) {
        return Left(Failure('Please login first'));
      }

      final addresses = await supabaseService.client
          .from('user_addresses')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      if (addresses.isEmpty) {
        return Right([]);
      }

      return Right(addresses.map((e) => AddressModel.fromMap(e)).toList());
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      if (e.code == '42703') {
        return Left(Failure('Database error. Please try again'));
      }
      return Left(Failure('Failed to load addresses. Please try again'));
    } on AuthException {
      return Left(Failure('Authentication error. Please login again'));
    } catch (e) {
      return Left(Failure('An unexpected error occurred. Please try again'));
    }
  }

  //==============|| Delete Address ||===================
  Future<Either<Failure, void>> deleteAddresse(int id) async {
    try {
      final session = supabaseService.auth.currentSession;
      final user = session?.user;
      if (user == null) {
        return Left(Failure('Please login first'));
      }

      if (id <= 0) {
        return Left(Failure('Invalid address ID'));
      }

      await supabaseService.client
          .from('user_addresses')
          .delete()
          .eq('user_id', user.id)
          .eq('id', id);

      return Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      if (e.code == '23503') {
        return Left(Failure('User not found. Please login again'));
      } else if (e.code == '23505') {
        return Left(Failure('Cannot delete address due to existing orders'));
      }
      return Left(Failure('Failed to delete address. Please try again'));
    } on AuthException {
      return Left(Failure('Authentication error. Please login again'));
    } catch (e) {
      debugPrint('$e');
      return Left(Failure('An unexpected error occurred. Please try again'));
    }
  }
}
