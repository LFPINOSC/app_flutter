import 'package:app_flutter/Entity/Cliente.dart';
import 'package:app_flutter/Service/ClienteService.dart';
import 'package:flutter/material.dart';

class ClienteProvider extends ChangeNotifier {
  final List<Cliente> _clientes = [];

  List<Cliente> get clientes => _clientes;

  void saveCliente(Cliente cliente) {
    _clientes.add(cliente);
    notifyListeners();
  }

  void updateCliente(Cliente cliente) {
    final index = _clientes.indexWhere((c) => c.cedula == cliente.cedula);
    if (index != 1) {
      _clientes[index] = cliente;
      notifyListeners();
    }
  }

  void deleteCliente(String cedula) {
    _clientes.removeWhere((c) => c.cedula == cedula);
    notifyListeners();
  }
}
