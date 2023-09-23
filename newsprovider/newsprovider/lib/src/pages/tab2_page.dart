import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:newsprovider/src/models/category_model.dart';
import 'package:newsprovider/src/services/news_service.dart';
import 'package:newsprovider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _ListaCategorias(),
            Expanded(child: ListaNoticias(newsService.getArticleSelected))
          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          final cName = categories[index].name;

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _CategoryBoton(categoria: categories[index]),
                const SizedBox(height: 5,),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}' ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CategoryBoton extends StatelessWidget {
  const _CategoryBoton({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  final Category categoria;

  @override
  Widget build(BuildContext context) {
    
    final newsService = Provider.of<NewsService>(context, listen: false);
    
    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == categoria.name)
          ? Colors.blueAccent
          : Colors.blueGrey
        ),
      ),
    );
  }
}