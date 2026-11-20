-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local _ColorMode = require(Foundation.Enums.ColorMode)
local _Device = require(Foundation.Enums.Device)
local _ThemeName = require(Foundation.Enums.ThemeName)
local getGeneratedRules = require(Foundation.Utility.getGeneratedRules)

local function useGeneratedRules<T>(arg1: T, arg2: T, arg3: T)
    return React.useMemo(function()
        return getGeneratedRules(arg1, arg2, arg3)
    end, { arg1, arg2, arg3 })
end

return useGeneratedRules
