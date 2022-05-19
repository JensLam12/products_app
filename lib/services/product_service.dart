import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
	final String _baseUrl = 'fireBase url';
	final String _apiKey = 'API KEY GOOGLE ACOUNTS';
	final storage = FlutterSecureStorage();
	final List<Product> products = [];
	Product? selectedProduct;
	bool isLoading = true;
	bool isSaving = false;
	File? newPictureFile;

	ProductsService() {
		loadProducts();
	}
	
	Future loadProducts() async {
		try {
			isLoading = true;
			notifyListeners();
			refreshTokenExpired();
			String token = await storage.read(key: 'token') ?? '';
			final url = Uri.https(_baseUrl, 'products.json', {
				'auth': token
			});
			
			final resp = await http.get( url );

			final Map<String, dynamic> productsMap = json.decode( resp.body );

			productsMap.forEach((key, value) {
				final tempProduct = Product.fromMap( value );
				tempProduct.id = key;
				products.add( tempProduct );
			});

			isLoading = false;
			notifyListeners();
		}catch( e ){
			print( e );
		}
		isLoading = false;
		notifyListeners();
	}

	Future saveOrCreateProduct( Product product ) async{
		isSaving = true;
		notifyListeners();

		if( product.id == null) {
			//Create
			await createProduct(product);
		} else {
			//Update
			await updateProduct(product);
		}

		isSaving = false;
		notifyListeners();
	}

	Future<String> updateProduct( Product product ) async {
		refreshTokenExpired();
		final url = Uri.https(_baseUrl, 'products/${ product.id }.json', {
			'auth': await storage.read(key: 'token') ?? ''
		});
		final resp = await http.put( url, body: product.toJson() );
		final decodedData = resp.body;

		final index = products.indexWhere( (element) => element.id == product.id );
		products[index] = product;

		return product.id!;
	}

	Future<String> createProduct( Product product ) async {
		refreshTokenExpired();
		final url = Uri.https(_baseUrl, 'products.json', {
			'auth': await storage.read(key: 'token') ?? ''
		});
		final resp = await http.post( url, body: product.toJson() );
		final decodedData = json.decode( resp.body );
		product.id = decodedData['name'];
		products.add(product);

		return product.id!;
	}

	updateSelectedProductImage( String path ) {
		selectedProduct?.picture = path;
		newPictureFile = File.fromUri( Uri(path: path) );
		notifyListeners();
	}

	Future<String?> uploadImage() async {
		if( newPictureFile == null ) return null;

		isSaving = true;
		notifyListeners();

		final url =  Uri.parse( 'CLOUDINARY WITH CREDENTIALS URL' ); 
		final imageUploadRequest = http.MultipartRequest( 'POST', url );
		final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
		imageUploadRequest.files.add(file);

		final streamResponse = await imageUploadRequest.send();
		final response = await http.Response.fromStream( streamResponse);

		if( response.statusCode != 200 && response.statusCode != 201) {
			return null;
		}

		newPictureFile = null;

		final decodedData = json.decode( response.body );
		return decodedData['secure_url'];
	}

	Future refreshTokenExpired() async {
		String refreshToken = await storage.read(key: 'refreshToken') ?? '';
		
		final authData = {
			'grant_type'        : 'refresh_token',
			'refresh_token'     : refreshToken
    	};

		final url = Uri.https( 'securetoken.googleapis.com', '/v1/token', {
			'key': _apiKey
		});

		final response = await http.post( url, body: json.encode(authData) );

		Map<String, dynamic> decodeResp = json.decode(response.body);
 
		String idToken = decodeResp['id_token'];
	
		if (idToken != null) {
			await storage.write( key: 'token', value: decodeResp['idToken'] );
		} 
	}
}