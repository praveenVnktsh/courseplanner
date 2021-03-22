import 'dart:developer';

import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart' as auth;

import 'credentials.dart';

class GSheet {
  //range in the form "sheetname!A:C" A:C is range of columns
  //data returned in the form of [[row], [row], [row], [row]]
  final scopes = [sheets.SheetsApi.SpreadsheetsScope];

  String spreadSheetID;
  bool refreshNeeded;
  GSheet(
    String id,
  ) {
    this.spreadSheetID = id;
  }

  Future writeData(var data, String range) async {
    await auth.clientViaServiceAccount(credentials, this.scopes).then((client) {
      auth
          .obtainAccessCredentialsViaServiceAccount(
              credentials, this.scopes, client)
          .then((auth.AccessCredentials cred) {
        SheetsApi api = new SheetsApi(client);
        ValueRange vr = new sheets.ValueRange.fromJson({
          "values": data //data is [[row1],[row2], ...]
        });
        api.spreadsheets.values
            .append(vr, this.spreadSheetID, range,
                valueInputOption: 'USER_ENTERED')
            .then((AppendValuesResponse r) {
          client.close();
        });
      });
    });
  }

  Stream<List> getData(String range, {forceRefresh = false}) async* {
    var returnval;
    log("Getting data at $range from internet", name: "SHEET");
    returnval = await getDataOnline(range);

    yield returnval;
  }

  Future<List> getDataOnline(String range) async {
    var returnval;
    await auth
        .clientViaServiceAccount(credentials, this.scopes)
        .then((client) async {
      await auth
          .obtainAccessCredentialsViaServiceAccount(
              credentials, this.scopes, client)
          .then((auth.AccessCredentials cred) async {
        SheetsApi api = new SheetsApi(client);
        await api.spreadsheets.values.get(this.spreadSheetID, range).then((qs) {
          returnval = qs.values;
        });
      });
    });
    return returnval;
  }

  Future updateData(var data, String range) async {
    await auth.clientViaServiceAccount(credentials, this.scopes).then((client) {
      auth
          .obtainAccessCredentialsViaServiceAccount(
              credentials, this.scopes, client)
          .then((auth.AccessCredentials cred) {
        SheetsApi api = new SheetsApi(client);

        ValueRange vr = new sheets.ValueRange.fromJson({"values": data});
        api.spreadsheets.values
            .update(vr, this.spreadSheetID, range,
                valueInputOption: 'USER_ENTERED')
            .then((UpdateValuesResponse r) {
          log("Updated data at $range", name: "SHEET");
          client.close();
        });
      });
    });
  }
}
