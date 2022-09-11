import 'package:blnk_test/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi{
  static const _credentials=r'''
  {
  "type": "service_account",
  "project_id": "eco-layout-361711",
  "private_key_id": "172e6d6108a29526e9fc5c4b12c3baf89f3cf58f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCQ533shTe3tfB4\nDgGWFPN2GFmY5ShAEw9ailrVxgxHl9ey5TZlEhzGhcX4AsjsydDoPcBdrPUH36m1\nnN0LEWo5oxOsibr6fJYx58qs4bSI4DeIeP3umHvaxFyzT6eQNrN1zzxYK6WFTPTo\n+sB68/gtlYUtRwQK5wP+lGKz+KiECavZnGNhKd4wRpkVz7Ny+w0NLVscV3xqPwbe\nSUAF0+wcAfzmAvk2Cml/hvwGB2pVBAr9V6cVakiZIoEo4SKy7dnGaN/QcoSnihag\nSadLyWfQmFV5E3YDI9zQMLV+ptstAlGqcbGRfeVTGdHyP+3zv/y8T+SLMCQaw8PM\nrRjH6GizAgMBAAECggEAA527T0E91DhWoXBcCsZIExzlc4LYf8zZ97z3KlmQaeL4\nr463zkrm6+9fsuJC6GHa9EjCObQ8wy8KOa2J+KI9H+YZchdX0rN0PheWP708N6Q8\nzouSbrdgc+Otmo301Q0AaoK680pXjZ2PiRbk4cyf12dhVPFuQOVl/J7wXaRpdC4N\n+1pxvM+d1OOaJ4iMrFPwG+96mcIj0V8rGpTZVMWkNgIAQR2KjaMp5uW1t2K/nMXP\nz07kbaJTz6RkAklLl0YPBK46LRU2CjRT+9v+akO/zWqXztKILij+alxcdnmjndd2\n6qOlT68qqdkmXWxy0JUqYnk/Py+rvLI4FQucuVRQ9QKBgQDKbJsTCYLKyQReEajC\nQrPnQqIc9j3h2jr+YdXDOTvoRsfvIU1hkIYL6bvaWQ3HJs2nbdBVlhJ6KaVNjGqI\nvndLwFOE/qrq8wUxRgGPoqc4/H5URnRXSp9cjmGTzRCvB3nj/RomEYKMrSIG+Ppc\n6g9iy5+qxtN2Sy7hYQ66f+C5xQKBgQC3QZSXcaiybxhuVfvdaDgNeJaV2FjAIJIV\n1IFGiyt3U5bVUnoB5oUkXW0eh7oqfq3iaDVq7c+i7P3/7fddNi5ZoMWgbOpokaJf\nLfzqnmK9ZhRVqEbWnCivoRc9bLLhfHiUKqHTIz41CTw9djWkSSomUrtiAUORgBKc\nQT9keSxYFwKBgQDJdrIYjly4CrzoCtdVECIRRoYmIQWR5SrVxvWDaVEwalHOs+xZ\n8AcZkDVAqWVHEl2YB3lT1RrqrswwlFHravU8VVxKf1QIpnpCghRHqnCYDOSGZ+Ce\niEx3R9XhzjSOnvg3as49mSu/awj0u5QiKWnKwDJXO692inlMItcP0voMqQKBgFSS\nYmXl4Um/tZGuAtdyMnQdE7nBp2u7XE/Qy3xn275tCC4Yqw/Xd9iJeUNetg7Iea0E\nFKrtZya0oqALDV6qE4fvh2T6/s8Vbs7oJVGNmNn5kybYyyBd3vT2rgf98yvWyrru\nVdJf8GR/h5qBxE22KkqXYbzgAnPSnEQaZIwU098vAoGBAJmQ8c3Jw280wC89Bhkc\neQf+ktvjips/4afUNWdhSndgZLCDBseDknnjlQIxlwwBgZ51weHL+HnIyYoqLZk2\nYKmw0RqkFFXkM2mg9dliNngJVt0fwMgEi+ijUvM5AP+plHflex/B1SKdoXGv/ilB\n8DR0RR0krHo0dI4n8CTVBIMS\n-----END PRIVATE KEY-----\n",
  "client_email": "googlesheets@eco-layout-361711.iam.gserviceaccount.com",
  "client_id": "107630790811360964024",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheets%40eco-layout-361711.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId= '12eLjsBYEU5bLGFDZHlm3Tsl80y9Kw9UMby9Xk-4FtO0';
  static final _googlesheets=GSheets(_credentials);
  static Worksheet? _userSheet;
  static Future init()async{
    try{
    final spreadsheet = await _googlesheets.spreadsheet(_spreadsheetId);
    _userSheet= await _getWorkSheet(spreadsheet, title: 'Users sheet');
    final firstRow = UserFields.getFields();
    _userSheet!.values.insertRow(1, firstRow);}
        catch(e){
      print('init Error: $e');
        }
}
static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet,{
      required String title
}) async
{
  try{
  return await spreadsheet.addWorksheet(title);
} catch(e)
  {
    return spreadsheet.worksheetByTitle(title)!;
  }
}
static Future <int> getRowCount() async{
  if(_userSheet==null)return 0;
  final lastRow= await _userSheet!.values.lastRow();
  return lastRow==null?0:int.tryParse(lastRow.first)??0;
}
static Future insert(List<Map<String, dynamic>> rowList) async{
    if(_userSheet==null)return;
    _userSheet!.values.map.appendRows(rowList);
}
}