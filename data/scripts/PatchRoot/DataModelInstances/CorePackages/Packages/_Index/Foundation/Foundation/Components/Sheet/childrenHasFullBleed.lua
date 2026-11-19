-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:50:31Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local FullBleed = require(script.Parent.FullBleed)

local function getElementType(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if type(arg1) == "table" then arg1.type else nil
end

local function childrenHasFullBleed(arg1): boolean
    local bool1 = false
    React.Children.forEach(arg1, function(arg2)
        if getElementType(arg2) == FullBleed then
            bool1 = true
        end
    end)
    return bool1
end

return childrenHasFullBleed
