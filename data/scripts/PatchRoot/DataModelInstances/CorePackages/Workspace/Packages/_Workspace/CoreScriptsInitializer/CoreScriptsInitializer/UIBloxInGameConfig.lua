-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local SharedFlags = require(scriptParentParent.SharedFlags)
local UIBlox = SharedFlags.UIBlox

return {
    useFoundationButton = true,
    enableTooltipV2HoverControllerReRenderFix = UIBlox.GetFFlagUIBloxEnableTooltipV2HoverControllerReRenderFix(),
    enableTooltipV2BodyFontFix = UIBlox.GetFFlagUIBloxEnableTooltipV2BodyFontFix(),
    enableOpenTypeSupport = SharedFlags.GetFFlagLuaAppEnableOpenTypeSupport(),
    didMountUpdateFullPageModal = true,
    useFoundationToastButtonSizing = UIBlox.FFlagUIBloxToastFoundationButtonSizing,
    useTokenizedShortcutBar = SharedFlags.FFlagEnableConsoleExpControls,
    disableTokenScaling = UIBlox.FFlagUIBloxDisableTokenScaling
}
