-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)

local GamePlayButtonParent = GamePlayButton.Parent
local React = require(GamePlayButtonParent.React)
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(GamePlayButtonParent.RoactServiceTags).AppEventIngestService
local useDispatch = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local unlockPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.unlockPlayIntent
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)
local CloudClientOffer = require(GamePlayButtonParent.CloudClientOffer)
local GetFFlagLuaAppEnableVirtualEventPlaceId = require(GamePlayButtonParent.SharedFlags).GetFFlagLuaAppEnableVirtualEventPlaceId

return function(universeId: string?, str2: string?, str3: string?, str4: string?, pageName: string?, callback: string?)
    local var1 = useRoactService(AppEventIngestService)
    local var2 = useDispatch()
    local var3 = React.useRef(nil)

    React.useEffect(function()
        return function()
            local current = var3.current
            if current ~= nil then
                CloudClientOffer.GetCloudClientOfferStore(false).cancel(current)
            end
        end
    end, {})

    return React.useCallback(function(func1: ((...any) -> (...any))?, str6: string?, arg1)
        local fFlagLuaAppEnableVirtualEventPlaceId = GetFFlagLuaAppEnableVirtualEventPlaceId()
        local bool1 = if fFlagLuaAppEnableVirtualEventPlaceId then not (str2 == nil) and str3 ~= nil else str3 ~= nil

        if not bool1 or arg1 ~= nil and arg1.hasShownUpsell == true then
            callback(func1, str6, arg1)
            return
        end

        local var4 = if fFlagLuaAppEnableVirtualEventPlaceId then str2 else str3
        local cloudClientOfferStore = CloudClientOffer.GetCloudClientOfferStore(false)
        local current = cloudClientOfferStore.request(tostring(var4), function(arg2)
            var3.current = nil
            if arg2.kind ~= "Stream" then
                if arg2.kind == "Local" then
                    callback(func1, str6)
                end
                return
            end

            local cloudClientReservation = {
                reservationToken = arg2.offer.reservationToken,
                offerKind = arg2.offer.kind
            }
            callback(func1, str6, { cloudClientReservation = cloudClientReservation })
        end, function(arg2)
            var3.current = nil
            var2(CloudClientOffer.OpenCloudClientOfferSheet(cloudClientOfferStore, arg2))
            unlockPlayIntent(var1, {
                universeId = universeId,
                upsellName = arg2.kind,
                playabilityStatus = str4 and str4.playabilityStatus or nil,
                pageName = pageName
            })
        end)
        if current ~= nil then
            var3.current = current
        end
    end, {
        universeId,
        str2,
        str3,
        str4,
        pageName,
        callback,
        var2,
        var1
    })
end
