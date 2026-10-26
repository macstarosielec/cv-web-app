2. Error is a transient transport failure:
   - `err.type == DioExceptionType.connectionError`, EXCEPT when `err.error is SocketException` and its message contains 'Failed host lookup' or `osError?.errorCode == 7` — do not retry DNS failures;
   - OR `err.type == DioExceptionType.unknown` and `err.error is HttpException` whose message contains one of: 'Software caused connection abort', 'Connection closed before full header was received', 'Connection reset by peer', 'Broken pipe';
   - OR `err.type == DioExceptionType.unknown` and `err.error is SocketException` with one of the same substrings.
   Keep the substrings as a private const list. Do NOT retry connectionTimeout, sendTimeout, receiveTimeout, badResponse, cancel, badCertificate.
3. Retry budget: read `options.extra['TransportRetryKey']` (int, default 0) < maxRetries. Use this NEW key, not the existing 'RetryKey' — do not change Cloudflare/401 budgets. Add the key constant and small `transportRetryCount()` / `incrementTransportRetryCount()` helpers next to where request_option_extras.dart lives if the network package already depends on that package; otherwise keep them private in the interceptor file. Tell me which you chose and why.

On retry: wait backoff[attemptIndex], build `newOptions` as a copy with the incremented key (same approach as incrementRetryCount — copy extra, keep everything else including extra['encryptedFormData']), then
`retryDioClientFactory().fetch<dynamic>(newOptions).then(handler.resolve).catchError((e) => handler.reject(e as DioException))` — mirror caching_cloudflare_integration_interceptor.dart:63-71 exactly. Otherwise `handler.next(err)`.

Cover:
- POST /x/_get: adapter throws HttpException('Software caused connection abort') on 1st call, returns 200 on 2nd → caller gets 200, adapter called twice, second options.extra['TransportRetryKey'] == 1.
- GET /x (no suffix): same as above → retried.
- POST /x/_post with the same failure → NOT retried, error propagates unchanged, adapter called once.
- connectionError with SocketException 'Failed host lookup' → NOT retried.
- receiveTimeout → NOT retried.
- Failure on every attempt → adapter called exactly 1 + maxRetries times, final error is the last DioException.
- options.extra['encryptedFormData'] set on the original request is present on the retried request's options.
- Existing 'RetryKey' value is unchanged on the retried request.
