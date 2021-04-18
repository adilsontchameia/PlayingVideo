import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controlador do video
  VideoPlayerController _controller;

  //Iniciando o video
  //Reproduzindo apartir da internet
  @override
  void initState() {
    super.initState();
    /* 
    _controller = VideoPlayerController.network("link do video")
      ..initialize().then(
        (_) {
          //_ => nao criar uma variavel para capturar retorno
          setState(() {
            _controller.play();
          });
        },
        );
        */
    //.. => operador de chamada de metodo de cascata
    //o retorno e desconsiderado, e retorna o video player
    _controller = VideoPlayerController.asset("videos/exemplo.mp4")
      //Repeticao ativada
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          //_controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //Tamanho da exibicao - largura/altura 800 / 600
        //caso seja verdadeiro
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            //Caso nao for inicializado
            : Text("Pressione Play"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.play_arrow,
        ),
        onPressed: () {
          setState(() {
            //Testando se esta reproduzindo
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
      ),
    );
  }
}
