import 'dart:convert';
import 'dart:html' as html;

void downloadTextFile(String fileName, String content) {
  final bytes = utf8.encode(content);
  final blob = html.Blob(<dynamic>[bytes], 'text/plain;charset=utf-8');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..download = fileName
    ..style.display = 'none';
  final body = html.document.body;
  if (body == null) {
    html.Url.revokeObjectUrl(url);
    throw StateError('Unable to access document body for file download.');
  }

  body.children.add(anchor);
  anchor.click();
  anchor.remove();
  html.Url.revokeObjectUrl(url);
}
