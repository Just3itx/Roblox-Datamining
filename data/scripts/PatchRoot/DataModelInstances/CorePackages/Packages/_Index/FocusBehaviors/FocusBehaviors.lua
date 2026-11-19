-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:01:29Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _FocusNavigation = require(scriptParent.FocusNavigation)

local composeFocusBehaviors = require(script.composeFocusBehaviors)

local function defaultDescendantBehavior(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        getTargets = function(): {[any]: any} | {any}
            return if arg1 then { arg1 } else {}
        end
    }
end

local function mostRecentDescendantBehavior()
    local var1 = nil

    return {
        onDescendantFocusChanged = function(arg1)
            var1 = arg1 or var1
        end,
        getTargets = function(): {[any]: any} | {any}
            return if var1 then { var1 } else {}
        end
    }
end

return {
    default = defaultDescendantBehavior,
    mostRecent = mostRecentDescendantBehavior,
    mostRecentOrDefault = function(arg1) -- name: mostRecentDescendantOrDefaultBehavior
        local tbl1 = defaultDescendantBehavior(arg1)
        return composeFocusBehaviors(mostRecentDescendantBehavior(), tbl1)
    end,
    composeFocusBehaviors = composeFocusBehaviors
}
