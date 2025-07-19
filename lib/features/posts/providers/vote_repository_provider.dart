import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agnonymous_app/data/datasources/supabase_datasource.dart';
import 'package:agnonymous_app/data/repositories/vote_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final voteRepositoryProvider = Provider<VoteRepository>((ref) {
  final supabaseClient = Supabase.instance.client;
  final supabaseDatasource = SupabaseDatasource(supabaseClient);
  return VoteRepository(supabaseDatasource);
});