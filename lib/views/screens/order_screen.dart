import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/views/widgets/order_summary.dart';

class OrderScreen extends HookWidget {

  static const routeName = "/order";

  OrderScreen({Key? key}) : super(key: key);

  final _keyFormOrder = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressController = useTextEditingController();
    final emailController = useTextEditingController();
    final validatorFieldRequired = RequiredValidator(errorText: "Este campo es requerido");

    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Orden"),
      ),
      body: Form(
        key: _keyFormOrder,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "Información Personal",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 8,),
              _buildTextFormField(context, nameController, "Nombre Completo", validator: validatorFieldRequired),
              SizedBox(height: 8,),
              _buildTextFormField(context, emailController, "Correo electrónico", validator: EmailValidator(errorText: "La dirección de correo no es válida")),
              SizedBox(height: 24,),
              Text(
                "Información de Contacto",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 8,),
              _buildTextFormField(context, phoneController, "Teléfono", validator: validatorFieldRequired),
              SizedBox(height: 8,),
              _buildTextFormField(context, addressController, "Dirección"),
              SizedBox(height: 24,),
              Text(
                "Resumen de la Orden",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 8,),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                  return OrderSummary(
                    subtotal: state.cart.total, 
                    discount: 0,
                    total: state.cart.total,);
                  } else {
                    return Text("Something went wrong");
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(
                  "Registrar Orden".toUpperCase(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Theme.of(context).primaryColor),),
                onPressed: () {
                  if(!_keyFormOrder.currentState!.validate()) return;
                }, ),
              Icon(Icons.send, color: Theme.of(context).primaryColor,)
            ],
          ),),
      ),
    );
  }

  Widget _buildTextFormField(BuildContext context,
      TextEditingController textController, String label, {String? Function(String? value)? validator}) {
    return TextFormField(
      controller: textController,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}

