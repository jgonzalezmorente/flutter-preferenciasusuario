import 'package:flutter/material.dart';
import 'package:preferenciasusuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuarioapp/src/widgets/menu_widget.dart';



class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {

  late bool _colorSecundario;
  late int _genero;
  late TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {        
    super.initState();

    prefs.ultimaPagina = SettingsPage.routeName;

    _genero          = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textController  = new TextEditingController(
      text: prefs.nombreUsuario 
    );


  }


  _setSelectedRadio( int? valor ) {

    prefs.genero = valor ?? 1;

    _genero = valor ?? 1;
    setState( () {} );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Ajustes' ),
        centerTitle: true,
        backgroundColor: ( prefs.colorSecundario ) ? Colors.teal: Colors.blue
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all( 5.0 ),
            child: Text( 'Settings', style: TextStyle( fontSize: 45.0, fontWeight: FontWeight.bold ) ),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text( 'Color secundario' ),
            onChanged: ( value ) {              
              setState( () {
                _colorSecundario = value;
                prefs.colorSecundario = value;
              });
            },
          ),

          RadioListTile(
            value: 1,
            title: Text( 'Masculino' ),
            groupValue: _genero,
            onChanged: _setSelectedRadio
          ),

          RadioListTile(
            value: 2,
            title: Text( 'Femenino' ),
            groupValue: _genero,
            onChanged: _setSelectedRadio
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric( horizontal: 20.0 ),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono'
              ),
              onChanged: ( value ) {
                prefs.nombreUsuario = value;
              },
            )
          )
        ]
      )
    );
  }
}
