-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)

local getTimeoutStatusStore = require(AvatarExperienceCommon.Stores.TimeoutStatusStore.getTimeoutStatusStore)
local showAvatarChangeFeatureRestriction = require(AvatarExperienceCommon.Utils.showAvatarChangeFeatureRestriction)

local function useAvatarChangeAcknowledgementPrompt(bool1: boolean)
    local timeoutStatusStore = getTimeoutStatusStore()

    React.useEffect(function()
        if not bool1 then
            return nil
        end

        local bool2 = false
        timeoutStatusStore.fetchStatusAsync():andThen(function(arg1)
            if not bool2 and arg1.requiresAcknowledgement then
                showAvatarChangeFeatureRestriction()
            end
        end)

        return function()
            bool2 = true
        end
    end, { bool1, timeoutStatusStore })
end

return useAvatarChangeAcknowledgementPrompt
