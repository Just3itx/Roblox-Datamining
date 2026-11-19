-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:40:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function useProgressBinding(arg1)
    if ReactIs.isBinding(arg1) then
        return arg1:map(function(num1: number): number
            return math.clamp(num1 / 100, 0, 1)
        end), arg1 == nil
    end

    local var1 = if arg1 == nil then nil else math.clamp(arg1 / 100, 0, 1)
    return var1, arg1 == nil
end

return useProgressBinding
