import 'package:flutter/material.dart';
import 'package:products_app/screens/loading_screen.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {

		final productsService = Provider.of<ProductsService>(context);
		final authService = Provider.of<AuthService>(context, listen: false );

		if( productsService.isLoading ) return const LoadingScreen();

		return Scaffold(
			appBar: AppBar(
				title: const Text('Products'),
				actions: [
					IconButton(
						icon: const Icon( Icons.login_outlined),
						onPressed: () {
							authService.logOut();
							Navigator.pushReplacementNamed(context, 'login');
						}, 
					)
				],
			),
			body: ListView.builder(
				itemCount: productsService.products.length,
				itemBuilder: ( BuildContext context, int index ) =>  GestureDetector(
					onTap: () {
						productsService.selectedProduct = productsService.products[ index ].copy();
						Navigator.pushNamed(context, 'product');
					},
					child:  ProductCard( product: productsService.products[ index ] )
				) ,

			),
			floatingActionButton: FloatingActionButton(
				child: const Icon( Icons.add),
				onPressed: () {
					productsService.selectedProduct = Product(available: true, name: '', price: 0.00);
					Navigator.pushNamed(context, 'product');
				},
			),
		);
	}
}