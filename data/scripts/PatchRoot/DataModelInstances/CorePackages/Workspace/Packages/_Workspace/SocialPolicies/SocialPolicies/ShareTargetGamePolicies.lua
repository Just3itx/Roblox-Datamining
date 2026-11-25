-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function ShareTargetGamePolicies(arg1)
    return {
        shouldShowCreatorName = function()
            local showShareTargetGameCreator = arg1.ShowShareTargetGameCreator
            return not (showShareTargetGameCreator == nil) and showShareTargetGameCreator
        end
    }
end

return ShareTargetGamePolicies
