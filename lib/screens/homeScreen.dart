import 'package:flutter/material.dart';
import 'package:internet_connection/features/todos/productDetailsCubit.dart';
import 'package:internet_connection/features/todos/todoCubit.dart';
import 'package:internet_connection/screens/detailsScreen.dart';
import 'package:internet_connection/screens/widgets/internetListenerWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/screens/widgets/noInternetOverlayContainer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? overlayEntry;
  late GlobalKey<NoInternetOverlayContainerState> _noInternetOverlayKey =
      GlobalKey<NoInternetOverlayContainerState>();

  void showNoInternetMessage() {
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => NoInternetOverlayContainer(
        key: _noInternetOverlayKey,
      ),
    );

    overlayState?.insert(overlayEntry!);
  }

  Future<void> removeInternetMessage() async {
    //
    await _noInternetOverlayKey.currentState?.animationController.reverse();
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InternetListenerWidget(
        addOverlay: showNoInternetMessage,
        removeOverlay: removeInternetMessage,
        showOverlay: true,
        onInternetConnectionBack: () {
          if (context.read<TodoCubit>().state is TodoFetchFailure) {
            context.read<TodoCubit>().fetchTodos();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Home screen"),
          ),
          body: BlocBuilder<TodoCubit, TodoState>(
              bloc: context.read<TodoCubit>(),
              builder: (context, state) {
                if (state is TodoFetchInProgress || state is TodoFetchInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is TodoFetchFailure) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }

                return ListView.builder(
                    itemCount: (state as TodoFetchSuccessful).todoIds.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BlocProvider<ProductDetailsCubit>(
                                  child: ProductDetailsScreen(),
                                  create: (_) => ProductDetailsCubit()),
                            ));
                          },
                          child: ListTile(
                            title: Text(index.toString()),
                          ),
                        ),
                      );
                    });
              }),
        ));
  }
}
