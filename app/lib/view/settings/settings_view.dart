import 'package:app/entity/settings.dart';
import 'package:app/util/constants.dart';
import 'package:app/view/settings/settings_presenter.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  final _detectionServerController = TextEditingController();
  final _storageServerController = TextEditingController();
  final _settingsPresenter = SettingsPresenter();
  static String _detectionLabel = "Detection Server address";
  static String _storageLabel = "Storage Server address";

  @override
  void dispose() {
    _detectionServerController.dispose();
    _storageServerController.dispose();
    super.dispose();
  }

  @override void initState() {
    _initLabels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: MediaQuery
                .of(context)
                .padding * 1.2,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      _goBack();
                    },
                    child: Icon(
                        Icons.arrow_back,
                        color: Constants.lightIconsColor,
                        size: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07
                    )
                ),
              ]
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _detectionServerController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: _detectionLabel,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _storageServerController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: _storageLabel,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    _applySettings();
                  },
                  child: const Text("Apply"))
            ],
          )
        ],
      ),
    );
  }

  void _applySettings() async {
    String detectionIp = _detectionServerController.text;
    String storageIp = _storageServerController.text;
    if (Uri
        .parse(detectionIp)
        .isAbsolute && Uri
        .parse(storageIp)
        .isAbsolute) {
      Settings settings = Settings(
          detectionIp: detectionIp, storageIp: storageIp);
      _settingsPresenter.saveSettings(settings);
      _goBack();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => _showDialog()
      );
    }
  }

  void _initLabels() async {
    List<Settings> lista = await _settingsPresenter.readSettings();
    Settings last = lista.last;

    setState(() {
      _detectionLabel = last.detectionIp;
      _storageLabel = last.storageIp;
    });
  }

  Widget _showDialog() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 5),
            const Text('Check the field you have entered'),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _goBack() {
    Navigator.of(context).pop();
  }
}
