-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local _React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function getBindableValue(arg1)
    if ReactIs.isBinding(arg1) then
        return arg1:getValue()
    end
    return arg1
end

return getBindableValue
