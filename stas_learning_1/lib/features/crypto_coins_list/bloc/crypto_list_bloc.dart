import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stas_learning_1/repositories/crypto_coins/crypto_coins.dart';

part 'crypto_list_events.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        final cryptoCoinsList = await coinsRepository.getCoinsList();
        emit(CryptoListLoaded(coinsList: cryptoCoinsList));
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      }
    });
  }
  final AbstractCoinsRepository coinsRepository;
}
