import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/transaction/data/model/transaction_model.dart';
import 'package:my_casher/feature/transaction/persentation/bloc/transaction_bloc.dart';

class ModalDetailInvoiceWidget extends StatefulWidget {
  const ModalDetailInvoiceWidget({super.key, required this.invoice_detail});

  final TransactionModel? invoice_detail;

  @override
  State<ModalDetailInvoiceWidget> createState() =>
      _ModalDetailInvoiceWidgetState();
}

class _ModalDetailInvoiceWidgetState extends State<ModalDetailInvoiceWidget> {
  @override
  void initState() {
    super.initState();

    final invoice = widget.invoice_detail;
    if (invoice == null) return;

    context.read<TransactionBloc>().add(ShowTransactionEvent(invoice.id ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final invoiceDetail = state.showTransaction;

        if (invoiceDetail == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final dataItem = invoiceDetail.details ?? [];
        final total = invoiceDetail.total;
        final payment = invoiceDetail.payment;
        final change = invoiceDetail.change;
        final paymentMethod = invoiceDetail.payment_method;

        final text = Theme.of(context).textTheme;
        final color = Theme.of(context).colorScheme;

        return Container(
          height: MediaQuery.of(context).size.height * .88,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(Icons.receipt_long, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Invoice",
                      style: text.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: Theme.of(context).dividerColor),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 1,
                    color: color.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: color.primary,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "TOKO ABADI JAYA",
                                style: text.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Jl. Pasar Baru No.12",
                                style: text.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Telp. 021-5551234",
                                style: text.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _row("No Invoice", invoiceDetail.invoice),
                              _row(
                                "Tanggal",
                                invoiceDetail?.createdAt != null
                                    ? DateFormat(
                                        'dd MMM yyyy',
                                      ).format(invoiceDetail!.createdAt)
                                    : "",
                              ),

                              _row(
                                "Waktu",
                                invoiceDetail?.createdAt != null
                                    ? DateFormat(
                                        'HH:mm',
                                      ).format(invoiceDetail!.createdAt)
                                    : "",
                              ),
                              _row("Kasir", "Admin"),

                              _row(
                                "Metode",
                                paymentMethod == 'cash' ? "Tunai" : "QRIS",
                              ),

                              const Divider(height: 30),

                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Detail Item",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                              const SizedBox(height: 12),

                              ...dataItem.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          width: 52,
                                          height: 52,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          child: Center(
                                            child: Text(item.productIcon),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.productName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "${CurrencyHelper.rupiah(item.price)} x ${item.quantity}",
                                              style: text.bodySmall?.copyWith(
                                                color: color.onSecondary,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Text(
                                        CurrencyHelper.rupiah(item.subtotal),
                                        style: text.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),

                              const Divider(),
                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  const Text(
                                    "TOTAL",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    CurrencyHelper.rupiah(total),
                                    style: text.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: color.primary,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(height: 30),

                              // if (sale.payMethod == "cash") ...[
                              _row(
                                "Uang Diterima",
                                CurrencyHelper.rupiah(payment),
                              ),
                              _row("Kembalian", CurrencyHelper.rupiah(change)),

                              // ] else
                              //   _row("Dibayar via QRIS", fmt(total)),
                              const SizedBox(height: 20),

                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Terima kasih atas kunjungan Anda!",
                                      style: text.bodyLarge?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Barang yang sudah dibeli tidak dapat dikembalikan.",
                                      style: text.bodyLarge?.copyWith(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Tutup Invoice",
                      style: text.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _row(String title, String value) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: text.bodySmall?.copyWith(
                color: color.onSurface.withValues(alpha: .5),
              ),
            ),
          ),
          Text(
            value,
            style: text.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
