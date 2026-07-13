import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/transaction/data/model/transaction_model.dart';
import 'package:my_casher/feature/transaction/persentation/bloc/transaction_bloc.dart';
import 'package:my_casher/feature/transaction/persentation/widget/list_transaction_widget.dart';

class RecentTransactionBaseWidget extends StatefulWidget {
  const RecentTransactionBaseWidget({
    super.key,
    required this.transactions,
    required this.hasReachedMax,
    required this.isLoading,
    required this.isLoadingMore,
  });

  final List<TransactionModel> transactions;
  final bool hasReachedMax;
  final bool isLoading;
  final bool isLoadingMore;
  @override
  State<RecentTransactionBaseWidget> createState() =>
      _RecentTransactionWidgetState();
}

class _RecentTransactionWidgetState extends State<RecentTransactionBaseWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<TransactionBloc>().add(
      //       const GetTransactionEvent(refresh: true),
      //     );
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final bloc = context.read<TransactionBloc>();
    final state = bloc.state;

    if (state.hasReachedMax || state.isLoadingMore || state.isLoading) {
      return;
    }

    // if (_scrollController.position.pixels >=
    //     _scrollController.position.maxScrollExtent - 200) {
    //   bloc.add(const LoadMoreTransactionEvent());
    // }
  }

  Future<void> _onRefresh() async {
    context.read<TransactionBloc>().add(const GetTransactionEvent());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.only(bottom: 16),
          child: Text(
            "Transaksi Terakhir",
            style: text.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black.withValues(alpha: .7),
            ),
          ),
        ),
        Expanded(
          child: CustomRefreshIndicator(
            onRefresh: _onRefresh,
            offsetToArmed: 70,
            builder: (context, child, controller) {
              return Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, controller.value * 70),
                    child: child,
                  ),

                  if (controller.value > 0)
                    Positioned(
                      top: 16,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(.08),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              value: controller.isLoading
                                  ? null
                                  : controller.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
            child: TransactionListWidget(
              controller: _scrollController,
              transactions: widget.transactions,
              hasReachedMax: widget.hasReachedMax,
              isLoading: widget.isLoading,
              isLoadingMore: widget.isLoadingMore,
            ),
          ),
        ),
      ],
    );
  }
}
