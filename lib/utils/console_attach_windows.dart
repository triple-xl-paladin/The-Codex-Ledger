import 'dart:ffi';

typedef AttachConsoleNative = Int32 Function(Uint32 dwProcessId);
typedef AttachConsoleDart = int Function(int dwProcessId);

void attachConsole() {
  final kernel32 = DynamicLibrary.open('kernel32.dll');
  final attachConsoleFunction = kernel32
      .lookupFunction<AttachConsoleNative, AttachConsoleDart>('AttachConsole');

  const ATTACH_PARENT_PROCESS = 0xFFFFFFFF;
  final result = attachConsoleFunction(ATTACH_PARENT_PROCESS);
  if (result == 0) {
    print('⚠️ Failed to attach to console');
  } else {
    print('✅ Attached to parent console');
  }
}
