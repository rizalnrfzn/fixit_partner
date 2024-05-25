import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_state.dart';
part 'income_cubit.freezed.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit() : super(const IncomeState.initial());

  static const List<Tab> myTabs = [
    Tab(text: 'Harian'),
    Tab(text: 'Mingguan'),
    Tab(text: 'Bulanan'),
  ];
}
