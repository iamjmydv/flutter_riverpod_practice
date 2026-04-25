import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/data/cart_repository_impl.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/domain/cart_repository.dart';

// Presentation Layer — Repository Provider (Dependency Injection)
// Typed as the ABSTRACT interface (CartRepository)
// but creates the CONCRETE implementation (CartRepositoryImpl).
// This is Dependency Inversion — swap implementations by changing one line.

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
});
