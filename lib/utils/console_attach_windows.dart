/*
 * This file is part of The Codex Ledger.
 *
 * The Codex Ledger is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * The Codex Ledger is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with The Codex Ledger.  If not, see <https://www.gnu.org/licenses/>.
 */

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
