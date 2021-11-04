import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shopping_car/blocs/cart/cart_bloc.dart';
import 'package:shopping_car/blocs/order/order_bloc.dart';
import 'package:shopping_car/models/order_model.dart';
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
    final validatorFieldRequired =
        RequiredValidator(errorText: "Este campo es requerido");

    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Orden"),
      ),
      body: Form(
        key: _keyFormOrder,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            
            if (state is OrderLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrderLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text(
                      "Información Personal",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _buildTextFormField(
                        context, nameController, "Nombre Completo",
                        validator: validatorFieldRequired),
                    SizedBox(
                      height: 16,
                    ),
                    _buildTextFormField(
                        context, emailController, "Correo electrónico",
                        validator: EmailValidator(
                            errorText: "La dirección de correo no es válida")),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Información de Contacto",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _buildTextFormField(context, phoneController, "Teléfono",
                        validator: validatorFieldRequired),
                    SizedBox(
                      height: 16,
                    ),
                    _buildTextFormField(
                        context, addressController, "Dirección",
                        validator: validatorFieldRequired),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Resumen de la Orden",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          return OrderSummary(
                            subtotal: state.cart.subtotal,
                            discount: state.cart.discount,
                            total: state.cart.total,
                          );
                        } else {
                          return Text("Something went wrong");
                        }
                      },
                    )
                  ],
                ),
              );
            } else if (state is OrderSaved) {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 60,),
                  Text("Su orden se registró correctamente"),
                ],
              ),);
            } else {
              return Text("Something went wrong");
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return Center(child: CircularProgressIndicator(),);
              } else if (state is OrderLoaded) {
                return TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Registrar Orden".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(width: 8,),
                      Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  onPressed: () {
                    if (!_keyFormOrder.currentState!.validate()) return;
                    final order = Order(
                      customerName: nameController.text, 
                      customerEmail: emailController.text, 
                      customerPhone: phoneController.text, 
                      customerAddress: addressController.text, 
                      subtotal: state.cart.subtotal, 
                      discount: state.cart.discount, 
                      total: state.cart.total, 
                      status: state.cart.status, 
                      detail: state.cart.products);

                    context.read<OrderBloc>().add(SaveOrder(order: order));
                  },
                );
              } else if (state is OrderSaved) {
                return TextButton(
                  child: Text(
                    "Ver mis ordenes".toUpperCase(), 
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Theme.of(context).primaryColor),), 
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      BuildContext context, TextEditingController textController, String label,
      {String? Function(String? value)? validator}) {
    return TextFormField(
      controller: textController,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
