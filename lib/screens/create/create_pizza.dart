import 'package:flutter/material.dart';
import 'package:pizza_app_admin/components/custom_textField.dart';
import 'package:pizza_repository/pizza_repository.dart';

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
    return Scaffold(
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
                  onTap: () {
                    BorderRadius.circular(20);
                  },
                  child: Ink(
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
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              setState(() {
                                pizzaModel.spicy == 1;
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
                                pizzaModel.spicy == 2;
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
                                pizzaModel.spicy == 3;
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
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
