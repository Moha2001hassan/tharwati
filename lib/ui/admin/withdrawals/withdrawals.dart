import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/payment.dart';
import 'widgets/withdraw_appbar.dart';
import 'widgets/withdraw_card.dart';

class WithdrawalsScreen extends StatelessWidget {
  const WithdrawalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: const WithdrawAppbar(),
        body: TabBarView(
          children: [
            _buildRequestsList('pending'),
            _buildRequestsList('approved'),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList(String status) {
    return StreamBuilder(
      stream: getWithdrawRequests(status),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No $status requests'));
        }

        final requests = snapshot.data!.docs;

        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (ctx, index) {
            final request = requests[index];
            return WithdrawCard(
              dollarsAmount: request['dollarsAmount'],
              isUSDT: request['isUSDT'],
              status: request['status'],
              userId: request['userId'],
              wallet: request['wallet'],
              invitationCode: request['invitationCode'],
              onDelete: () => deleteRequest(request.id),
              onApprove: () => updateWithdrawRequestStatus(request.id, 'approved'),
            );
          },
        );
      },
    );
  }
}
