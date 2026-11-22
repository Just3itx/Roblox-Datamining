-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local RoactNavigation = require(ServerTriggeredModalsParent.RoactNavigation)
local Signals = require(ServerTriggeredModalsParent.Signals)
local SignalsReact = require(ServerTriggeredModalsParent.SignalsReact)
local default = require(ServerTriggeredModalsParent.LinkingProtocol).LinkingProtocol.default
local LocalUserIdStore = require(ServerTriggeredModalsParent.LocalUserIdStore).LocalUserIdStore
local RobloxSubscriptionPurchaseApp = require(ServerTriggeredModalsParent.RobloxSubscriptionPurchaseApp)
local useSelector = require(ServerTriggeredModalsParent.RoactUtils).Hooks.RoactRodux.useSelector
local Logger = require(ServerTriggeredModals.Logger)
local reportPromptImpression = require(ServerTriggeredModals.reportPromptImpression)
local sendModalImpressionEvent = require(ServerTriggeredModalsParent.ServerTriggeredModalImpressions).sendModalImpressionEvent
local PromptsEntryPoint = require(script.Parent.PromptsEntryPoint)
local _PromptsTypes = require(script.Parent.Types.PromptsTypes)
local _createModalSignalStore = require(ServerTriggeredModals.SignalStores.createModalSignalStore)
local _EntryPoint = require(ServerTriggeredModals.EntryPoint)

local FFlagRobloxSubscriptionOnboardingSheet = require(ServerTriggeredModalsParent.SharedFlags).FFlagRobloxSubscriptionOnboardingSheet

local initiateRobloxSubscriptionPurchase = RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local RobloxPlusSheetKind = RobloxSubscriptionPurchaseApp.RobloxPlusSheetKind
local RobloxSubscriptionFlowCompleteReason = RobloxSubscriptionPurchaseApp.RobloxSubscriptionFlowCompleteReason

local tbl1 = ({})

local var1, var2 = Signals.createSignal(nil)

local function useIsScreenFocused()
    local var3 = React.useContext(RoactNavigation.Context)
    local var4, var5 = React.useState(not (var3 == nil) and var3.isFocused())

    React.useEffect(function()
        if var3 == nil then
            var5(false)
            return
        end

        local var6 = var3.addListener(RoactNavigation.Events.WillFocus, function()
            var5(true)
        end)
        local var7 = var3.addListener(RoactNavigation.Events.WillBlur, function()
            var5(false)
        end)
        var5(var3.isFocused())

        return function()
            var6.remove()
            var7.remove()
        end
    end, { var3 })

    return var4
end

return {
    handlePromptsResponse = function(arg1)
        if type(arg1) ~= "table" then
            return
        end

        local customPrompts = arg1.custom_prompts
        if type(customPrompts) ~= "table" or customPrompts.PlusUpsellSheetHomeLaunch == nil then
            return
        end

        local currentUserId = LocalUserIdStore.getCurrentUserId(false)
        if currentUserId == "" or tbl1[currentUserId] then
            return
        end
        tbl1[currentUserId] = true
        var2(currentUserId)
    end,
    usePlusUpsellSheetPrompt = function(tbl2)
        local entryPoint = tbl2.entryPoint
        local hasShownKey = tbl2.hasShownKey
        local modalSignalStore = tbl2.modalSignalStore

        local var3 = SignalsReact.useSignalState(var1)
        local var4 = useIsScreenFocused()
        local var5 = useSelector(function(arg1)
            return arg1.CentralOverlay and arg1.CentralOverlay.OverlayType
        end)

        React.useEffect(function()
            if entryPoint ~= PromptsEntryPoint.HomepageLaunch or var3 == nil then
                return
            end

            if not var4 or var5 ~= nil then
                return
            end

            if var1(false) ~= var3 then
                return
            end

            if modalSignalStore.getHasShownGetter(hasShownKey)(false) or modalSignalStore.getMetadataGetter(hasShownKey)(false) then
                return
            end

            if var3 ~= LocalUserIdStore.getCurrentUserId(false) then
                var2(nil)
                return
            end

            var2(nil)
            modalSignalStore.setHasShown(hasShownKey, true)

            initiateRobloxSubscriptionPurchase(
                {
                    sheetKind = RobloxPlusSheetKind.TT
                },
                FFlagRobloxSubscriptionOnboardingSheet and {
                    onFlowComplete = function(upsellPurchaseSucceeded)
                        if upsellPurchaseSucceeded ~= RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded then
                            return
                        end

                        default:detectURL("roblox://navigation/plus_onboarding")
                    end
                } or nil,
                nil,
                SurfaceName.HomepageLaunchPrompt,
                SurfaceContext.InApp
            )

            reportPromptImpression("PlusUpsellSheetHomeLaunch", "PlusUpsellSheetHomeLaunch"):catch(function()
                Logger:warning("Failed to report Plus upsell sheet prompt impression")
            end)
            sendModalImpressionEvent("PlusUpsellSheetHomeLaunch", "PlusUpsellSheetHomeLaunch")
        end, {
            entryPoint,
            var3,
            var4,
            var5,
            modalSignalStore,
            hasShownKey
        })
    end,
    resetForTests = function()
        table.clear(tbl1)
        var2(nil)
    end
}
