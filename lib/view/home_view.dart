// ignore_for_file: unused_local_variable, constant_pattern_never_matches_value_type, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mvvm/data/resources/status.dart';
import 'package:mvvm/res/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/movies_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  MoviesViewModel moviesViewModel = MoviesViewModel();

  @override
  void initState() {
    moviesViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.buttonBackgroundColor,
          actions: [
            InkWell(
                onTap: () {
                  userPreference.removeUser().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Logout",
                    style: TextStyle(color: AppColors.buttonTextColor),
                  ),
                ))),
          ],
        ),
        body: ChangeNotifierProvider<MoviesViewModel>(
          create: (BuildContext context) => moviesViewModel,
          child: Consumer<MoviesViewModel>(builder: (context, value, _) {
            switch (value.moviesList.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());

              case Status.ERROR:
                return Center(child: Text(value.moviesList.message.toString()));

              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.moviesList.data!.movies!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,
                            value.moviesList.data!.movies![index].posterurl
                                .toString(),
                            errorBuilder: (context, error, stack) {
                              return Icon(
                                Icons.error,
                                color: Colors.red,
                              );
                            },
                          ),
                          title: Text(value
                              .moviesList.data!.movies![index].title
                              .toString()),
                          subtitle: Text(value
                              .moviesList.data!.movies![index].year
                              .toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.averageRating(value
                                      .moviesList.data!.movies![index].ratings!)
                                  .toStringAsFixed(1)),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              case null:
            }
            return Container();
          }),
        ),
      ),
    );
  }
}
