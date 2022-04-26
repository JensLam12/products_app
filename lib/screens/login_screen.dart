import 'package:flutter/material.dart';
import 'package:products_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
   
	const LoginScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: AuthBackground( 
				child: SingleChildScrollView(
					child: Column(
						children: [
							const SizedBox(height : 220),
							CardContainer(
								child: Column(
									children: [
										const SizedBox( height: 10 ),
										Text( 'Login', style: Theme.of(context).textTheme.headline4 ),
										const SizedBox( height: 30 ),
										const _LoginForm()
									],
								)
							),
							const SizedBox( height: 40 ),
							const Text('Create a new account', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold))
						],
					),
				),
			)
		);
	}
}


class _LoginForm extends StatelessWidget {
	const _LoginForm({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			child: Form(
				child: Column(
					children: [
						TextFormField(
							autocorrect: false,
							keyboardType: TextInputType.emailAddress,
							decoration: const InputDecoration(
								enabledBorder: UnderlineInputBorder(
									borderSide: BorderSide(
										color: Colors.deepPurple
									)
								),
								focusedBorder: UnderlineInputBorder(
									borderSide: BorderSide(
										color: Colors.deepPurple,
										width: 2
									)
								),
								hintText: 'example@gmail.com',
								labelText: 'Email',
								labelStyle: TextStyle(
									color: Colors.grey
								),
								prefixIcon: Icon( Icons.alternate_email_sharp, color: Colors.deepPurple )
							),
						)
					],
				),
			),
		);
	}
}