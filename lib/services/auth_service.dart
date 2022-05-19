import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jiffy/jiffy.dart';

class AuthService extends ChangeNotifier {
	final String _baseUrl = 'identitytoolkit.googleapis.com';
	final String _firebaseToken = 'FirebaseTOKEN HERE';
	final storage = FlutterSecureStorage();

	Future<String?> createUser( String email, String password) async {
		final Map<String, dynamic> authData = {
			'email': email,
			'password': password,
			'returnSecureToken': true
		};

		final url = Uri.https( _baseUrl, '/v1/accounts:signUp', {
			'key': _firebaseToken
		});

		final response = await http.post( url, body: json.encode(authData) );
		final Map<String, dynamic> decodedResp = json.decode( response.body );

		if( decodedResp.containsKey('idToken')) {
			final ExpirationDate = Jiffy().add(seconds: int.parse( decodedResp['expiresIn'] ) ) ;
			
			await storage.write( key: 'expirationDate', value: ExpirationDate.toString() );
			await storage.write( key: 'token', value: decodedResp['idToken'] );
			await storage.write( key: 'refreshToken', value: decodedResp['refreshToken'] );
			return null;
		} else {
			return decodedResp['error']['message'];
		}
	}

	Future<String?> login( String email, String password) async {
		final Map<String, dynamic> authData = {
			'email': email,
			'password': password,
			'returnSecureToken': true
		};

		final url = Uri.https( _baseUrl, '/v1/accounts:signInWithPassword', {
			'key': _firebaseToken
		});

		final response = await http.post( url, body: json.encode(authData) );
		final Map<String, dynamic> decodedResp = json.decode( response.body );

		if( decodedResp.containsKey('idToken')) {
			// Token hay que guardarlo en un lugar seguro
			final ExpirationDate = Jiffy().add(seconds: int.parse( decodedResp['expiresIn'] ) ) ;
			
			await storage.write( key: 'expirationDate', value: ExpirationDate.toString() );
			await storage.write( key: 'token', value: decodedResp['idToken'] );
			await storage.write( key: 'refreshToken', value: decodedResp['refreshToken'] );
			return null;
		} else {
			return decodedResp['error']['message'];
		}
	}

	Future logOut() async {
		await storage.delete(key: 'token');
		return;
	}

	Future<String> readToken() async {
		return await storage.read(key: 'token') ?? '';
	}
}