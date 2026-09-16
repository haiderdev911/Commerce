import 'package:flutter/material.dart';
import 'scorecard_screen.dart';

class ScoringScreen extends StatefulWidget {
  final String teamName;
  final String batsman1Name;
  final String batsman2Name;
  final String bowlerName;

  const ScoringScreen({
    super.key,
    required this.teamName,
    required this.batsman1Name,
    required this.batsman2Name,
    required this.bowlerName,
  });

  @override
  State<ScoringScreen> createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  // -------------------------
  // MATCH SCORE
  // -------------------------

  int totalRuns = 0;

  int wickets = 0;

  int balls = 0;

  // -------------------------
  // BATSMAN 1
  // -------------------------

  late String batsman1;

  int batsman1Runs = 0;

  int batsman1Balls = 0;

  int batsman1Fours = 0;

  int batsman1Sixes = 0;

  bool batsman1Out = false;

  // -------------------------
  // BATSMAN 2
  // -------------------------

  late String batsman2;

  int batsman2Runs = 0;

  int batsman2Balls = 0;

  int batsman2Fours = 0;

  int batsman2Sixes = 0;

  bool batsman2Out = false;

  // -------------------------
  // STRIKER
  // -------------------------

  bool batsman1OnStrike = true;

  @override
  void initState() {
    super.initState();

    batsman1 = widget.batsman1Name;

    batsman2 = widget.batsman2Name;
  }

  // Current overs
  String get currentOvers {
    return '${balls ~/ 6}.${balls % 6}';
  }

  // Current striker
  String get strikerName {
    return batsman1OnStrike ? batsman1 : batsman2;
  }

  // Current striker runs
  int get strikerRuns {
    return batsman1OnStrike ? batsman1Runs : batsman2Runs;
  }

  // Add runs
  void addRuns(int runs) {
    setState(() {
      totalRuns += runs;

      balls++;

      if (batsman1OnStrike) {
        batsman1Runs += runs;

        batsman1Balls++;

        if (runs == 4) {
          batsman1Fours++;
        }

        if (runs == 6) {
          batsman1Sixes++;
        }
      } else {
        batsman2Runs += runs;

        batsman2Balls++;

        if (runs == 4) {
          batsman2Fours++;
        }

        if (runs == 6) {
          batsman2Sixes++;
        }
      }

      // Odd runs change strike
      if (runs == 1 || runs == 3) {
        batsman1OnStrike = !batsman1OnStrike;
      }

      // End of over changes strike
      if (balls % 6 == 0) {
        batsman1OnStrike = !batsman1OnStrike;
      }
    });
  }

  // Add wicket
  void addWicket() {
    setState(() {
      wickets++;

      balls++;

      if (batsman1OnStrike) {
        batsman1Out = true;

        batsman1Balls++;

        batsman1 = 'New Batsman';
      } else {
        batsman2Out = true;

        batsman2Balls++;

        batsman2 = 'New Batsman';
      }

      // Change strike
      batsman1OnStrike = !batsman1OnStrike;
    });
  }

  // Open scorecard
  void openScorecard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScorecardScreen(
          teamName: widget.teamName,

          totalRuns: totalRuns,

          wickets: wickets,

          overs: currentOvers,

          batsman1: batsman1,

          batsman1Runs: batsman1Runs,

          batsman1Balls: batsman1Balls,

          batsman1Fours: batsman1Fours,

          batsman1Sixes: batsman1Sixes,

          batsman1Out: batsman1Out,

          batsman2: batsman2,

          batsman2Runs: batsman2Runs,

          batsman2Balls: batsman2Balls,

          batsman2Fours: batsman2Fours,

          batsman2Sixes: batsman2Sixes,

          batsman2Out: batsman2Out,

          bowler: widget.bowlerName,
        ),
      ),
    );
  }

  // Player card
  Widget playerCard({
    required String name,
    required int runs,
    required int balls,
    required bool striker,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
                  striker ? Colors.redAccent : Colors.grey.shade300,

              child: Icon(
                Icons.person,
                color: striker ? Colors.white : Colors.black54,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (striker)
                        const Text(
                          '  *',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '$runs runs • $balls balls',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              '$runs',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget runButton(int runs) {
    return SizedBox(
      width: 75,
      height: 55,

      child: ElevatedButton(
        onPressed: () {
          addRuns(runs);
        },

        child: Text(
          '$runs',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Scoring'),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: openScorecard,
            icon: const Icon(Icons.scoreboard),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // -------------------------
            // SCORE HEADER
            // -------------------------

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  Text(
                    widget.teamName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$totalRuns / $wickets',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Overs $currentOvers',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // BATSMEN
            // -------------------------

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Batting',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            playerCard(
              name: batsman1,
              runs: batsman1Runs,
              balls: batsman1Balls,
              striker: batsman1OnStrike,
            ),

            playerCard(
              name: batsman2,
              runs: batsman2Runs,
              balls: batsman2Balls,
              striker: !batsman1OnStrike,
            ),

            // -------------------------
            // BOWLER
            // -------------------------

            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),

                child: Row(
                  children: [
                    const Icon(
                      Icons.sports_cricket,
                      color: Colors.green,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        'Bowler: ${widget.bowlerName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      currentOvers,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // RUNS
            // -------------------------

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Add Runs',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,

              children: [
                runButton(0),
                runButton(1),
                runButton(2),
                runButton(3),
                runButton(4),
                runButton(6),
              ],
            ),

            const SizedBox(height: 20),

            // -------------------------
            // WICKET + UNDO
            // -------------------------

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: addWicket,

                    icon: const Icon(Icons.close),

                    label: const Text('Wicket'),

                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      minimumSize: const Size(0, 52),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Undo feature can be added using score history.',
                          ),
                        ),
                      );
                    },

                    icon: const Icon(Icons.undo),

                    label: const Text('Undo'),

                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 52),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // -------------------------
            // SCORECARD BUTTON
            // -------------------------

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(
                onPressed: openScorecard,

                icon: const Icon(Icons.scoreboard),

                label: const Text(
                  'View Scorecard',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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