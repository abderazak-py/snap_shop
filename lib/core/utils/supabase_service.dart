import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ISupabaseService {
  SupabaseClient get client;
  GoTrueClient get auth;
  SupabaseQueryBuilder from(String table);
}

class SupabaseService implements ISupabaseService {
  final SupabaseClient _client;

  SupabaseService(this._client);

  @override
  SupabaseClient get client => _client;

  @override
  GoTrueClient get auth => _client.auth;

  @override
  SupabaseQueryBuilder from(String table) => _client.from(table);
}
