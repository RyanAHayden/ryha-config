import { THRESHOLDS, CHARGE_LEVELS, ICONS } from './constants.js';

/**
 * Get CSS class for CPU/Memory usage level
 * @param {number} usage - Usage percentage (0-100)
 * @returns {string} CSS class name ('critical', 'warning', or '')
 */
export function getUsageClass(usage) {
  if (usage >= THRESHOLDS.USAGE.CRITICAL) return 'critical';
  if (usage >= THRESHOLDS.USAGE.WARNING) return 'warning';
  return '';
}

/**
 * Get CSS class for battery status
 * @param {object|null} battery - Battery provider output
 * @returns {string} CSS class name ('charging', 'critical', or '')
 */
export function getBatteryClass(battery) {
  if (!battery) return '';
  if (battery.isCharging) return 'charging';
  if (battery.chargePercent <= THRESHOLDS.BATTERY.CRITICAL) return 'critical';
  return '';
}

/**
 * Check if an IP address is a valid routable address (not link-local/APIPA/loopback)
 * @param {object|null} iface - Network interface object
 * @returns {boolean} True if interface has at least one routable IP
 */
export function hasRoutableIP(iface) {
  if (!iface?.ipv4Addresses?.length) return false;
  return iface.ipv4Addresses.some((addr) => {
    const ip = addr.split('/')[0];
    // Exclude non-routable addresses:
    // - 169.254.x.x: APIPA/link-local (no DHCP, no real connection)
    // - 127.x.x.x: loopback
    // - 0.0.0.0: unspecified
    if (ip.startsWith('169.254.') || ip.startsWith('127.') || ip === '0.0.0.0') {
      return false;
    }
    return true;
  });
}

/**
 * Get WiFi icon based on network status
 * @param {object|null} network - Network provider output
 * @returns {{icon: string}} Object containing the icon character
 */
export function getWifiIcon(network) {
  if (!network) return { icon: ICONS.WIFI.off };

  const interfaceType = network.defaultInterface?.type;
  const signalStrength = network.defaultGateway?.signalStrength;
  const hasGateway = network.defaultGateway != null;
  // For ethernet, check if interface has a routable IP (not APIPA)
  const hasRoutableConnection = hasRoutableIP(network.defaultInterface);

  // VPN case: show VPN icon only
  // Due to zebar API limitations, we cannot reliably detect underlying physical connection
  if (interfaceType === 'proprietary_virtual') {
    return { icon: ICONS.WIFI.vpn };
  }

  // Non-VPN cases
  switch (interfaceType) {
    case 'ethernet': {
      // For ethernet, defaultGateway is often null even when connected
      // Use routable IP check instead
      if (!hasRoutableConnection) {
        return { icon: ICONS.WIFI.noInternet };
      }
      // LAN takes priority - Wi-Fi icon is not shown when LAN is connected
      return { icon: ICONS.WIFI.ethernet };
    }
    case 'wifi':
      if (signalStrength >= THRESHOLDS.SIGNAL.STRONG) return { icon: ICONS.WIFI.strong };
      if (signalStrength >= THRESHOLDS.SIGNAL.GOOD) return { icon: ICONS.WIFI.good };
      if (signalStrength >= THRESHOLDS.SIGNAL.OK) return { icon: ICONS.WIFI.ok };
      if (signalStrength >= THRESHOLDS.SIGNAL.WEAK) return { icon: ICONS.WIFI.weak };
      // Fallback when signalStrength is undefined (defaultGateway is null)
      if (signalStrength === undefined) {
        return { icon: hasRoutableConnection ? ICONS.WIFI.ok : ICONS.WIFI.noInternet };
      }
      return { icon: ICONS.WIFI.poor };
    default:
      // Unknown interface type: avoid false "no internet" when a gateway or routable IP exists
      if (hasRoutableConnection || hasGateway) {
        return { icon: ICONS.WIFI.ok };
      }
      return { icon: ICONS.WIFI.off };
  }
}

/**
 * Get charge level name from percentage
 * @param {number} charge - Battery charge percentage (0-100)
 * @returns {string} Charge level name
 */
export function getChargeLevel(charge) {
  for (let i = 0; i < THRESHOLDS.CHARGE.length; i++) {
    if (charge >= THRESHOLDS.CHARGE[i]) return CHARGE_LEVELS[i];
  }
  return 'empty';
}

/**
 * Get battery icon based on charge level and charging status
 * @param {object|null} battery - Battery provider output
 * @returns {string} Battery icon character
 */
export function getBatteryIcon(battery) {
  if (!battery) return ICONS.BATTERY.unknown;
  const charge = battery.chargePercent ?? 0;
  const state = battery.isCharging ? 'charging' : 'discharging';
  const level = getChargeLevel(charge);
  return ICONS.BATTERY[state][level];
}
