import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agnonymous_app/core/errors/app_exceptions.dart';

class SupabaseDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseDatasource(this._supabaseClient);

  /// Fetches data from a specified table.
  Future<List<Map<String, dynamic>>> fetchData(String tableName, {Map<String, dynamic>? query}) async {
    try {
      PostgrestFilterBuilder queryBuilder = _supabaseClient.from(tableName).select();

      if (query != null) {
        query.forEach((key, value) {
          queryBuilder = queryBuilder.eq(key, value);
        });
      }

      final List<Map<String, dynamic>> response = await queryBuilder;
      return response;
    } on PostgrestException catch (e) {
      throw NetworkException('Failed to fetch data from $tableName', details: e.message);
    } catch (e) {
      throw AppException('An unexpected error occurred while fetching data', details: e.toString());
    }
  }

  /// Inserts data into a specified table.
  Future<Map<String, dynamic>> insertData(String tableName, Map<String, dynamic> data) async {
    try {
      final List<Map<String, dynamic>> response = await _supabaseClient.from(tableName).insert(data as Map<String, Object>).select();
      if (response.isEmpty) {
        throw AppException('Insert operation returned no data');
      }
      return response.first;
    } on PostgrestException catch (e) {
      throw NetworkException('Failed to insert data into $tableName', details: e.message);
    } catch (e) {
      throw AppException('An unexpected error occurred while inserting data', details: e.toString());
    }
  }

  /// Updates data in a specified table.
  Future<Map<String, dynamic>> updateData(String tableName, Map<String, dynamic> data, Map<String, dynamic> match) async {
    try {
      final List<Map<String, dynamic>> response = await _supabaseClient.from(tableName).update(data as Map<String, Object>).match(match as Map<String, Object>).select();
      if (response.isEmpty) {
        throw AppException('Update operation returned no data');
      }
      return response.first;
    } on PostgrestException catch (e) {
      throw NetworkException('Failed to update data in $tableName', details: e.message);
    } catch (e) {
      throw AppException('An unexpected error occurred while updating data', details: e.toString());
    }
  }

  /// Deletes data from a specified table.
  Future<void> deleteData(String tableName, Map<String, dynamic> match) async {
    try {
      await _supabaseClient.from(tableName).delete().match(match as Map<String, Object>);
    } on PostgrestException catch (e) {
      throw NetworkException('Failed to delete data from $tableName', details: e.message);
    } catch (e) {
      throw AppException('An unexpected error occurred while deleting data', details: e.toString());
    }
  }
}