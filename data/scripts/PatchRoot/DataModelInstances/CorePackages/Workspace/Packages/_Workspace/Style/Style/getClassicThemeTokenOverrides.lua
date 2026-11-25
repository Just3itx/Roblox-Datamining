-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StyleParent = script:FindFirstAncestor("Style").Parent

local Foundation = require(StyleParent.Foundation)
local ColorMode = Foundation.Enums.ColorMode
local ThemeName = Foundation.Enums.ThemeName

local tbl1 = {
    ["Color.ActionEmphasis.Background.Color3"] = Color3.fromHex("#137F1F"),
    ["Color.ActionSoftEmphasis.Background.Color3"] = Color3.fromHex("#137F1F"),
    ["Color.ActionSoftEmphasis.Foreground.Color3"] = Color3.fromHex("#E2F8E3")
}

local tbl2 = {
    ["Color.ActionEmphasis.Background.Color3"] = Color3.fromHex("#12891D"),
    ["Color.ActionEmphasis.Foreground.Color3"] = Color3.fromHex("#FFFFFF"),
    ["Color.ActionSoftEmphasis.Background.Color3"] = Color3.fromHex("#12891D"),
    ["Color.ActionSoftEmphasis.Foreground.Color3"] = Color3.fromHex("#022708")
}

local function getClassicThemeTokenOverrides(classic, light): {[any]: any}?
    return if classic == ThemeName.Classic then if light == ColorMode.Light then tbl2 else tbl1 else nil
end

return getClassicThemeTokenOverrides
