-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)

local function createBuildExperienceRefreshStore()
    local getRefreshTick, var2 = Signals.createSignal(0)

    return {
        getRefreshTick = getRefreshTick,
        bumpRefreshTick = function()
            var2(function(num1: number): number
                return num1 + 1
            end)
        end
    }
end

return createBuildExperienceRefreshStore
