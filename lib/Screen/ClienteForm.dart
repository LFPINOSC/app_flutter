import 'dart:io';

import 'package:app_flutter/Entity/Cliente.dart';
import 'package:app_flutter/Provider/ClienteProvider.dart';
import 'package:app_flutter/Widget/CajaTextField.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker();
  String? _fotoPath;

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

    _fotoPath = widget.cliente?.fotoPath;
  }

  Future<void> tomarFoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image == null) return;
      final directory = await getApplicationDocumentsDirectory();
      final cedula = _cedulaController.text.trim().isEmpty
          ? DateTime.now().microsecondsSinceEpoch.toString()
          : _cedulaController.text.trim();

      final nombreArchivo =
          'cliente_${cedula}_${DateTime.now().microsecondsSinceEpoch}.jpg';
      final nuevaRuta = p.join(directory.path, nombreArchivo);
      final File imageGuardada = await File(image.path).copy(nuevaRuta);
      if (!mounted) return;
      setState(() {
        _fotoPath = imageGuardada.path;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto guardada correctamente')),
      );
    } catch (e) {
      if (mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Foto incorrecta')));
    }
  }

  void guardarCliente() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<ClienteProvider>();
    final nuevoCliente = Cliente(
      cedula: _cedulaController.text,
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      email: _emailController.text,
      fotoPath: _fotoPath,
    );
    if (widget.cliente == null) {
      provider.saveCliente(nuevoCliente);
    } else {
      provider.updateCliente(nuevoCliente);
    }
    Navigator.pop(context);
  }

  Widget _bluldFoto() {
    if (_fotoPath != null && _fotoPath!.isNotEmpty) {
      final archivo = File(_fotoPath!);
      if (archivo.existsSync()) {
        return CircleAvatar(radius: 55, backgroundImage: FileImage(archivo));
      }
    }
    return CircleAvatar(radius: 55, child: Icon(Icons.person, size: 50));
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
              _bluldFoto(),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: tomarFoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tomar foto'),
              ),
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
