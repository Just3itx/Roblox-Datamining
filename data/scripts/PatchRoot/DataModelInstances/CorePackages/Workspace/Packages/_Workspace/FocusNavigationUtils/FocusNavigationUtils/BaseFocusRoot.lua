-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent

local React = require(FocusNavigationUtilsParent.React)
local Cryo = require(FocusNavigationUtilsParent.Cryo)

local tbl1 = {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    SelectionGroup = true
}

local tbl2 = {
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop
}

return React.forwardRef(function(tbl3, ref) -- name: BaseFocusRoot
    local var1 = Cryo.Dictionary.join(tbl1, tbl3.frameProps or {}, { ref = ref })
    if tbl3.isIsolated then
        var1 = Cryo.Dictionary.union(tbl2, var1)
    end

    return React.createElement("Frame", var1, tbl3.children)
end)
