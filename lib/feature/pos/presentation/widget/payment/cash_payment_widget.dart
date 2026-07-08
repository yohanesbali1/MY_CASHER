import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/shared/widget/form/form_widget.dart';
import 'package:my_casher/shared/widget/modal/confirmation_modal.dart';

class CashPaymentWidget extends StatefulWidget {
  const CashPaymentWidget({super.key, required this.total});

  final double total;

  @override
  State<CashPaymentWidget> createState() => _CashPaymentWidgetState();
}

class _CashPaymentWidgetState extends State<CashPaymentWidget> {
  late final TextEditingController _priceController;

  late double _cash;

  @override
  void initState() {
    super.initState();

    _cash = 0;
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    final change = _cash - widget.total;
    final enough = _cash >= widget.total;

    return BlocConsumer<PosBloc, PosState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == PosStatus.success) {
          _priceController.clear();
          context.go(
            '/payment-success',
            extra: {'isCash': true, 'change': change},
          );
        }
        if (state.status == PosStatus.error) {}
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              hintText: 'Masukkan nominal uang',
              prefixIcon: Icon(
                Icons.monetization_on_outlined,
                color: Colors.black.withValues(alpha: .5),
              ),
              onChanged: (value) {
                setState(() {
                  _cash = double.tryParse(value) ?? 0;
                });
              },
            ),

            const SizedBox(height: 12),

            if (_cash > 0 && !enough)
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.red,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Uang tidak cukup",
                    style: text.bodySmall?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

            if (_cash > 0 && enough)
              Row(
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "Kembalian ${CurrencyHelper.rupiah(change)}",
                    style: text.bodySmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: enough
                      ? () => {
                          showConfirmBottomSheet(
                            context,
                            title: 'Konfirmasi Pembayaran Tunai',
                            message:
                                'Apakah Anda yakin ingin untuk melakukan pembayaran tunai?',
                            danger: false,
                            onConfirm: () async {
                              context.read<PosBloc>().add(
                                SubmitPayment(cash: _cash),
                              );
                            },
                          ),
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.green.withValues(alpha: 1),
                  ),
                  child: Text(
                    "Bayar ${CurrencyHelper.rupiah(widget.total)}",
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
