// tier_lookup.dart

/// Mapping of levels to tiers
final Map<int, int> levelToTier = {
  1: 1,
  2: 2,
  3: 2,
  4: 2,
  5: 3,
  6: 3,
  7: 3,
  8: 4,
  9: 4,
  10: 4,
};

/// Maps tiers to minimum required character level
final Map<int, int> tierToMinLevel = {
  1: 1,
  2: 2,
  3: 5,
  4: 8,
};

/// Maps tiers to maximum required character level
final Map<int, int> tierToMaxLevel = {
  1: 1,
  2: 4,
  3: 7,
  4: 10,
};