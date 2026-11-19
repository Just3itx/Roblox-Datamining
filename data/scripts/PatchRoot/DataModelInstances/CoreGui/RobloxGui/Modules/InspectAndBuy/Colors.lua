-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local AppCommonLibColor = require(CorePackages.Workspace.Packages.AppCommonLib).Color

local tbl1 = {
    Obsidian = AppCommonLibColor.Color3FromHex(1579291),
    Carbon = AppCommonLibColor.Color3FromHex(2040099),
    Slate = AppCommonLibColor.Color3FromHex(2303271),
    Flint = AppCommonLibColor.Color3FromHex(3750717),
    Graphite = AppCommonLibColor.Color3FromHex(6645352),
    Pumice = AppCommonLibColor.Color3FromHex(12435134),
    Black = Color3.fromRGB(0, 0, 0),
    White = Color3.fromRGB(255, 255, 255),
    Gray1 = AppCommonLibColor.Color3FromHex(1644825),
    Gray2 = AppCommonLibColor.Color3FromHex(7697781),
    Gray4 = AppCommonLibColor.Color3FromHex(14935011),
    GrayBackground = AppCommonLibColor.Color3FromHex(14211288),
    Green = AppCommonLibColor.Color3FromHex(45167),
    DisabledGreen = AppCommonLibColor.Color3FromHex(10273956)
}

setmetatable(tbl1, {
    __newindex = function(_, _, _) end,
    __index = function(_, arg1)
        error("Colors table has no value: " .. tostring(arg1))
    end
})

return tbl1
