import 'dart:convert';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

void downloadTextFile(String fileName, String content) {
  final bytes = utf8.encode(content);
  final jsArray = <JSUint8Array>[bytes.toJS].toJS;
  final blob = web.Blob(jsArray, web.BlobPropertyBag(type: 'text/plain;charset=utf-8'));
  final url = web.URL.createObjectURL(blob);
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement
    ..href = url
    ..download = fileName
    ..style.display = 'none';
  final body = web.document.body;
  if (body == null) {
    web.URL.revokeObjectURL(url);
    throw StateError('Unable to access document body for file download.');
  }

  body.appendChild(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
}
