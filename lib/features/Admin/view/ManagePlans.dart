// ignore_for_file: use_build_context_synchronously

import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Admin/cubit/admin_cubit.dart';
import 'package:diety/features/Admin/cubit/admin_state.dart';
import 'package:diety/features/Admin/view/DeletePlanes.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ManagePlane extends StatelessWidget {
  const ManagePlane({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: const _ManagePlaneView(),
    );
  }
}

class _ManagePlaneView extends StatefulWidget {
  const _ManagePlaneView();

  @override
  State<_ManagePlaneView> createState() => _ManagePlaneViewState();
}

class _ManagePlaneViewState extends State<_ManagePlaneView> {
  final _collectionController = TextEditingController();
  final _docController = TextEditingController();
  final _fieldController = TextEditingController();
  final _mapKeyController = TextEditingController();
  final _mapValueController = TextEditingController();

  @override
  void dispose() {
    _collectionController.dispose();
    _docController.dispose();
    _fieldController.dispose();
    _mapKeyController.dispose();
    _mapValueController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _collectionController.clear();
    _docController.clear();
    _fieldController.clear();
    _mapKeyController.clear();
    _mapValueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Manage Plans',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.bold)),
            const Gap(5),
            Icon(Icons.admin_panel_settings_outlined,
                color: AppColors.white, size: 30),
          ],
        ),
      ),
      body: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green),
            );
            _clearFields();
          } else if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(10),
                textFormField(
                  keyboardType: TextInputType.text,
                  labelText: 'Collection Name',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                  mycontroller: _collectionController,
                ),
                const Gap(15),
                textFormField(
                  keyboardType: TextInputType.text,
                  labelText: 'Document Name',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                  mycontroller: _docController,
                ),
                const Gap(15),
                textFormField(
                  keyboardType: TextInputType.text,
                  labelText: 'Field Name',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                  mycontroller: _fieldController,
                ),
                const Gap(10),
                textFormField(
                  keyboardType: TextInputType.text,
                  labelText: 'Map Key',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                  mycontroller: _mapKeyController,
                ),
                const Gap(15),
                textFormField(
                  keyboardType: TextInputType.text,
                  labelText: 'Map Value',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                  mycontroller: _mapValueController,
                ),
                const Gap(20),
                BlocBuilder<AdminCubit, AdminState>(
                  builder: (context, state) {
                    if (state is AdminLoading) {
                      return const CircularProgressIndicator();
                    }
                    return Custom_Button(
                      width: 350,
                      text: 'Add or Update Document',
                      onPressed: () {
                        final collection = _collectionController.text.trim();
                        final doc = _docController.text.trim();
                        final field = _fieldController.text.trim();
                        final key = _mapKeyController.text.trim();
                        final value = _mapValueController.text.trim();

                        if (collection.isNotEmpty &&
                            doc.isNotEmpty &&
                            field.isNotEmpty &&
                            key.isNotEmpty &&
                            value.isNotEmpty) {
                          context.read<AdminCubit>().addOrUpdatePlanDocument(
                                collectionName: collection,
                                docName: doc,
                                fieldName: field,
                                mapKey: key,
                                mapValue: value,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill in all fields')),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Custom_Button(
                  width: 350,
                  icon: Icons.delete,
                  iconColor: Colors.red,
                  text: 'Delete Plans',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Deleteplanes()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
