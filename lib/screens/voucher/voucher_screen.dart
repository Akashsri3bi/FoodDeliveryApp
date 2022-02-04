import 'package:flutter/material.dart ';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/bloc/basket/basket_bloc.dart';
import 'package:food/bloc/voucher/voucher_bloc.dart';
import 'package:food/models/voucher_model.dart';
import 'package:food/repositories/vouvher/voucher_repository.dart';

class VoucherScreen extends StatelessWidget {
  static const String routeName = "/voucher";

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => VoucherScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Voucher'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: () {},
                child: const Text('Apply'),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Enter a voucher Code',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Voucher Code',
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (value) async {
                    print(await VoucherRepository().searchVoucher(value));
                  },
                )),
              ],
            ),
          ),
          Text(
            'Your Vouchers',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          BlocBuilder<VoucherBloc, VoucherState>(
            builder: (context, state) {
              if (state is VoucherLoading) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is VoucherLoaded) {
                return ListView.builder(
                    itemCount: state.vouchers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10, bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1x',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                state.vouchers[index].code,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<VoucherBloc>().add(SelectVouchers(
                                    voucher: state.vouchers[index]));
                                Navigator.pop(context);
                              },
                              child: const Text('Apply'),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return const Text('Something Went Wrong');
              }
            },
          )
        ]),
      ),
    );
  }
}
