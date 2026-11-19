-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:20:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function indexBindable(arg1, str1: string)
    if ReactIs.isBinding(arg1) then
        return arg1:map(function(arg2)
            return arg2[str1]
        end)
    end

    return arg1[str1]
end

return indexBindable
