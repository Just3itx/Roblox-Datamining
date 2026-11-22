-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local RobloxAppEnums = require(ServerTriggeredModalsParent.RobloxAppEnums)
local CentralOverlay = require(ServerTriggeredModalsParent.CentralOverlay)
local DeepLink = require(ServerTriggeredModalsParent.DeepLink)
local useSignalState = require(ServerTriggeredModalsParent.SignalsReact).useSignalState
local useDispatch = require(ServerTriggeredModalsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local RoactServiceTags = require(ServerTriggeredModalsParent.RoactServiceTags)
local useRoactService = require(ServerTriggeredModalsParent.RobloxAppHooks).useRoactService
local RoactNavigation = require(ServerTriggeredModalsParent.RoactNavigation)
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)
local NotificationsUpsell = require(ServerTriggeredModalsParent.NotificationsUpsell)

local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay

local useModalSignalStore = require(ServerTriggeredModals.SignalStores.useModalSignalStore)
local Logger = require(ServerTriggeredModals.Logger)
local EntryPoint = require(ServerTriggeredModals.EntryPoint)
local fetchModalMetadata = require(ServerTriggeredModals.fetchModalMetadata)
local useHandleCustomModalCallback = require(ServerTriggeredModals.useHandleCustomModalCallback)

local FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals = SharedFlags.FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals
local FFlagEnableDeepLinkHistoryWithModalAPI = SharedFlags.FFlagEnableDeepLinkHistoryWithModalAPI
local FFlagSignalsNavP3hMisc = SharedFlags.FFlagSignalsNavP3hMisc
local withNavigationFocusIgnoringNavigation = if FFlagSignalsNavP3hMisc then require(ServerTriggeredModalsParent.RobloxAppNavigation).withNavigationFocusIgnoringNavigation else nil
local num1 = game:DefineFastInt("ServerTriggeredModalTrafficPercent", 0)
local bool1 = game:DefineFastFlag("LuaAppAvoidPushUpsellConflicts", false)

local function CheckForSduiModal(tbl1)
    local var1 = useRoactService(RoactServiceTags.RoactNetworking)
    local var2 = useDispatch()
    local var3 = useModalSignalStore()
    local var4 = useSignalState(var3.getMetadataGetter(EntryPoint.HomepageLaunch))
    local var5 = useSignalState(var3.getHasShownGetter(EntryPoint.HomepageLaunch))

    local var6 = nil
    if FFlagEnableDeepLinkHistoryWithModalAPI then
        local var7 = DeepLink.DeepLinkLuaReceiverStatusStore(false)
        var6 = useSignalState(var7.getDeepLinkLuaPostAuthReceiverStatus)
    end

    local var7 = nil
    local var8 = nil
    if bool1 then
        var7, var8 = React.useState(false)
    end

    local var9 = nil
    local var10 = nil
    if bool1 then
        var9, var10 = React.useState(false)
    end

    local isFocused = tbl1.isFocused
    local var11 = if FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then useHandleCustomModalCallback(EntryPoint.HomepageLaunch, var1) else nil

    if bool1 then
        React.useEffect(function()
            var10(true)
            NotificationsUpsell.setupPushNotificationsUpsell.ShouldShowUpsell(
                NotificationsUpsell.NotificationsUpsellConstants.ModalKey.PushUpsellHome,
                false
            ):andThen(
                function(arg1)
                    if arg1 then
                        var8(true)
                    end
                end
            ):catch(
                function(arg1)
                    Logger:error(`Failed to evaluate push upsell: {arg1}`)
                end
            ):finally(
                function()
                    var10(false)
                end
            )
        end, {})
    end

    local useEffect = React.useEffect

    local function func1()
        if num1 <= math.random(0, 99) then
            return
        end

        if FFlagEnableDeepLinkHistoryWithModalAPI and var6 ~= DeepLink.DeepLinkLuaPostAuthReceiverStatus.Ready then
            return
        end

        local var12 = fetchModalMetadata(var1, EntryPoint.HomepageLaunch):catch(function(arg1)
            Logger:error(`Failed to fetch modal metadata for home page launch: {arg1}`)
        end)

        return function()
            var12:cancel()
        end
    end

    local var12 = if FFlagEnableDeepLinkHistoryWithModalAPI then var6 else nil
    useEffect(func1, { var1, var12 })

    local useEffect2 = React.useEffect
    local function func2()
        if var5 or not var4 or not isFocused or bool1 and (var9 or var7) then
            return
        end

        var3.setHasShown(EntryPoint.HomepageLaunch, true)

        if not FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then
            var2(
                SetCentralOverlay(
                    CentralOverlayType.SduiModal,
                    {
                        sduiComponentConfig = var4.sduiConfig,
                        modalId = var4.modalId,
                        modalType = var4.modalType
                    }
                )
            )
            return
        end

        if var4.isCustomHandler then
            var11(var4)
            return
        end
        var2(
            SetCentralOverlay(
                CentralOverlayType.SduiModal,
                {
                    sduiComponentConfig = var4.sduiConfig,
                    modalId = var4.modalId,
                    modalType = var4.modalType
                }
            )
        )
    end

    local var13 = if FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then var11 else nil
    local var14 = if FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then var3 else nil
    local var15 = if bool1 then var9 else nil
    local var16 = if bool1 then var7 else nil
    useEffect2(func2, { var5, var4, isFocused, var2, var13, var14, var15, var16 })

    return nil
end

if FFlagSignalsNavP3hMisc then
    return withNavigationFocusIgnoringNavigation(CheckForSduiModal)
end

local var1 = RoactNavigation.withNavigationFocus(CheckForSduiModal)

return React.memo(var1)
