/**
 * Threshold constants for usage indicators and battery levels
 */
export const THRESHOLDS = {
  USAGE: { WARNING: 50, CRITICAL: 80 },
  BATTERY: { CRITICAL: 20 },
  SIGNAL: { STRONG: 80, GOOD: 60, OK: 40, WEAK: 20 },
  CHARGE: [90, 80, 70, 60, 50, 40, 30, 20, 10],
};

/**
 * Battery charge level names (maps to THRESHOLDS.CHARGE indices)
 */
export const CHARGE_LEVELS = [
  'full',
  'high',
  'medHigh',
  'med',
  'mid',
  'lowMid',
  'low',
  'veryLow',
  'critical',
];

/**
 * Icon constants for WiFi and Battery indicators (Nerd Font icons)
 */
export const ICONS = {
  WIFI: {
    off: '󰤭',
    noInternet: '󰤮',
    unconfigured: '󰤫',
    ethernet: '󰈀',
    vpn: '󰦝',
    strong: '󰤨',
    good: '󰤥',
    ok: '󰤢',
    weak: '󰤟',
    poor: '󰤯',
  },
  BATTERY: {
    unknown: '󰂑',
    charging: {
      full: '󰂅',
      high: '󰂋',
      medHigh: '󰂊',
      med: '󰢞',
      mid: '󰂉',
      lowMid: '󰢝',
      low: '󰂈',
      veryLow: '󰂇',
      critical: '󰂆',
      empty: '󰢜',
    },
    discharging: {
      full: '󰁹',
      high: '󰂂',
      medHigh: '󰂁',
      med: '󰂀',
      mid: '󰁿',
      lowMid: '󰁾',
      low: '󰁽',
      veryLow: '󰁼',
      critical: '󰁻',
      empty: '󰁺',
    },
  },
};
