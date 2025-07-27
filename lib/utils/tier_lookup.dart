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