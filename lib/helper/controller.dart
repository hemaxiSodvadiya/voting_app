import 'package:firebase_revision_22_1_23/model/model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/global.dart';

class ProductController extends GetxController {
  int totalProductPrice = 0;
  RxInt amount = 0.obs;
  get totalPrice {
    for (addVote cartProduct in Global.addVoted) {
      totalProductPrice = totalProductPrice + 1;
    }
    return totalProductPrice;
  }

  get removePrice {
    for (addVote cartProduct in Global.addVoted) {
      totalProductPrice = totalProductPrice - 1;
    }
    return totalProductPrice;
  }
}
