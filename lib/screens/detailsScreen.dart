import 'package:flutter/material.dart';
import 'package:internet_connection/features/todos/productDetailsCubit.dart';
import 'package:internet_connection/screens/widgets/internetListenerWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ProductDetailsCubit>().fetchProductDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InternetListenerWidget(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Product Details"),
          ),
          body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              bloc: context.read<ProductDetailsCubit>(),
              builder: (context, state) {
                if (state is ProductDetailsFetchInProgress ||
                    state is ProductDetailsInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ProductDetailsFetchFailure) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }

                return Center(
                  child: Text(
                      (state as ProductDetailsFetchSuccessful).productDetails),
                );
              }),
        ),
        onInternetConnectionBack: () {
          if (context.read<ProductDetailsCubit>().state
              is ProductDetailsFetchFailure) {
            //
            context.read<ProductDetailsCubit>().fetchProductDetails();
          }
        });
  }
}
