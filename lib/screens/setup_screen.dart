import 'package:flutter/material.dart';
import 'scoring_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final teamController = TextEditingController();

  final batsman1Controller = TextEditingController();

  final batsman2Controller = TextEditingController();

  final bowlerController = TextEditingController();

  @override
  void dispose() {
    teamController.dispose();
    batsman1Controller.dispose();
    batsman2Controller.dispose();
    bowlerController.dispose();

    super.dispose();
  }

  void startMatch() {
    
    if (teamController.text.trim().isEmpty ||
        batsman1Controller.text.trim().isEmpty ||
        batsman2Controller.text.trim().isEmpty ||
        bowlerController.text.trim().isEmpty) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );

      return;
    }

    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoringScreen(
          teamName: teamController.text.trim(),
          batsman1Name: batsman1Controller.text.trim(),
          batsman2Name: batsman2Controller.text.trim(),
          bowlerName: bowlerController.text.trim(),
        ),
      ),
    );
  }

  Widget inputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: TextField(
        controller: controller,

        decoration: InputDecoration(
          labelText: label,

          prefixIcon: Icon(icon),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Setup'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Create New Match',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Enter the match details below.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            inputField(
              label: 'Team Name',
              icon: Icons.groups,
              controller: teamController,
            ),

            inputField(
              label: 'Opening Batsman',
              icon: Icons.person,
              controller: batsman1Controller,
            ),

            inputField(
              label: 'Second Batsman',
              icon: Icons.person_outline,
              controller: batsman2Controller,
            ),

            inputField(
              label: 'Bowler',
              icon: Icons.sports_cricket,
              controller: bowlerController,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: startMatch,

                icon: const Icon(
                  Icons.play_arrow,
                ),

                label: const Text(
                  'Start Scoring',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}