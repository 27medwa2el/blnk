import 'package:blnk_test/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi{
  static const _credentials=r''''''
  {
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}
''';
  static final _spreadsheetId= '';
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
