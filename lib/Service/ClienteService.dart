import 'package:app_flutter/Entity/Cliente.dart';

class ClienteService {
  final List<Cliente> _listadoClientes = [];

  void createCliente(Cliente cliente) {
    _listadoClientes.add(
      Cliente(
        cedula: cliente.cedula,
        nombre: cliente.nombre,
        apellido: cliente.apellido,
        email: cliente.email,
      ),
    );
  }

  void updateCliente(Cliente cliente) {
    final index = _listadoClientes.indexWhere(
      (c) => c.cedula == cliente.cedula,
    );
    if (index != -1) {
      _listadoClientes[index] = cliente;
    }
  }

  void deleteCliente(String cedula) {
    _listadoClientes.removeWhere((c) => c.cedula == cedula);
  }

  List<Cliente> getAll() => _listadoClientes;
}
