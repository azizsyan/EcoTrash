import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class AuthService {
  final Dio _dio = DioClient().dio;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Login gagal');
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Registrasi gagal');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio.get('/profile');
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Gagal mengambil data profil');
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final response = await _dio.patch(
        '/profile/password',
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Gagal mengubah password');
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    required String phone,
    // courier details optional
    String? vehicleType,
    String? vehiclePlate,
    String? address,
    String? city,
    String? province,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'phone': phone,
      };
      if (vehicleType != null) data['vehicle_type'] = vehicleType;
      if (vehiclePlate != null) data['vehicle_plate'] = vehiclePlate;
      if (address != null) data['address'] = address;
      if (city != null) data['city'] = city;
      if (province != null) data['province'] = province;

      final response = await _dio.patch(
        '/profile',
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Gagal memperbarui profil');
    }
  }
}
