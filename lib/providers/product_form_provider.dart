import 'package:flutter/cupertino.dart';
import '../models/models.dart';

class ProductFormProvider extends ChangeNotifier {
	GlobalKey<FormState> formKey = GlobalKey<FormState>();
	Product product;

	ProductFormProvider( this.product );

	updateAvailability( bool value ) {
		product.available = value;
		notifyListeners();
	}

	bool isValidForm() {
		return formKey.currentState?.validate() ?? false;
	}
}