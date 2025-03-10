import 'package:flutter/material.dart';

class AllTagImKloster extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1); // Updated Color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alltag im Kloster'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alltag im Kloster',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Wie sieht ein Tag im Leben eines Mönchs aus? Diese Frage wird uns immer wieder gestellt, wenn Gruppen uns besuchen. '
              'Die äußere Struktur, der Tagesablauf, ist dabei schnell erzählt. Um seinem tieferen Sinn auf die Spur zu kommen, muss man ihn leben. '
              'Dann entdeckt man: Es geht um nichts weniger als um die Begegnung mit Gott.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildTimelineEvent(
              time: '05.30 Uhr',
              title: 'Vigil',
              description:
                  '„Bleibt hier und wacht“, fordert Jesus seine Jünger auf. '
                  'Dieser Aufforderung wollen wir Mönche Folge leisten, wenn wir uns früh – wenn andere vielleicht noch schlafen – erheben für die Vigil, was übersetzt „Wache“ bedeutet. '
                  'Gegen Ende der Nacht soll auf diese Weise durch unseren Mund das Wort Gottes ertönen – das Wort, durch das die Welt wurde und das alles nun erwachende Leben trägt.',
              isFirst: true,
            ),
            _buildTimelineEvent(
              time: 'Nach der Vigil',
              title: 'Frühstück und Betrachtung',
              description:
                  'Nach der Vigil dürfen die Mönche für leibliche Bedürfnisse hinausgehen, schreibt der hl. Benedikt in seiner Regel. '
                  'Nebst der morgendlichen Toilette gehört dazu auch die leibliche Stärkung für den nun angebrochenen Tag. '
                  'Weil aber der Mensch nicht nur Leib, sondern auch Seele und Geist ist, brauchen auch Letztere eine ihnen gemäße Nahrung.',
            ),
            _buildTimelineEvent(
              time: '07.15 Uhr',
              title: 'Laudes',
              description:
                  'Etwas später am Morgen versammeln sich die Mönche wiederum zum gemeinsamen Gebet im Chor der Kirche. '
                  'Laudes – Gott loben im Gedenken an die Auferstehung, an das Aufgehen des Lichtes über der Dunkelheit des Todes: das ist die Laudes.',
            ),
            _buildTimelineEvent(
              time: '12.00 Uhr',
              title: 'Mittagshore und Mittagessen',
              description:
                  'Am Mittag wird die Sext, das Mittagsgebet, gesprochen. Anschließend versammelt sich die Gemeinschaft zum gemeinsamen Mittagessen.',
            ),
            _buildTimelineEvent(
              time: '18.00 Uhr',
              title: 'Vesper',
              description:
                  'Am Abend versammeln sich die Mönche zur Vesper, dem Abendgebet, um den Tag vor Gott zu beschließen.',
            ),
            _buildTimelineEvent(
              time: '20.00 Uhr',
              title: 'Komplet',
              description:
                  'Bevor die Nacht beginnt, beten die Mönche die Komplet, das Nachtgebet, und verabschieden sich in die Stille der Nacht.',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineEvent({
    required String time,
    required String title,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (!isFirst) Container(height: 20, width: 2, color: primaryColor.withOpacity(0.5)),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                time,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            if (!isLast) Container(height: 40, width: 2, color: primaryColor.withOpacity(0.5)),
          ],
        ),
        SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
