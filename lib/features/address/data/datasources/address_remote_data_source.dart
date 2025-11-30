import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/address/data/models/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressRemoteDataSource {
  final ISupabaseService supabaseService;

  AddressRemoteDataSource(this.supabaseService);

  //==============|| Add New Address ||===================
  Future<Either<Failure, void>> addAddress({
    required String addressText,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final session = supabaseService.auth.currentSession;
      final user = session?.user;
      if (user == null) {
        return Left(Failure('please login first'));
      }

      await supabaseService.client.from('user_addresses').insert({
        'user_id': user.id,
        'address_text': addressText,
        'latitude': latitude,
        'longitude': longitude,
      });

      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //==============|| Get Address ||===================
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    try {
      final session = supabaseService.auth.currentSession;
      final user = session?.user;
      if (user == null) {
        return Left(Failure('please login first'));
      }
      final addresses = await supabaseService.client
          .from('user_addresses')
          .select()
          .eq('user_id', user.id);

      return Right(addresses.map((e) => AddressModel.fromMap(e)).toList());
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
