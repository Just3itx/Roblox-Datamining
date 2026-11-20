-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local UniversalAppPolicy = require(scriptParentParent.UniversalAppPolicy)

local SharedFlags = require(scriptParentParent.SharedFlags)
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagAppIaScrollAwayGuac = SharedFlags.FFlagAppIaScrollAwayGuac
local bool1 = game:DefineFastFlag("EnableFlyoutWithScrollAway2", false)
local FlyoutSidePanelIXP = require(scriptParentParent.SharedExperimentDefinition).FlyoutSidePanelIXP

local function getScrollAwayEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if FFlagAppIaScrollAway then not (FFlagAppIaScrollAwayGuac and not UniversalAppPolicy.getAppFeaturePolicies().getAppIaScrollAwayEnabled())
        and not not (bool1 and FlyoutSidePanelIXP.isScrollAwayEnabled()) else false
end

local var1 = nil

return function()
    if var1 == nil then
        var1 = getScrollAwayEnabled()
    end
    return var1
end
