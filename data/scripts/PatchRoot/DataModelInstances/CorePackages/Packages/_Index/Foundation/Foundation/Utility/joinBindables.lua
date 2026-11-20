-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function joinBindables(tbl1, func1: (...any) -> (...any))
    local tbl2 = ({})
    local tbl3 = ({})
    local bool1 = false

    for value, value2 in tbl1 do
        if ReactIs.isBinding(value2) then
            tbl2[value] = value2
            bool1 = true
        else
            tbl3[value] = value2
        end
    end

    if not bool1 then
        return func1(tbl3)
    end

    return React.joinBindings(tbl2):map(function(arg1)
        local var1 = table.clone(tbl3)
        for value, value2 in arg1 do
            var1[value] = value2
        end
        return func1(var1)
    end)
end

return joinBindables
