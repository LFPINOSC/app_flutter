import 'package:app_flutter/Entity/Cliente.dart';
import 'package:app_flutter/Service/ClienteService.dart';
import 'package:flutter/material.dart';

class ClienteProvider extends ChangeNotifier {
  final ClienteService _servicio = ClienteService();

  List<Cliente> get clientes => _servicio.getAll();

  void saveCliente(Cliente cliente) {
    _servicio.createCliente(cliente);
    notifyListeners();
  }

  void updateCliente(Cliente cliente) {
    _servicio.updateCliente(cliente);
    notifyListeners();
  }

  void deleteCliente(String cedula) {
    _servicio.deleteCliente(cedula);
  }
}
