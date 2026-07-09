import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrisCardWidget extends StatelessWidget {
  const QrisCardWidget({
    super.key,
    required this.qrData,
    required this.merchantName,
    required this.merchantId,
  });

  final String qrData;
  final String merchantName;
  final String merchantId;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "QRIS",
                      style: TextStyle(
                        color: Color(0xffE3232C),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Scan to Pay",
                      style: text.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xffE3232C),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-8, 0),
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Color(0xffF79E1B),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// QR
            Stack(
              alignment: Alignment.center,
              children: [
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 190,
                  backgroundColor: Colors.white,
                ),

                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .08),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.qr_code_scanner_rounded, size: 24),
                ),
              ],
            ),

            const SizedBox(height: 22),

            /// Merchant
            Text(
              merchantName,
              style: text.titleMedium?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "ID : $merchantId",
              style: text.bodySmall?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 22),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: const [
                _PaymentChip("GoPay"),
                _PaymentChip("OVO"),
                _PaymentChip("DANA"),
                _PaymentChip("ShopeePay"),
                _PaymentChip("LinkAja"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentChip extends StatelessWidget {
  const _PaymentChip(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
