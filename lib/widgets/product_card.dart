import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
	const ProductCard({Key? key}) : super(key: key);

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
					children: const [
						_BackgroundImage(),
						_ProductDetails(),
						Positioned(
							top: 0,
							right: 0,
							child: _PriceTag()
						),
						Positioned(
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
	const _BackgroundImage({
		Key? key,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ClipRRect(
			borderRadius: BorderRadius.circular(25),
			child: Container(
				width: double.infinity,
				height: 400,
				child: const FadeInImage(
					placeholder: AssetImage('Assets/jar-loading.gif'),
					image: NetworkImage( 'https://via.placeholder.com/400x300/f6f6f6' ),
					fit: BoxFit.cover,
				),
			),
		);
	}
}

class _ProductDetails extends StatelessWidget {
	const _ProductDetails({
		Key? key,
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
					children: const [
						Text(
							'Hard drive', 
							style: TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), 
							maxLines: 1, 
							overflow: TextOverflow.ellipsis 
						),
						Text(
							'Hard drive Id', 
							style: TextStyle( fontSize: 15, color: Colors.white ), 
							
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
	const _PriceTag({
		Key? key,
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
			child: const FittedBox(
				fit: BoxFit.contain,
				child: Padding(
					padding: EdgeInsets.symmetric( horizontal: 10),
					child: Text('\$103333.99', style: TextStyle( color: Colors.white, fontSize: 20))
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
				color: Colors.yellow,
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