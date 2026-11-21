-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Players = game:GetService("Players")

local React = require(AvatarExperienceCatalogParent.React)
local useAvatarRoute = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).AvatarRoute.Hooks.useAvatarRoute

local FFlagAXCatalogOffersClearOnLogout = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXCatalogOffersClearOnLogout

local _createCatalogOffersBannerStore = require(AvatarExperienceCatalog.Stores.createCatalogOffersBannerStore)
local catalogOffersBannerImpressionsStore = require(AvatarExperienceCatalog.Stores.catalogOffersBannerImpressionsStore)
local getLocalUserId = require(AvatarExperienceCatalog.Utils.getLocalUserId)

local function useCatalogOffersBannerOffersFetch(arg1, arg2)
    if FFlagAXCatalogOffersClearOnLogout then
        React.useEffect(function()
            local var1 = if arg1.getHasCompletedOffersFetch(false) or arg1.getOffersFetchInProgress(false) then nil else arg1.fetchOffers(arg2)

            local localUserId = getLocalUserId(Players)

            local function handle()
                local localUserId2 = getLocalUserId(Players)
                if localUserId2 == localUserId then
                    return
                end
                localUserId = localUserId2

                if var1 then
                    var1()
                    var1 = nil
                end
                arg1.setPayload(nil)
                arg1.setDismissed(false)

                catalogOffersBannerImpressionsStore.clearOfferIds()

                if localUserId2 ~= nil and localUserId2 ~= "-1" then
                    var1 = arg1.fetchOffers(arg2)
                end
            end

            local connection = nil
            local function bindUserIdSignal() -- Luacid: Inlined by compiler; 2 call sites recovered
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
                local localPlayer = Players.LocalPlayer
                if localPlayer ~= nil then
                    connection = localPlayer:GetPropertyChangedSignal("UserId"):Connect(handle)
                end
            end

            bindUserIdSignal()

            local connection2 = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
                bindUserIdSignal()
                handle()
            end)

            return function()
                if var1 then
                    var1()
                    var1 = nil
                end
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
                connection2:Disconnect()
            end
        end, { arg1, arg2 })
    else
        React.useEffect(function()
            if arg1.getHasCompletedOffersFetch(false) or arg1.getOffersFetchInProgress(false) then
                return function() end
            end

            return arg1.fetchOffers(arg2)
        end, { arg2, arg1 })
    end

    local var1 = React.useRef(true)
    local var2 = useAvatarRoute()
    React.useEffect(function()
        local isVisible = not (var2 == nil) and var2.isVisible

        if isVisible and not var1.current then
            arg1.fetchOffers(arg2)
        end

        var1.current = isVisible
    end, { arg2, arg1, var2 })
end

return useCatalogOffersBannerOffersFetch
