import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsFetchInProgress extends ProductDetailsState {}

class ProductDetailsFetchSuccessful extends ProductDetailsState {
  final String productDetails;

  ProductDetailsFetchSuccessful(this.productDetails);
}

class ProductDetailsFetchFailure extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsFetchFailure(this.errorMessage);
}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial()) {
    fetchProductDetails();
  }

  void fetchProductDetails() async {
    emit(ProductDetailsFetchInProgress());
    try {
      final result =
          await http.get(Uri.parse("https://fakestoreapi.com/products/1"));

      emit(ProductDetailsFetchSuccessful(result.body));
    } on SocketException catch (_) {
      emit(ProductDetailsFetchFailure("No internet error message"));
    } catch (e) {
      emit(ProductDetailsFetchFailure(e.toString()));
    }
  }
}
