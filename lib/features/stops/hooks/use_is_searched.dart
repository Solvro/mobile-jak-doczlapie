import "package:flutter/material.dart" show ValueNotifier;
import "package:flutter_hooks/flutter_hooks.dart";

ValueNotifier<bool> useIsSearched(String locationAddress) {
  final isSearched = useState(false);

  useEffect(() {
    isSearched.value = false;
    return null;
  }, [locationAddress]);

  return isSearched;
}
