/// Configuration for the trip bottom sheet
typedef SheetConfig = ({double headerHeight, double tileHeight, double baseSize, double maxSize, double minSize});

/// Default configuration for the trip bottom sheet
const SheetConfig defaultSheetConfig = (
  headerHeight: 80.0,
  tileHeight: 60.0,
  baseSize: 0.3,
  maxSize: 0.9,
  minSize: 0.1,
);
