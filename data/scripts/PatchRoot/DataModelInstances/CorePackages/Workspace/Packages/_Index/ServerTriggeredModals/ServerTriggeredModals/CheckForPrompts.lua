-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local RobloxAppEnums = require(ServerTriggeredModalsParent.RobloxAppEnums)
local CentralOverlay = require(ServerTriggeredModalsParent.CentralOverlay)
local useSignalState = require(ServerTriggeredModalsParent.SignalsReact).useSignalState
local useDispatch = require(ServerTriggeredModalsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local RoactNavigation = require(ServerTriggeredModalsParent.RoactNavigation)
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)
local SduiSharedUtilities = require(ServerTriggeredModalsParent.SduiSharedUtilities)

local AppPage = RobloxAppEnums.AppPage
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore

local useModalSignalStore = require(ServerTriggeredModals.SignalStores.useModalSignalStore)
local EntryPoint = require(ServerTriggeredModals.EntryPoint)
local fetchPrompts = require(ServerTriggeredModals.SduiV2.fetchPrompts)
local PromptsEntryPoint = require(ServerTriggeredModals.SduiV2.PromptsEntryPoint)
local PromptStyle = require(ServerTriggeredModals.SduiV2.PromptStyle)
local usePromptEntries = require(ServerTriggeredModals.SduiV2.usePromptEntries)
local logPromptModalSkipped = require(ServerTriggeredModals.logPromptModalSkipped)
local FFlagPromptsModalSkipTelemetry = require(ServerTriggeredModals.Flags.FFlagPromptsModalSkipTelemetry)

local FFlagSduiAllowNoConfigsBuilt = SharedFlags.FFlagSduiAllowNoConfigsBuilt
local FFlagEnableHomepagePromptsForModalsAndBanners = SharedFlags.FFlagEnableHomepagePromptsForModalsAndBanners
local FFlagPromptsImpressionUsesTitle = SharedFlags.FFlagPromptsImpressionUsesTitle
local FFlagSignalsNavP3hMisc = SharedFlags.FFlagSignalsNavP3hMisc
local withNavigationFocusIgnoringNavigation = if FFlagSignalsNavP3hMisc then require(ServerTriggeredModalsParent.RobloxAppNavigation).withNavigationFocusIgnoringNavigation else nil

local function isValidPromptEntry(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (tbl1 == nil or tbl1.config == nil or tbl1.identifier == nil or tbl1.robloxComponentType == nil)
        and tbl1.title ~= nil
end

local function CheckForPrompts(tbl1)
    local var1 = useDispatch()
    local var2 = useModalSignalStore()
    local var3 = useSignalState(var2.getMetadataGetter(EntryPoint.HomepageLaunch))
    local var4 = useSignalState(var2.getHasShownGetter(EntryPoint.HomepageLaunch))
    local isFocused = tbl1.isFocused

    local var5 = React.useMemo(function()
        return {
            entryPoint = PromptsEntryPoint.HomepageLaunch,
            surfaceKey = "HomepagePrompts",
            configKey = "HomepagePrompts",
            clearOnEmptyResponse = true,
            allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then true else nil,
            loadTimer = SduiLoadTimer.createLoadTimer("HomepagePrompts"),
            clientAttributes = nil,
            replaceOnFetch = nil,
            promptStyles = nil
        }
    end, {})

    React.useEffect(function()
        fetchPrompts(var5)
    end, { var5 })

    local var6 = nil
    local var7

    if FFlagEnableHomepagePromptsForModalsAndBanners then
        var6 = usePromptEntries("HomepagePrompts", PromptStyle.Modal)
        var7 = var6[1]
    else
        local var8 = React.useCallback(function(arg1)
            local var8 = getSduiApiStore().getData("HomepagePrompts").data(arg1)
            return var8 and var8.HomepagePrompts
        end, {})
        var7 = useSignalState(var8)
    end

    local var8 = if FFlagPromptsModalSkipTelemetry then var6 else nil

    React.useEffect(function()
        if var4 then
            if FFlagPromptsModalSkipTelemetry then
                logPromptModalSkipped.logAll(logPromptModalSkipped.Reason.AlreadyShown, EntryPoint.HomepageLaunch, var6 or { var7 })
            end

            return
        end

        if var3 then
            if FFlagPromptsModalSkipTelemetry then
                logPromptModalSkipped.logAll(logPromptModalSkipped.Reason.LegacyMetadata, EntryPoint.HomepageLaunch, var6 or { var7 })
            end

            return
        end

        if not isFocused then
            if FFlagPromptsModalSkipTelemetry then
                logPromptModalSkipped.logAll(logPromptModalSkipped.Reason.NotFocused, EntryPoint.HomepageLaunch, var6 or { var7 })
            end

            return
        end

        if not isValidPromptEntry(var7) then
            if FFlagPromptsModalSkipTelemetry and var7 ~= nil then
                logPromptModalSkipped.log(logPromptModalSkipped.Reason.IncompleteEntry, EntryPoint.HomepageLaunch, var7)
            end

            return
        end

        var2.setHasShown(EntryPoint.HomepageLaunch, true)
        if FFlagPromptsModalSkipTelemetry then
            logPromptModalSkipped.markShown(EntryPoint.HomepageLaunch, var7)
        end
        var1(
            SetCentralOverlay(CentralOverlayType.SduiPromptModal, {
                configKey = "HomepagePrompts",
                appPage = AppPage.Home,
                modalId = var7.identifier,
                modalType = if FFlagPromptsImpressionUsesTitle then var7.title else var7.robloxComponentType
            })
        )
    end, {
        var4,
        var3,
        isFocused,
        var1,
        var2,
        var7,
        var8
    })
    return nil
end

if FFlagSignalsNavP3hMisc then
    return withNavigationFocusIgnoringNavigation(CheckForPrompts)
end

local var1 = RoactNavigation.withNavigationFocus(CheckForPrompts)

return React.memo(var1)
