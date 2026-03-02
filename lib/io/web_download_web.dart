import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:web/web.dart' as web;
import 'dart:convert';

void triggerDownload(String content, String filename) {
  final bytes = utf8.encode(content);
  final blob = web.Blob(
    [bytes.toJS].toJS,
    web.BlobPropertyBag(type: 'text/plain'),
  );
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = filename;
  anchor.click();
  web.URL.revokeObjectURL(url);
}

Future<void> triggerSaveAs(String content, String suggestedName) async {
  // Use the File System Access API (Chrome/Edge) for a native OS Save dialog.
  // Fall back to a plain download on unsupported browsers (Firefox).
  if (!web.window.has('showSaveFilePicker')) {
    triggerDownload(content, suggestedName);
    return;
  }
  try {
    final opts = {
      'suggestedName': suggestedName,
      'types': [
        {
          'description': 'Text Files',
          'accept': {'text/plain': ['.txt']}
        }
      ]
    }.jsify() as JSObject;
    final handle = await web.window
        .callMethod<JSPromise<web.FileSystemFileHandle>>(
            'showSaveFilePicker'.toJS, opts)
        .toDart;
    final writable = await handle.createWritable().toDart;
    await writable
        .callMethod<JSPromise<JSAny?>>('write'.toJS, content.toJS)
        .toDart;
    await writable.close().toDart;
  } catch (e) {
    // AbortError means the user cancelled — not an error.
    if (e.toString().contains('AbortError')) return;
    rethrow;
  }
}