import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/payment.dart';
import 'widgets/deposit_appbar.dart';
import 'widgets/deposit_card.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: const DepositAppBar(),
        body: TabBarView(
          children: [
            _buildRequestsList('pending'),
            _buildRequestsList('approved'),
            _buildRequestsList('rejected'),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList(String status) {
    return StreamBuilder(
      stream: getDepositRequests(status),
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
            return DepositCard(
              imageUrl: request['proofImageUrl'],
              dollarsAmount: request['dollarsAmount'],
              iraqiDinarAmount: request['iraqiDinarAmount'],
              userId: request['userId'],
              status: request['status'],
              invitationCode: request['invitationCode'],
              isUSDT: request['isUSDT'],
              onReject: () => updateDepositRequestStatus(request.id, 'rejected'),
              onDelete: () => deleteRequest(request.id),
              onUndoReject: () => updateDepositRequestStatus(request.id, 'pending'),
              onApprove: () => updateApprovedDepositRequest(
                request.id,
                'approved',
                request['userId'],
                request['dollarsAmount'],
              ),
            );
          },
        );
      },
    );
  }
}

