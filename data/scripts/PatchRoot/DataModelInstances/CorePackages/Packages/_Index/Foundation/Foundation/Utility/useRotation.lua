-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:30:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local _React = require(FoundationParent.React)
local useClock = require(FoundationParent.ReactUtils).useClock

local function useRotation(num1: number?)
    return useClock():map(function(num2: number): number
        return num2 * 360 * (num1 or 1)
    end)
end

return useRotation
