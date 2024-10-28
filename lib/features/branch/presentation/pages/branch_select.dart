import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';
import 'package:flutter_base_v2/features/branch/data/repositories/branch_repo.dart';

class BranchSelectPage extends StatefulWidget {
  final void Function(Branch branch) onBranchSelected;

  const BranchSelectPage({super.key, required this.onBranchSelected});

  @override
  BranchSelectPageState createState() => BranchSelectPageState();
}

class BranchSelectPageState extends State<BranchSelectPage> {
  List<Branch>? _branches;
  bool _isLoading = false;
  String? _error;
  Branch? _selectedBranch;

  Future<void> _callApi() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final branchRepo = Get.find<BranchRepo>();
      List<Branch>? branches = await branchRepo.getListBrands();
      setState(() {
        _branches = branches;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error calling API: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 45),
          const Center(
            child: Text(
              'Chọn chi nhánh',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!))
                    : _branches == null
                        ? Center(child: Text('No branches found'))
                        : ListView.builder(
                            itemCount: _branches!.length,
                            itemBuilder: (context, index) {
                              final branch = _branches![index];
                              return ListTile(
                                title: Text(branch.name),
                                subtitle: branch.description != ""
                                    ? Text(
                                        branch.description,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      )
                                    : null,
                                trailing: Radio<Branch>(
                                  value: branch,
                                  groupValue: _selectedBranch,
                                  onChanged: (Branch? value) {
                                    setState(() {
                                      _selectedBranch = value;
                                    });
                                  },
                                  activeColor: Color.fromRGBO(66, 63, 255, 1),
                                ),
                              );
                            },
                          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: _selectedBranch != null
                  ? () {
                      widget.onBranchSelected(_selectedBranch!);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                backgroundColor: Color.fromRGBO(66, 63, 255, 1),
              ),
              child: const Text(
                'Tiếp tục',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
