import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrinklyze_6/providers/face_scan_result_provider.dart';

class FaceScanResultPage extends ConsumerWidget {
  final String skinType;
  final double confidence;
  final List<dynamic> probabilities;
  final String imagePath;
  final String title;

  const FaceScanResultPage({
    super.key,
    required this.skinType,
    required this.confidence,
    required this.probabilities,
    required this.imagePath,
    required this.title,
  });

  Future<void> _showPredictionDialog(BuildContext context) {
    String dialogTitle = 'Skin Type: $skinType';
    String content =
        'Confidence: ${confidence.toStringAsFixed(2)}\n\nProbabilities: ${probabilities.toString()}';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(dialogTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 20)),
          content: SingleChildScrollView(
            child: Text(content, style: const TextStyle(fontFamily: 'Poppins')),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        );
      },
    );

    return Future.value();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(faceScanResultProvider.notifier)
          .setFaceScanResult(FaceScanResult(
            skinType: skinType,
            confidence: confidence,
            probabilities: probabilities,
            imagePath: imagePath,
            title: title,
          ));
      _showPredictionDialog(context);
    });

    String description = '';
    String displayTitle = title;

    switch (skinType) {
      case 'wrinkle_ringan':
        displayTitle = 'Wrinkles in Motion (Kerutan Ringan)';
        description = '''
**Pengertian**
Kerutan hanya muncul saat otot wajah bergerak, biasanya di area yang sering digunakan seperti sekitar mata dan mulut.

**Klasifikasi**
• Photoaging sedang
• Mulai muncul bercak hitam (hiperpigmentasi)
• Adanya tumor kulit awal namun tidak tampak secara kasat mata
• Garis senyum paralel mulai muncul di sisi lateral wajah

**Solusi**
• Pemakaian krim anti-aging yang mengandung tretinoin atau asam alfa hidroksi untuk mengurangi garis halus dan meningkatkan pergantian sel kulit.
• Chemical peeling ringan untuk memperbaiki tekstur kulit dan mengurangi perubahan warna.
• Perawatan kulit rutin dengan pelembab dan tabir surya untuk mencegah kerusakan lebih lanjut akibat sinar UV.
• Perawatan laser atau IPL untuk mengatasi hiperpigmentasi dan memperbaiki struktur kulit.
        ''';
        break;
      case 'wrinkle_sedang':
        displayTitle = 'Wrinkles at Rest (Kerutan Sedang)';
        description = '''
**Pengertian**
Kerutan tetap terlihat meskipun wajah dalam keadaan rileks, menunjukkan penuaan yang lebih lanjut.

**Klasifikasi**
• Photoaging berat
• Diskromia nyata, telangiectasis (pelebaran pembuluh darah kecil)
• Adanya tumor kulit seperti keratosis
• Kerut persisten dan dalam

**Solusi**
• Tindakan medis lebih intensif seperti mikrodermabrasi atau laser resurfacing untuk menghilangkan lapisan atas kulit dan merangsang produksi kolagen.
• Botox atau filler kulit untuk mengatasi kerutan dalam yang tidak hilang dengan krim topikal.
• Pemakaian krim tretinoin atau retinoid kuat untuk meningkatkan regenerasi kulit dan mengurangi tampilan kerutan.
• Pemeriksaan rutin ke dokter kulit untuk menangani tumor kulit dan melakukan tindakan pencegahan kanker kulit.
        ''';
        break;
      case 'wrinkle_berat':
        displayTitle = 'Only Wrinkles (Kerutan Berat)';
        description = '''
**Pengertian**
Kulit penuh dengan kerutan, bahkan di area yang jarang digunakan untuk ekspresi. Hampir seluruh area wajah menunjukkan tanda penuaan.

**Klasifikasi**
• Photoaging sangat berat
• Kulit kuning-keabuan
• Adanya tumor kulit ganas
• Hampir tidak ada kulit normal yang tersisa

**Solusi**
• Pembedahan kosmetik seperti facelift atau browlift untuk memperbaiki kulit yang sangat kendur dan kerut dalam.
• Perawatan laser intensif untuk meremajakan kulit dan mengatasi hiperpigmentasi dan kerusakan berat akibat sinar matahari.
• Konsultasi dengan ahli bedah plastik untuk penanganan tumor kulit ganas.
• Penggunaan krim anti-aging yang kuat serta pengobatan sistemik seperti hormon replacement therapy jika diperlukan.
        ''';
        break;
      default:
        displayTitle = 'Unknown Skin Type';
        description = 'No information available for this skin type.';
    }

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Face Scan Result', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins'),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Poppins'),
                        children: _buildDescriptionText(description),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => ref
                          .read(faceScanResultProvider.notifier)
                          .saveToFirestore(context),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff052135),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Save Information",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildDescriptionText(String description) {
    List<TextSpan> spans = [];
    List<String> lines = description.split('\n');

    for (String line in lines) {
      if (line.startsWith('**') && line.endsWith('**')) {
        spans.add(TextSpan(
          text: line.replaceAll('**', ''),
          style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ));
      } else {
        spans
            .add(TextSpan(text: line, style: const TextStyle(fontFamily: 'Poppins')));
      }
      spans.add(const TextSpan(text: '\n'));
    }

    return spans;
  }
}
