-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState

local useNetworking = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Hooks.useNetworking
local sendAXCounterV2 = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).sendAXCounterV2

local Constants = require(AvatarExperienceCatalog.Constants)

local _createFaeFeatureAccessStore = require(script.Parent.createFaeFeatureAccessStore)

return function(arg1)
    local var1 = useNetworking()

    React.useEffect(function()
        if arg1.getFetchStatus(false) ~= "idle" then
            return
        end
        arg1.fetch(var1):catch(function(arg2)
            if arg2 then
                sendAXCounterV2(Constants.COUNTERS.FetchFaeFeatureAccessError)
            end
        end)
    end, { arg1, var1 })

    return {
        canClaimFaeItem = useSignalState(arg1.getCanClaimFaeItem),
        showFaeUpsell = useSignalState(arg1.getShowFaeUpsell),
        fetchStatus = useSignalState(arg1.getFetchStatus)
    }
end
