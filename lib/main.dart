import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  	const AppState({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			providers: [
				ChangeNotifierProvider(create: ( _ ) => ProductsService(), lazy: false, ),
				ChangeNotifierProvider(create: ( _ ) => AuthService(), lazy: false, )
			],
			child: const MyApp(),
		);
	}
}

class MyApp extends StatelessWidget {
	const MyApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Products App',
			initialRoute: 'checking',
			routes: {
				'checking': ( _ ) => const CheckAuthScreen(),
				'register': ( _ ) => const RegisterScreen(),
				'login': ( _ ) => const LoginScreen(),
				'home' : ( _ ) => const HomeScreen(),
				'product': ( _ ) => const ProductScreen()
			},
			scaffoldMessengerKey: NotificationsService.messengerKey,
			theme: ThemeData.light().copyWith(
				scaffoldBackgroundColor: Colors.grey[ 300 ],
				appBarTheme: const AppBarTheme(
					elevation: 0,
					color: Colors.indigo
				),
				floatingActionButtonTheme: const FloatingActionButtonThemeData(
					backgroundColor: Colors.indigo,
					elevation: 0
				)
			),
		);
	}
}