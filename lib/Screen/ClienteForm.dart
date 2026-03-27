import 'package:app_flutter/Entity/Cliente.dart';
import 'package:app_flutter/Provider/ClienteProvider.dart';
import 'package:app_flutter/Widget/CajaTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClienteFrom extends StatefulWidget {
  final Cliente? cliente;
  const ClienteFrom({super.key, this.cliente});

  @override
  State<ClienteFrom> createState() => _ClienteFromPageState();
}

class _ClienteFromPageState extends State<ClienteFrom> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cedulaController;
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _cedulaController = TextEditingController(
      text: widget.cliente?.cedula ?? "",
    );
    _nombreController = TextEditingController(
      text: widget.cliente?.nombre ?? "",
    );
    _apellidoController = TextEditingController(
      text: widget.cliente?.apellido ?? "",
    );
    _emailController = TextEditingController(text: widget.cliente?.email ?? "");
  }

  void guardarCliente() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<ClienteProvider>();
    final nuevoCliente = Cliente(
      cedula: _cedulaController.text,
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      email: _emailController.text,
    );
    if (widget.cliente == null) {
      provider.saveCliente(nuevoCliente);
    } else {
      provider.updateCliente(nuevoCliente);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cliente == null ? "Agregar Cliente" : "Editar Cliente",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CajaTextField(
                controller: _cedulaController,
                label: "Cedula",
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingrese el cedula" : null,
              ),
              CajaTextField(
                controller: _nombreController,
                label: "Nombre",
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingrese el nombre" : null,
              ),
              CajaTextField(
                controller: _apellidoController,
                label: "Apellido",
                validator: (value) => value == null || value.isEmpty
                    ? "Ingrese el apellido"
                    : null,
              ),
              CajaTextField(
                controller: _emailController,
                label: "Email",
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingrese el email" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: guardarCliente,
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
