// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:yarmy_shrine/widgets/backdrop.dart';
import 'package:yarmy_shrine/model/product.dart';
import 'views/category_menu_page.dart';
import 'views/home.dart';

class ShrineApp extends StatefulWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  State<ShrineApp> createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackDrop(
      currentCategory: _currentCategory,
      frontLayer: HomePage(
        category: _currentCategory,
      ),
      backLayer: CategoryMenuPage(
        onCategoryTap: _onCategoryTap,
        currentCategory: _currentCategory,
      ),
      frontTitle: const Text('SHRINE'),
      backTitle: const Text('MENU'),
    );
  }
}
