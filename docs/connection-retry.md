2. Error is a transient transport failure:
   - `err.type == DioExceptionType.connectionError`, EXCEPT when `err.error is SocketException` and its message contains 'Failed host lookup' or `osError?.errorCode == 7` — do not retry DNS failures;
   - OR `err.type == DioExceptionType.unknown` and `err.error is HttpException` whose message contains one of: 'Software caused connection abort', 'Connection closed before full header was received', 'Connection reset by peer', 'Broken pipe';
   - OR `err.type == DioExceptionType.unknown` and `err.error is SocketException` with one of the same substrings.
   Keep the substrings as a private const list. Do NOT retry connectionTimeout, sendTimeout, receiveTimeout, badResponse, cancel, badCertificate.
3. Retry budget: read `options.extra['TransportRetryKey']` (int, default 0) < maxRetries. Use this NEW key, not the existing 'RetryKey' — do not change Cloudflare/401 budgets. Add the key constant and small `transportRetryCount()` / `incrementTransportRetryCount()` helpers next to where request_option_extras.dart lives if the network package already depends on that package; otherwise keep them private in the interceptor file. Tell me which you chose and why.

On retry: wait backoff[attemptIndex], build `newOptions` as a copy with the incremented key (same approach as incrementRetryCount — copy extra, keep everything else including extra['encryptedFormData']), then
`retryDioClientFactory().fetch<dynamic>(newOptions).then(handler.resolve).catchError((e) => handler.reject(e as DioException))` — mirror caching_cloudflare_integration_interceptor.dart:63-71 exactly. Otherwise `handler.next(err)`.
