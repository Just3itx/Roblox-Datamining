-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:01:30Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local function composeFocusBehaviors(...)
    local tbl1 = { ... }
    return {
        onDescendantFocusChanged = function(arg1)
            for _, value in tbl1 do
                if value.onDescendantFocusChanged then
                    value.onDescendantFocusChanged(arg1)
                end
            end
        end,
        getTargets = function()
            local targets = {}
            for _, value in tbl1 do
                for _, value2 in (value.getTargets()) do
                    table.insert(targets, value2)
                end
            end
            return targets
        end
    }
end

return composeFocusBehaviors
