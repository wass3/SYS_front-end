import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseUrl = dotenv.get('SUPABASE_URL');
final supabaseKey = dotenv.get('SUPABASE_KEY');

SupabaseClient supabase = SupabaseClient(supabaseUrl, supabaseKey);