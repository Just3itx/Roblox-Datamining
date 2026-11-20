-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local _Types = require(Foundation.Components.Types)

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local function useDefaultTags(arg1, str1: string)
    return React.useMemo(function()
        if arg1 == nil then
            return str1
        end

        if type(arg1) == "string" then
            return `{str1} {arg1}`
        end

        return (Dash.join(arg1, { [str1] = true }))
    end, { arg1, str1 })
end

return useDefaultTags
