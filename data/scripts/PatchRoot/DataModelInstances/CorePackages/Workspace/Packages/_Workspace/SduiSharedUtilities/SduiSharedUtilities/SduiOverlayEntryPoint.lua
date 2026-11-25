-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local SduiFeatureEntryPoint = require(SduiSharedUtilities.SduiFeatureEntryPoint)

local function SduiOverlayEntryPoint(tbl1)
    return React.createElement(SduiFeatureEntryPoint, {
        configKey = tbl1.configKey,
        identifier = tbl1.identifier,
        appPage = tbl1.appPage or "Unknown",
        shouldDisplayLoading = false,
        shouldDisplayError = false
    })
end

return SduiOverlayEntryPoint
