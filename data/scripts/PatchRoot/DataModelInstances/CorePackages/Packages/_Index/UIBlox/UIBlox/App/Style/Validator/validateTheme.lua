-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local t = require(scriptParentParentParentParentParent.t)

local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local validateSelectionCursorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateSelectionCursorInfo)
local validateThemedBackgroundImageInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateThemedBackgroundImageInfo)

return (t.strictInterface({
    BackgroundDefault = validateColorInfo,
    BackgroundContrast = validateColorInfo,
    BackgroundMuted = validateColorInfo,
    BackgroundUIDefault = validateColorInfo,
    BackgroundUIContrast = validateColorInfo,
    BackgroundOnHover = validateColorInfo,
    BackgroundOnPress = validateColorInfo,
    UIDefault = validateColorInfo,
    UIMuted = validateColorInfo,
    UIEmphasis = validateColorInfo,
    ContextualPrimaryDefault = validateColorInfo,
    ContextualPrimaryOnHover = validateColorInfo,
    ContextualPrimaryContent = validateColorInfo,
    SystemPrimaryDefault = validateColorInfo,
    SystemPrimaryOnHover = validateColorInfo,
    SystemPrimaryContent = validateColorInfo,
    SecondaryDefault = validateColorInfo,
    SecondaryOnHover = validateColorInfo,
    SecondaryContent = validateColorInfo,
    IconDefault = validateColorInfo,
    IconEmphasis = validateColorInfo,
    IconOnHover = validateColorInfo,
    TextEmphasis = validateColorInfo,
    TextDefault = validateColorInfo,
    TextMuted = validateColorInfo,
    TextLink = validateColorInfo,
    Divider = validateColorInfo,
    Overlay = validateColorInfo,
    DropShadow = validateColorInfo,
    NavigationBar = validateColorInfo,
    PlaceHolder = validateColorInfo,
    OnlineStatus = validateColorInfo,
    OfflineStatus = validateColorInfo,
    Success = validateColorInfo,
    Alert = validateColorInfo,
    Badge = validateColorInfo,
    BadgeContent = validateColorInfo,
    SelectionCursor = validateSelectionCursorInfo,
    PlayerBackgroundDefault = validateThemedBackgroundImageInfo,
    ItemBackgroundDefault = validateThemedBackgroundImageInfo
}))
