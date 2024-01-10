import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:openvpn/data/local/app_db.dart';
import 'package:openvpn/di/components/app_component.dart';
import 'package:openvpn/domain/model/history/history_model.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/widget/impl/app_body_text.dart';
import 'package:openvpn/presentations/widget/impl/app_title_text.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/utils/extension/date_extension.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().fetchHistoryList();
    });
  }

  void _refreshListView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isHistoryNotEmpty = false;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const AppTitleText(
          text: 'History',
          color: Colors.black,
        ),
        actions: [
          TextButton(
            child: isHistoryNotEmpty == true
                ? Assets.icons.icCrown.svg()
                : const Icon(Icons.delete, color: Colors.black),
            onPressed: () {
              if (isHistoryNotEmpty == true) {
                _deleteAllConfirmationDialog();
              } else {
                EasyLoading.showToast('History connection list is empty');
              }
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.histories.isNotEmpty) {
              isHistoryNotEmpty = true;
            } else {
              isHistoryNotEmpty = false;
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: state.histories.isEmpty,
                  child: const Column(
                    children: [
                      SizedBox(height: 150),
                      SizedBox(height: 16),
                      Align(
                        child: AppBodyText(
                          text: "Server history is currently empty!",
                          size: 20,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // SizedBox(
                      //     width: 80,
                      //     height: 80,
                      //     child: Cstmgradient(
                      //       color: AppColors.listgradient,
                      //       child: Icon(
                      //         Icons.hide_source,
                      //         size: 50,
                      //       ),
                      //     )),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Visibility(
                  visible: state.histories.isNotEmpty,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 1,
                            childAspectRatio: 1,
                            mainAxisExtent: 120),
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final history = state.histories[index];
                      return _buildHistoryItem(history);
                    },
                    itemCount: state.histories.length,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteAllConfirmationDialog() async {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(vertical: 320, horizontal: 40),
          height: 100,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Clean History',
                ),
                const Text(
                  'Would you like to remove everything ?',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey),
                      child: Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xff5cffd1)),
                      child: TextButton(
                          onPressed: () {
                            getIt<AppDatabase>().deleteAllHistories(() {
                              _refreshListView();
                              if (!context.mounted) return;
                              // Navigator.of(context).popUntil((route) => route.isFirst);
                              EasyLoading.showToast(
                                  'All History connection is deleted');
                              // Future.delayed(Duration(seconds: 2), () {
                              //   setState(() {
                              //     //return _refreshListView();
                              //   });
                              // });
                              context.read<AppCubit>().fetchHistoryList();
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                    ),
                  ],
                )
              ]),
        );
      },
    );
  }

  Widget _buildHistoryItem(HistoryModel history) {
    final server = history.vpnServerModel;
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 4, spreadRadius: 40, color: Colors.black)
                ]),
                child: Image.asset(
                  fit: BoxFit.cover,
                  server.flag,
                  width: 35,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBodyText(
                color: Colors.black,
                text: server.country ?? '',
              ),
            ],
          ),
          AppBodyText(
            text: history.createAt.toStringFormatted(),
            size: 12,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
