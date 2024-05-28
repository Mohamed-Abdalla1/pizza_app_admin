import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pizza_app_admin/screens/create/blocs/upload_pizza/upload_image_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

import '../../components/custom_textField.dart';
import '../../components/macro.dart';

class CreatePizza extends StatefulWidget {
  const CreatePizza({super.key});

  @override
  State<CreatePizza> createState() => _CreatePizzaState();
}

class _CreatePizzaState extends State<CreatePizza> {
  final nameController = TextEditingController();
  final discountController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final caloriesController = TextEditingController();
  final proteinsController = TextEditingController();
  final fatController = TextEditingController();
  final carbsController = TextEditingController();
  bool creationRequired = false;
  String? _errorMsg;
  final _formKey = GlobalKey<FormState>();
  late PizzaModel pizzaModel;
  @override
  void initState() {
    pizzaModel = PizzaModel.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadImageBloc, UploadImageState>(
      listener: (context, state) {
        if (state is UploadImageSuccess) {
          setState(() {
            pizzaModel.image = state.url;
          });
        }
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create A New Pizza....',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 1000,
                        maxWidth: 1000,
                      );
                      if (image != null && context.mounted) {
                        context.read<UploadImageBloc>().add(UploadImage(
                            await image.readAsBytes(), basename(image.path)));
                      }
                    },
                    child: pizzaModel.image.startsWith(('http'))
                        ? Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(pizzaModel.image),
                                    fit: BoxFit.cover)),
                          )
                        : Ink(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Upload Image',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300,
                          child: CustomTextfield(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            hintText: 'Pizza Name',
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: CustomTextfield(
                            controller: descController,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            hintText: 'Description',
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextfield(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  hintText: 'Price',
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: CustomTextfield(
                                  controller: discountController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  hintText: 'Discount',
                                  suffixIcon: const Icon(Icons.percent),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text('isVeg'),
                            const SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                              value: pizzaModel.isVeg,
                              onChanged: (value) {
                                setState(() {
                                  pizzaModel.isVeg = value!;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text('Spicy'),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    setState(() {
                                      pizzaModel.spicy = 1;
                                    });
                                  },
                                  child: Ink(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: pizzaModel.spicy == 1
                                          ? Border.all(width: 2)
                                          : null,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    setState(() {
                                      pizzaModel.spicy = 2;
                                    });
                                  },
                                  child: Ink(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: pizzaModel.spicy == 2
                                          ? Border.all(width: 2)
                                          : null,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    setState(() {
                                      pizzaModel.spicy = 3;
                                    });
                                  },
                                  child: Ink(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: pizzaModel.spicy == 3
                                          ? Border.all(width: 2)
                                          : null,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Macro :'),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              MyMacro(
                                icon: FontAwesomeIcons.fire,
                                title: 'Calories',
                                value: pizzaModel.macros.calories,
                                controller: caloriesController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacro(
                                icon: FontAwesomeIcons.dumbbell,
                                title: 'Protien',
                                value: pizzaModel.macros.proteins,
                                controller: proteinsController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacro(
                                icon: FontAwesomeIcons.oilWell,
                                title: 'Fats',
                                value: pizzaModel.macros.fat,
                                controller: fatController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacro(
                                icon: FontAwesomeIcons.breadSlice,
                                title: 'Carbs',
                                value: pizzaModel.macros.carbs,
                                controller: carbsController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        !creationRequired
                            ? SizedBox(
                                width: 300,
                                child: TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        pizzaModel.name = nameController.text;
                                        pizzaModel.desc = descController.text;
                                        pizzaModel.price =
                                            int.parse(priceController.text);
                                        pizzaModel.discount =
                                            int.parse(discountController.text);
                                        pizzaModel.macros.calories =
                                            int.parse(caloriesController.text);
                                        pizzaModel.macros.proteins =
                                            int.parse(proteinsController.text);
                                        pizzaModel.macros.fat =
                                            int.parse(fatController.text);
                                        pizzaModel.macros.carbs =
                                            int.parse(carbsController.text);
                                      });
                                      log(pizzaModel.toString());
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 5),
                                    child: Text(
                                      'Create Pizza',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
