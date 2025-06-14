import 'dart:convert';
import 'package:http/http.dart' as http;

const String folderId =
    '1wzRrtW0-fS2uLg-KbdqcyP3y1wQe9bDY'; // replace with your folder ID
const String apiKey =
    'AIzaSyCcQbiR3b_emw_UYN8cIlx_BoSiS90Si_g'; // replace with your API key

Future<Map<String, dynamic>?> fetchLatestPhotoMetadata() async {
  final uri = Uri.parse(
    'https://www.googleapis.com/drive/v3/files'
    '?q=\'$folderId\'+in+parents+and+mimeType+contains+\'image/\''
    '&orderBy=createdTime+desc'
    '&pageSize=1'
    '&fields=files(id,name,createdTime)'
    '&key=$apiKey',
  );

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['files'] != null && data['files'].isNotEmpty) {
      return data['files'][0];
    }
  } else {
    print("❌ Failed to fetch Drive data: ${response.statusCode}");
  }

  return null;
}
