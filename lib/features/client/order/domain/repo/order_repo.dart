import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/entites/review_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<OrderEntity>>> getUserOrders(String userId);

  Future<Either<Failure, void>> cancelOrder(String orderId);
  Future<Either<Failure, void>> rateProduct(
    ClientEntity clientEntity,
    ReviewEntity review,
  );
}
