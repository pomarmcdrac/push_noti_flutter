import 'package:flutter/material.dart';
import 'package:newsprovider/src/models/news_models.dart';
import 'package:newsprovider/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article>? noticias;

  const ListaNoticias( this.noticias );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias!.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias![index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  const _Noticia({
    Key? key, 
    required this.noticia, 
    required this.index
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia: noticia, index: index,),
        _TarjetaTitulo(noticia: noticia, index: index,),
        _TarjetaImagen(noticia: noticia, index: index,),
        _TarjetaBody(noticia: noticia, index: index,),
        _TarjetaBoton(noticia: noticia, index: index,),

        const SizedBox(height: 10,),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBoton extends StatelessWidget {
  const _TarjetaBoton({
    Key? key, 
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              
            },
            fillColor: Colors.grey,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.star_border_rounded),
          ),
          const SizedBox(width: 10,),
          RawMaterialButton(
            onPressed: () {
              
            },
            fillColor: Colors.blueAccent,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.more_rounded),
          ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  const _TarjetaBody({
    Key? key, 
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text( (noticia.description != null ) ? noticia.description.toString() : '' ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  const _TarjetaImagen({
    Key? key, 
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          child: (noticia.urlToImage != null) 
          ? FadeInImage(
              placeholder: const AssetImage('assets/img/giphy.gif'),
              image: NetworkImage(noticia.urlToImage.toString()),
            )
          : const Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  const _TarjetaTitulo({
    Key? key, 
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text('${noticia.title}. ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  const _TarjetaTopBar({
    Key? key, 
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index+1}. ', style: const TextStyle(color: Colors.blueAccent),),
          Text('${noticia.source.name}. ')
        ],
      ),
    );
  }
}