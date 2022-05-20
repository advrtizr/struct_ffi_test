import 'dart:ffi';
import 'dart:io' show Platform;

/// D function declaration is: int64_t create_doc(const uint8_t* data_ptr, const uint64_t len)
typedef TestNative = Uint64 Function();
typedef TestType = int Function();

class LibProvider {
  static final DynamicLibrary dyLib = dyLibOpen('wallet-betterc-x86_64');

  static final LibProvider _provider = LibProvider._internal();

  factory LibProvider() {
    return _provider;
  }

  LibProvider._internal();

  /// Function for opening dynamic library.
  static DynamicLibrary dyLibOpen(String name, {String path = ''}) {
    var fullPath = _platformPath(name, path: path);
    if (Platform.isIOS) {
      return DynamicLibrary.process();
    } else {
      return DynamicLibrary.open(fullPath);
    }
  }

  /// Function returning path to library object.
  static String _platformPath(String name, {String path = ''}) {
    if (Platform.isLinux) {
      return path + 'lib' + name + '.so';
    }
    if (Platform.isAndroid) {
      return 'lib' + name + '.so';
    }
    if (Platform.isMacOS) {
      return path + 'lib' + name + '.a';
    }

    if (Platform.isIOS) {
      return path + 'ios/' + 'lib' + name + '.a';
    }

    throw Exception('Platform is not implemented');
  }

  /// Dart functions.
  final TestType test = dyLib.lookup<NativeFunction<TestNative>>('test').asFunction();
}
