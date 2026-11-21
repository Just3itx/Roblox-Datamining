-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)

local getTimeoutStatusStore = AvatarExperienceCommon.Stores.getTimeoutStatusStore
local showAvatarChangeFeatureRestriction = AvatarExperienceCommon.Utils.showAvatarChangeFeatureRestriction
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local FFlagAXUseUFRForTimeoutPromptInApp = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXUseUFRForTimeoutPromptInApp

local function useCatalogPageTimeoutPrompt(current, callback: ((...any) -> (...any))?)
    local timeoutStatusStore = getTimeoutStatusStore()
    local var1 = useSignalState(timeoutStatusStore.getStatus)
    local var2 = useSignalState(timeoutStatusStore.getIsTimedOut)
    local var3 = React.useRef(false)
    local var4 = React.useRef(false)
    local var5 = React.useRef(current)
    var5.current = current

    React.useEffect(function()
        if not var4.current then
            var4.current = true
            timeoutStatusStore.fetchStatus()
        end
    end, {})

    React.useEffect(function()
        if not var1 or var3.current or not var4.current or not var1.details then
            return
        end

        var3.current = true
        if FFlagAXUseUFRForTimeoutPromptInApp then
            showAvatarChangeFeatureRestriction()
            return
        end
        var5.current.navigate(AvatarScreen.TimeoutStatusPrompt)
    end, { var1 })

    React.useEffect(function()
        if callback and var2 then
            callback()
        end
    end, { var2, callback })
end

return useCatalogPageTimeoutPrompt
