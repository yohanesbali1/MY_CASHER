import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/qris/qris_amount_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/qris/qris_card_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/qris/qris_summary_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/qris/qris_waiting_widget.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';
import 'package:my_casher/shared/widget/modal/confirmation_modal.dart';

class QrisPaymentPage extends StatelessWidget {
  const QrisPaymentPage({
    super.key,
    required this.cart,
    required this.total,
    required this.totalItem,
  });

  final List<CartItemModel> cart;
  final double total;
  final int totalItem;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PosBloc, PosState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == PosStatus.success) {
          context.go(
            '/pos/payment-success',
            extra: {'isCash': false, 'change': 0.0},
          );
        }
        if (state.status == PosStatus.error) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const AppAppBar(
            title: 'Bayar via QRIS',
            showBackButton: true,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          QrisAmountWidget(total: total, totalItem: totalItem),

                          const SizedBox(height: 20),

                          QrisCardWidget(
                            qrData: "uhuy",
                            merchantName: "TOKO ABADI JAYA",
                            merchantId: "9360014672845001",
                          ),

                          const SizedBox(height: 18),

                          const QrisWaitingWidget(),

                          const SizedBox(height: 18),

                          QrisSummaryWidget(cart: cart, total: total),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: FilledButton.icon(
                onPressed: () {
                  showConfirmBottomSheet(
                    context,
                    title: 'Konfirmasi Pembayaran Tunai',
                    message:
                        'Pastikan pembayaran QRIS sebesar ${CurrencyHelper.rupiah(total)} sudah diterima sebelum melanjutkan.?',
                    danger: false,
                    onConfirm: () async {
                      context.read<PosBloc>().add(
                        SubmitPayment(cash: total, change: 0.0),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text("Konfirmasi Sudah Dibayar"),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
