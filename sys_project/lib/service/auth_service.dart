import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sys_project/providers/supabase_client.dart';

class AuthService {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

}
