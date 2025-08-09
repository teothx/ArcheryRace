import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archery_race/bloc/game_bloc.dart';
import 'package:archery_race/models/game_models.dart';

class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({Key? key}) : super(key: key);

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numParticipantsController = TextEditingController();
  final _numVolleysController = TextEditingController();
  List<TextEditingController> _nameControllers = [];
  int _setupStep = 0;
  bool _isSoloGame = false;

  @override
  void initState() {
    super.initState();
    _numParticipantsController.text = '2';
    _numVolleysController.text = '4';
  }

  @override
  void dispose() {
    _numParticipantsController.dispose();
    _numVolleysController.dispose();
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeNameControllers(int count) {
    _nameControllers = [];
    for (int i = 0; i < count; i++) {
      _nameControllers.add(TextEditingController(
        text: _isSoloGame ? 'Archer ${i + 1}' : 'Team ${i + 1}',
      ));
    }
  }

  void _submitSetup() {
    if (_formKey.currentState!.validate()) {
      final numParticipants = int.parse(_numParticipantsController.text);
      final numVolleys = int.parse(_numVolleysController.text);
      
      setState(() {
        _setupStep = 1;
        _initializeNameControllers(numParticipants);
      });
    }
  }

  void _submitNames() {
    if (_formKey.currentState!.validate()) {
      final participantNames = _nameControllers.map((c) => c.text).toList();
      final numParticipants = int.parse(_numParticipantsController.text);
      final numVolleys = int.parse(_numVolleysController.text);
      
      context.read<GameBloc>().add(
            SetupGame(
              numParticipants: numParticipants,
              numVolleys: numVolleys,
              participantNames: participantNames,
            ),
          );
      
      Navigator.of(context).pushReplacementNamed('/game');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state is GameSetup) {
                _isSoloGame = state.gameType == GameType.solo;
                return Text('Setup Tournament - ${_getGameTitle(state.gameType)}');
              }
              return const Text('Setup Tournament');
            },
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: _setupStep == 0 ? _buildStep1() : _buildStep2(),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 1: Game Configuration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _numParticipantsController,
          decoration: const InputDecoration(
            labelText: 'Number of Teams/Participants',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.group),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number';
            }
            final number = int.tryParse(value);
            if (number == null || number < 1 || number > 20) {
              return 'Please enter a number between 1 and 20';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _numVolleysController,
          decoration: const InputDecoration(
            labelText: 'Number of Volleys',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.repeat),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number';
            }
            final number = int.tryParse(value);
            if (number == null || number < 2 || number > 10) {
              return 'Please enter a number between 2 and 10';
            }
            if (number % 2 != 0) {
              return 'Please enter an even number';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitSetup,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Confirm'),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _setupStep = 0;
                });
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'Step 2: Enter Names',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _nameControllers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _nameControllers[index],
                  decoration: InputDecoration(
                    labelText: '${_isSoloGame ? "Archer" : "Team"} ${index + 1}',
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(_isSoloGame ? Icons.person : Icons.group),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitNames,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Confirm Names'),
          ),
        ),
      ],
    );
  }

  String _getGameTitle(GameType gameType) {
    switch (gameType) {
      case GameType.duo:
        return 'Duo Challenge';
      case GameType.classica:
        return 'La Classica';
      case GameType.bull:
        return 'Bull\'s Revenge';
      case GameType.impact:
        return 'Red Impact';
      case GameType.solo:
        return '18m Singolo';
    }
  }
}