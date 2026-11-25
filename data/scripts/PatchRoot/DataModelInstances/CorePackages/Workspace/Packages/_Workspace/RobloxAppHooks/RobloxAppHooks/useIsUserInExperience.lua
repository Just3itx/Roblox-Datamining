-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent

local ExperienceService = require(RobloxAppHooksParent.ExperienceService).ExperienceService
local React = require(RobloxAppHooksParent.React)

local function useIsUserInExperience(bool1: boolean?)
    local var1, var2 = React.useState(bool1 or false)
    React.useEffect(function()
        local tbl1 = {
            ExperienceService:RegisterForExperienceJoin(function()
                var2(true)
            end),
            ExperienceService:RegisterForExperienceLeave(function()
                var2(false)
            end)
        }

        return function()
            for _, value in tbl1 do
                if value and value.Disconnect then
                    value:Disconnect()
                end
            end
        end
    end, {})
    return var1
end

return useIsUserInExperience
