import 'dart:async';

import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:doctor_appointment/common/colors.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

import 'package:audio_wave/audio_wave.dart';

class PlayIcon extends StatefulWidget {
//   int initialvalue;
// PlayIcon(this.initialvalue);

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<PlayIcon> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: SafeArea(
          child: new RecorderExample(),
        ),
      ),
    );
  }
}

class RecorderExample extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  RecorderExample({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StatefulWidget> createState() => new RecorderExampleState();
}

class RecorderExampleState extends State<RecorderExample>
// with SingleTickerProviderStateMixin
{
  // AnimationController _animationController;
  // bool isPlaying = false;

  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool viewVisible =false;
  // void showWave()
  // {
  //   setState(() {
  //     viewVisible =true;
  //   });
  // }
  // void hideWave()
  // {
  //   setState(() {
  //     viewVisible = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _init();
  }


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Audio recording : ${_current?.duration.toString()}"),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Save for Later",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: DoctorColors.Dblue,
                            fontSize: 20),
                      ))
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(child:
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,

                  child: AudioWave(
                    height:150,
                    width: 350,
                    spacing: 2.5,
                    bars: [
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.blue),
                      AudioWaveBar(height: 70, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40),
                      AudioWaveBar(height: 20, color: Colors.orange),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.blue),
                      AudioWaveBar(height: 70, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40),
                      AudioWaveBar(height: 20, color: Colors.orange),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.blue),
                      AudioWaveBar(height: 70, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40),
                      AudioWaveBar(height: 20, color: Colors.orange),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.blue),
                      AudioWaveBar(height: 70, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40),
                      AudioWaveBar(height: 20, color: Colors.orange),
                    ],
                  ),
                ),

                ),
              ],),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        // new FlatButton(onPressed:
                        // _currentStatus != RecordingStatus.Unset ? _stop : null,
                        //   child: CircleAvatar(child: Icon( Icons.play_arrow_outlined,
                        //     size: 40,),radius: 40,),
                        // ),

                         FlatButton(
                      onPressed: () {
                        switch (_currentStatus) {
                          case RecordingStatus.Initialized:
                            {
                              _start();
                              // AudioWave();
                              break;
                            }
                          case RecordingStatus.Recording:
                            {
                              _pause();
                              break;
                            }
                          case RecordingStatus.Paused:
                            {
                              _resume();
                              // AudioWave();
                              break;
                            }
                          case RecordingStatus.Stopped:
                            {
                              _init();
                              break;
                            }
                          default:
                            break;
                        }
                      },
                      child: CircleAvatar(
                        child: _buildText(_currentStatus),
                        radius: 40,
                      ),
                      // child: Container(
                      //   height: 50,
                      //   width: 50,
                      //   decoration: BoxDecoration(
                      //     color: Colors.blueAccent.withOpacity(0.5),
                      //     borderRadius: BorderRadius.circular(50),
                      //   ),
                      //   child: Icon(Icons.play_arrow_outlined,color: Colors.white),
                    ),
                  ),
                   FlatButton(
                    onPressed:
                        _currentStatus != RecordingStatus.Unset ? _stop : null,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.stop_circle_outlined,
                        size: 40,
                      ),
                      radius: 40,
                    ),
                    // IconButton(
                    //   iconSize: 60,
                    //   splashColor: Colors.pinkAccent,
                    //   icon: AnimatedIcon(                   /// AnimatedIcon Widget and its properties
                    //     icon: AnimatedIcons.menu_arrow,
                    //     progress: _animationController,
                    //     color: Colors.purple[900],
                    //   ),
                    //   onPressed: () => _OnPressed(), /// calling  onpressed method
                    // ),
                    // new Text("Stop", style: TextStyle(color: Colors.white)),
                    // color: Colors.blueAccent.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                   FlatButton(
                    onPressed:
                        _currentStatus != RecordingStatus.Unset ? _stop : null,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 40,
                      ),
                      radius: 40,
                    ),

                    // onPressed: onPlayAudio,
                    // child:
                    // new Text("Play", style: TextStyle(color: Colors.white)),
                    // color: Colors.blueAccent.withOpacity(0.5),
                  ),
                ],
              ),
              // new Text("Status : $_currentStatus"),
              // new Text('Avg Power: ${_current?.metering?.averagePower}'),
              // new Text('Peak Power: ${_current?.metering?.peakPower}'),
              // new Text("File path of the record: ${_current?.path}"),
              // new Text("Format: ${_current?.audioFormat}"),
              // new Text(
              //     "isMeteringEnabled: ${_current?.metering?.isMeteringEnabled}"),
              // new Text("Extension : ${_current?.extension}"),
              // new Text(
              //     "Audio recording duration : ${_current?.duration.toString()}")
            ]),
      ),
    );
  }
  // void _OnPressed() {
  //   setState(() { /// checking for condition hear is playing is false or true
  //     isPlaying = !isPlaying;
  //     isPlaying
  //         ? _animationController.forward()
  //         : _animationController.reverse();
  //   });
  // }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        viewVisible=true;
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder.resume();
    setState(() {
      viewVisible=true;
    });
  }

  _pause() async {
    await _recorder.pause();
    setState(() {
      viewVisible=false;
    });
  }

  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = widget.localFileSystem.file(result.path);
    print("File length: ${await file.length()}");
    setState(() {
      viewVisible=false;
      _current = result;
      _currentStatus = _current.status;
    });
  }

  Widget _buildText(RecordingStatus status) {
    var icon ;
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          icon = Icons.stop_circle;
          break;
        }
      case RecordingStatus.Recording:
        {
          icon = Icons.play_circle_fill;
          break;
        }
      case RecordingStatus.Paused:
        {
          icon = Icons.play_arrow_outlined;
          break;
        }
      case RecordingStatus.Stopped:
        {
          icon = Icons.stop_circle;
          break;
        }
      default:
        break;
    }
    return Icon(icon, color: Colors.white);
  }


  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current.path, isLocal: true);
  }
}
