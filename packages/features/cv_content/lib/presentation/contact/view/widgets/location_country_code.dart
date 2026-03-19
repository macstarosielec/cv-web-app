/// Extracts an ISO 3166-1 alpha-2 country code from a location string.
///
/// Supports full country names and strings like "City, Country".
/// Returns `'PL'` as fallback when no match is found.
String locationToCountryCode(String location) {
  final normalized = location.trim().toLowerCase();

  // Try the last comma-separated segment first (e.g. "Kraków, Poland").
  final segments = normalized.split(',');
  final candidate = segments.last.trim();

  return _nameToCode[candidate] ?? _nameToCode[normalized] ?? 'PL';
}

const _nameToCode = <String, String>{
  'albania': 'AL',
  'austria': 'AT',
  'belarus': 'BY',
  'belgium': 'BE',
  'bosnia': 'BA',
  'bosnia and herzegovina': 'BA',
  'bulgaria': 'BG',
  'croatia': 'HR',
  'czech republic': 'CZ',
  'czechia': 'CZ',
  'denmark': 'DK',
  'estonia': 'EE',
  'finland': 'FI',
  'france': 'FR',
  'germany': 'DE',
  'greece': 'GR',
  'hungary': 'HU',
  'iceland': 'IS',
  'ireland': 'IE',
  'italy': 'IT',
  'kosovo': 'XK',
  'latvia': 'LV',
  'lithuania': 'LT',
  'luxembourg': 'LU',
  'moldova': 'MD',
  'montenegro': 'ME',
  'netherlands': 'NL',
  'north macedonia': 'MK',
  'norway': 'NO',
  'poland': 'PL',
  'portugal': 'PT',
  'romania': 'RO',
  'russia': 'RU',
  'serbia': 'RS',
  'slovakia': 'SK',
  'slovenia': 'SI',
  'spain': 'ES',
  'sweden': 'SE',
  'switzerland': 'CH',
  'turkey': 'TR',
  'türkiye': 'TR',
  'ukraine': 'UA',
  'united kingdom': 'GB',
  'uk': 'GB',
  'great britain': 'GB',
  'england': 'GB',
  'scotland': 'GB',
  'wales': 'GB',
};
