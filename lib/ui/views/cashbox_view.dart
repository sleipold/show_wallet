import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:showwallet/ui/shared/ui_helpers.dart';
import 'package:showwallet/ui/widgets/expansion_list.dart';
import 'package:showwallet/ui/widgets/input_field.dart';
import 'package:showwallet/viewmodels/cashbox_view_model.dart';

class CashboxView extends StatelessWidget {
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CashboxViewModel>.withConsumer(
        viewModel: CashboxViewModel(),
        onModelReady: (model) => model.listenToTeams(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                color: Colors.blue,
                margin: EdgeInsets.all(24),
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${model.currentTeam.name}',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Balance',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '${model.currentTeam.balance} €',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Your Debt',
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${model.currentDebt.value} €',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            onPressed: () {}, //TODO: add logic
                            child: Text('Pay', style: TextStyle(fontSize: 15)),
                            color: Colors.lightGreen,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ExpansionList<String>(
                            items: ['Simon', 'Tom'],
                            title: 'Choose Member',
                            onItemSelected: null,
                          ),
                        ),
                        horizontalSpaceSmall,
                        Expanded(
                          flex: 1,
                          child: ExpansionList<String>(
                            items: ['too late', 'chewing gum'],
                            title: 'Choose Fine',
                            onItemSelected: null,
                          ),
                        )
                      ],
                    ),
                    verticalSpaceSmall,
                    InputField(
                        controller: commentController, placeholder: 'Comment'),
                    RaisedButton(
                      onPressed: () {}, //TODO: add logic
                      child: Text('Add Fine', style: TextStyle(fontSize: 15)),
                      color: Colors.redAccent,
                    )
                  ],
                ),
              ),
            ));
  }
}
