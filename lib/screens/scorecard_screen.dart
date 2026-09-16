import 'package:flutter/material.dart';

class ScorecardScreen extends StatelessWidget {
  final String teamName;

  final int totalRuns;

  final int wickets;

  final String overs;

  final String batsman1;

  final int batsman1Runs;

  final int batsman1Balls;

  final int batsman1Fours;

  final int batsman1Sixes;

  final bool batsman1Out;

  final String batsman2;

  final int batsman2Runs;

  final int batsman2Balls;

  final int batsman2Fours;

  final int batsman2Sixes;

  final bool batsman2Out;

  final String bowler;

  const ScorecardScreen({
    super.key,

    required this.teamName,

    required this.totalRuns,

    required this.wickets,

    required this.overs,

    required this.batsman1,

    required this.batsman1Runs,

    required this.batsman1Balls,

    required this.batsman1Fours,

    required this.batsman1Sixes,

    required this.batsman1Out,

    required this.batsman2,

    required this.batsman2Runs,

    required this.batsman2Balls,

    required this.batsman2Fours,

    required this.batsman2Sixes,

    required this.batsman2Out,

    required this.bowler,
  });

  Widget batsmanRow({
    required String name,
    required int runs,
    required int balls,
    required int fours,
    required int sixes,
    required bool out,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Row(
          children: [
            Expanded(
              flex: 2,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    out ? 'Out' : 'Not Out',
                    style: TextStyle(
                      color: out ? Colors.red : Colors.green,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text(
                    'R',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    '$runs',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text(
                    'B',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    '$balls',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text(
                    '4s',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    '$fours',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  const Text(
                    '6s',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    '$sixes',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scorecard'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // -------------------------
            // SCORE
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
                    teamName,
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Overs: $overs',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // -------------------------
            // BATTING TITLE
            // -------------------------

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Batting',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Table Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Batsman',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          'R',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          'B',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          '4s',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          '6s',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            batsmanRow(
              name: batsman1,
              runs: batsman1Runs,
              balls: batsman1Balls,
              fours: batsman1Fours,
              sixes: batsman1Sixes,
              out: batsman1Out,
            ),

            batsmanRow(
              name: batsman2,
              runs: batsman2Runs,
              balls: batsman2Balls,
              fours: batsman2Fours,
              sixes: batsman2Sixes,
              out: batsman2Out,
            ),

            const SizedBox(height: 15),

            // -------------------------
            // BOWLER
            // -------------------------

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Bowling',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,

                      child: Icon(
                        Icons.sports_cricket,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        bowler,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    Text(
                      overs,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // -------------------------
            // BACK BUTTON
            // -------------------------

            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),

                label: const Text(
                  'Back to Scoring',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}