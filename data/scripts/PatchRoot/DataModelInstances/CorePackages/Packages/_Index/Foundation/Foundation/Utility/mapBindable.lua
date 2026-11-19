-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:03Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local _React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function mapBindable(arg1, func1: (...any) -> (...any))
    if ReactIs.isBinding(arg1) then
        return arg1:map(func1)
    end
    return func1(arg1)
end

return mapBindable
