import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductCard extends StatelessWidget {
	final Product product;

	const ProductCard({Key? key, required this.product}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.symmetric( horizontal: 20 ),
			child: Container(
				margin: const EdgeInsets.symmetric( vertical: 30),
				width: double.infinity,
				height: 400,
				decoration: _DecorationCardBorder(),
				child: Stack(
					alignment: Alignment.bottomLeft,
					children: [
						_BackgroundImage(url: product.picture ),
						_ProductDetails( name: product.name, id: product.id! ),
						Positioned(
							top: 0,
							right: 0,
							child: _PriceTag( price: product.price)
						),
						if(!product.available)
							const Positioned(
								top: 0,
								left: 0,
								child: _NotAvailable()
							)
					],
				),
			),
		);
	}

	BoxDecoration _DecorationCardBorder() => BoxDecoration (
		color: Colors.white,
		borderRadius: BorderRadius.circular(25),
		boxShadow: const [
			BoxShadow(
				color: Colors.black12,
				offset: Offset(0, 7),
				blurRadius: 10
			)
		]
	);
}

class _BackgroundImage extends StatelessWidget {
	final String? url;

	const _BackgroundImage({
		Key? key, 
		this.url,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ClipRRect(
			borderRadius: BorderRadius.circular(25),
			child: Container(
				width: double.infinity,
				height: 400,
				child: url == null 
					? const Image(
						image: AssetImage( 'Assets/no-image.png'),
						fit: BoxFit.cover,
					)	 
					: FadeInImage(
						placeholder: const AssetImage('Assets/jar-loading.gif'),
						image: NetworkImage( url! ),
						fit: BoxFit.cover,
					)
				,
			),
		);
	}
}

class _ProductDetails extends StatelessWidget {
	final String name;
	final String id;
	
	const _ProductDetails({
		Key? key, 
		required this.name, 
		required this.id,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.only( right: 50),
			child: Container(
				padding: const EdgeInsets.symmetric( vertical: 14, horizontal: 10),
				width: double.infinity,
				height: 70,
				decoration: _BuildBoxDecoration(),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							name, 
							style: const TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), 
							maxLines: 1, 
							overflow: TextOverflow.ellipsis 
						),
						Text(
							id,
							style: const TextStyle( fontSize: 15, color: Colors.white ), 
							
						)
					],
				),
			),
		);
	}

	BoxDecoration _BuildBoxDecoration() => const BoxDecoration(
		color: Colors.indigo,
		borderRadius: BorderRadius.only( bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
	);
}

class _PriceTag extends StatelessWidget {
	final double price;

	const _PriceTag({
		Key? key, 
		required this.price,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			width: 100,
			height: 70,
			decoration: const BoxDecoration(
				color: Colors.indigo,
				borderRadius: BorderRadius.only( topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
			),
			alignment: Alignment.center,
			child: FittedBox(
				fit: BoxFit.contain,
				child: Padding(
					padding: const EdgeInsets.symmetric( horizontal: 10),
					child: Text( "\$ $price" , style: const TextStyle( color: Colors.white, fontSize: 20))
				),
			),
		);
	}
}

class _NotAvailable extends StatelessWidget {
	const _NotAvailable({
		Key? key,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			width: 100,
			height: 70,
			decoration: const BoxDecoration(
				color: Colors.orange,
				borderRadius: BorderRadius.only( topLeft: Radius.circular(25), bottomRight: Radius.circular(25) )
			),
			child: const FittedBox(
				fit: BoxFit.contain,
				child: Padding(
					padding: EdgeInsets.symmetric( horizontal: 10),
					child: Text('Not available', style: TextStyle( color: Colors.white, fontSize: 20) ),
				),
			),
		);
	}
}