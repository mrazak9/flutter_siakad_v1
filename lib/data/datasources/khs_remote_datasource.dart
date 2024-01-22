import 'package:dartz/dartz.dart';
import 'package:flutter_siakad_v1/common/constants/variables.dart';
import 'package:flutter_siakad_v1/data/datasources/auth_local_datasource.dart';
import 'package:flutter_siakad_v1/data/models/response/khs_response_model.dart';
import 'package:http/http.dart' as http;

class KhsRemoteDatasource {
  Future<Either<String, KhsResponseModel>> getKhs() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${await AuthLocalDatasource().getToken()}'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/khs'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(KhsResponseModel.fromJson(response.body));
    } else {
      return left('server error');
    }
  }
}
