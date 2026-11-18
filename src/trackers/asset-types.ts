/** Roblox AssetTypeId → display name (the subset that appears in the avatar catalog). */
export const ASSET_TYPES: Record<number, string> = {
  2: 'T-Shirt', 8: 'Hat', 11: 'Shirt', 12: 'Pants', 17: 'Head', 18: 'Face', 19: 'Gear',
  27: 'Torso', 28: 'Right Arm', 29: 'Left Arm', 30: 'Left Leg', 31: 'Right Leg',
  41: 'Hair', 42: 'Face Accessory', 43: 'Neck', 44: 'Shoulder', 45: 'Front', 46: 'Back', 47: 'Waist',
  48: 'Climb Animation', 50: 'Fall Animation', 51: 'Idle Animation', 52: 'Jump Animation',
  53: 'Run Animation', 54: 'Swim Animation', 55: 'Walk Animation', 61: 'Emote',
  64: 'T-Shirt Accessory', 65: 'Shirt Accessory', 66: 'Pants Accessory', 67: 'Jacket', 68: 'Sweater',
  69: 'Shorts', 70: 'Left Shoe', 71: 'Right Shoe', 72: 'Dress Skirt', 76: 'Eyebrow', 77: 'Eyelash',
  78: 'Mood', 79: 'Dynamic Head',
};

export const BUNDLE_TYPES: Record<number, string> = {
  1: 'Body Bundle', 2: 'Animation Pack', 3: 'Shoes', 4: 'Dynamic Head', 5: 'Avatar Bundle',
};

export const assetTypeName = (id: number | undefined): string =>
  (id !== undefined && ASSET_TYPES[id]) || `Asset #${id ?? '?'}`;

export const bundleTypeName = (id: number | undefined): string =>
  (id !== undefined && BUNDLE_TYPES[id]) || `Bundle #${id ?? '?'}`;
