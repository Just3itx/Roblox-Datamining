-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getPresetIconSize = require(script.Parent.getPresetIconSize)

local function getPresetIconRichText(num1: number): string
    return `<font size='{getPresetIconSize(num1)}' weight='700' family='rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json'>lightning-bolt</font>`
end

return getPresetIconRichText
