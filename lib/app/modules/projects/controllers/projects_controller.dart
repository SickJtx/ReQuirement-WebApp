import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgileProject {
  AgileProject({
    required this.titulo,
    required this.tipo,
    required this.fecha,
    required this.cantidad,
    required bool? visibilidad,
  }) {
    this.visibilidad.value = visibilidad!;
  }

  final String? titulo;
  final String? tipo;
  final DateTime? fecha;
  final int? cantidad;
  final Rx<bool> visibilidad = false.obs;
}

class ProjectsController extends GetxController {
  final listKey = GlobalKey<AnimatedListState>();
  final projects = [
    AgileProject(
        titulo: "Nullam ligula.",
        tipo: "Sed aliquam",
        cantidad: 5,
        fecha: DateTime.now(),
        visibilidad: false)
  ].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
