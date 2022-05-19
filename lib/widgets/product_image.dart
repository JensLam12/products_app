import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
	final String? url;

	const ProductImage({Key? key, this.url}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.only( left: 10, right: 10, top: 10),
			child: Container(
				width: double.infinity,
				height: 350,
				decoration: _BuildBoxDecoration(),
				child: Opacity(
					opacity: 0.8,
					child: ClipRRect(
						borderRadius: const BorderRadius.only( topLeft: Radius.circular(45), topRight: Radius.circular(45)),
						child: getImage(url),
					),
				),
			),
		);
	}

	BoxDecoration _BuildBoxDecoration() => BoxDecoration(
		color: Colors.black,
		borderRadius: const BorderRadius.only( topLeft: Radius.circular(45), topRight:  Radius.circular(45) ),
		boxShadow: [
			BoxShadow(
				color: Colors.black.withOpacity( 0.05 ),
				blurRadius: 10,
				offset: const Offset(0,5)
			)
		]
	);

	Widget getImage( String? picture ) {
		if( picture == null) {
			return const Image(
				image: AssetImage('Assets/no-image.png'),
				fit: BoxFit.cover,
			);
		}

		if( picture.startsWith('http') ) {
			return FadeInImage(
				image: NetworkImage( url! ),
				placeholder: const AssetImage('Assets/jar-loading.gif'),
				fit: BoxFit.cover,
			);
		}
		
		return Image.file(
			File(picture),
			fit: BoxFit.cover,
		);
	}
}