import 'package:app_flutter/Entity/Cliente.dart';
import 'package:app_flutter/Provider/ClienteProvider.dart';
import 'package:app_flutter/Screen/ClienteForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageCliente extends StatelessWidget {
  const PageCliente({super.key});

  void abrirFormulario(BuildContext context, {Cliente? cliente}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => clienteForm(cliente: cliente)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClienteProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Clientes"), centerTitle: true),
      body: Container(
        color: Colors.blue[100],
        child: ListView.builder(
          itemCount: provider.clientes.length,
          itemBuilder: (_, index) {
            final c = provider.clientes[index];
            return Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(child: Text(c.nombre)),
                title: Text("${c.nombre} ${c.apellido}"),
                subtitle: Text(c.email),
                onTap: () => abrirFormulario(context, cliente: c),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => abrirFormulario(context, cliente: c),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteCliente(c.cedula),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => abrirFormulario(context),
        icon: const Icon(Icons.add),
        label: const Text("Agregar Cliente"),
      ),
    );
  }
}
