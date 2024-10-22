import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_base_v2/base/domain/disposable.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';

class DisposeBag {
  final List<Object> _disposables = [];
  void addDisposable(Object disposable) {
    _disposables.add(disposable);
  }

  void dispose() {
    for (var disposable in _disposables) {
      if (disposable is TextEditingController) {
        disposable.dispose();
        L.info('Disposed $disposable');
      } else if (disposable is StreamSubscription) {
        disposable.cancel();
        L.info('Canceled $disposable');
      } else if (disposable is StreamController) {
        disposable.close();
        L.info('Closed $disposable');
      } else if (disposable is ChangeNotifier) {
        disposable.dispose();
        L.info('Disposed $disposable');
      } else if (disposable is Disposable) {
        disposable.dispose();
      }
    }

    _disposables.clear();
  }
}

extension TextEditingControllerExtensions on TextEditingController {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension StreamSubscriptionExtensions on StreamSubscription {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension StreamControllerExtensions on StreamController {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension ChangeNotifierExtensions on ChangeNotifier {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension DisposableExtensions on Disposable {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}
