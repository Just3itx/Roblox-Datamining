-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local AppStartupParent = script:FindFirstAncestor("AppStartup").Parent
local Dash = require(AppStartupParent.Dash)
local React = require(AppStartupParent.React)

local AppLinking = require(AppStartupParent.RoactServiceTags).AppLinking
local AppLogging = require(AppStartupParent.RoactServiceTags).AppLogging
local AppAppLifecycleObserverService = require(AppStartupParent.RoactServiceTags).AppAppLifecycleObserverService
local AppStartupMessageService = require(AppStartupParent.RoactServiceTags).AppStartupMessageService
local useRoactService = require(AppStartupParent.RobloxAppHooks).useRoactService
local useDispatch = require(AppStartupParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppStartupParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(AppStartupParent.Localization).Hooks.useLocalization
local useDesignTokens = require(AppStartupParent.Style).useDesignTokens
local AppPage = require(AppStartupParent.RobloxAppEnums).AppPage
local NavigateDown = require(AppStartupParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(AppStartupParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppStartupParent.RobloxAppNavigation).NavigationCommands else nil
local FocusNavigationUtils = require(AppStartupParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot

local bool1 = game:DefineFastFlag("ShowStartupMessageOnUnhide", false)
local engineFeature = game:GetEngineFeature("StartupMessageActionButtonEnabled")

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function useStartupMessageProps()
    local var1 = useRoactService(AppLinking)
    local var2 = useRoactService(AppLogging)
    local var3 = if bool1 then useRoactService(AppAppLifecycleObserverService) else nil
    local var4 = useRoactService(AppStartupMessageService)
    local screenSize = useSelector(selectScreenSize)
    local var6 = useDispatch()
    local overlayColor = useDesignTokens(function(arg1)
        return arg1.Color.Common.Scrim
    end)
    local var8, var9 = React.useState(false)
    local var10, var11 = React.useState(false)

    local var12 = if bool1 then React.useCallback(function()
        var9(false)
        var11(false)
    end, {}) else nil

    if bool1 then
        React.useEffect(function()
            if not var3 then
                return
            end

            local connection = var3.OnUnhide:Connect(var12)
            return function()
                if connection then
                    connection:Disconnect()
                end
            end
        end, { var3, var12 })
    end

    local startupMessage = var4:getStartupMessage()
    local displayStartupMessage = if startupMessage then not var8 else false
    local message = startupMessage or {}
    local titleLocalizationKey = message.titleLocalizationKey
    local bodyLocalizationKey = message.bodyLocalizationKey
    local actionButtonLocalizationKey = if engineFeature then message.actionButtonLocalizationKey else nil
    local loggingEventName = message.loggingEventName
    local var14 = message.links or {}

    local var15 = useLocalization(Dash.map(var14, function(arg1)
        return arg1.localizationKey
    end))
    local localizedLinks = Dash.reduce(var14, function(arg1, arg2, arg3)
        return Dash.append(arg1, {{ label = var15[arg3], url = arg2.url }})
    end, {})

    local date = message.date

    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local unixTimestamp = tonumber(message.date)
    if unixTimestamp then
        date = DateTime.fromUnixTimestamp(unixTimestamp):FormatUniversalTime("LL", robloxLocaleId)
    end

    local localizedStrings = useLocalization({
        titleText = titleLocalizationKey,
        bodyText = bodyLocalizationKey and { bodyLocalizationKey, date = date },
        buttonText = "CommonUI.Messages.Action.Dismiss",
        actionButtonText = actionButtonLocalizationKey
    })

    local onDismissed = React.useCallback(function()
        var9(true)
    end, {})

    local onOpenUrl = React.useCallback(function(detail: string, title: string)
        var1:isURLRegistered(detail):andThen(function(arg1)
            if arg1 then
                if var1:isInternalDlicEnabled() then
                    local var19 = var1:createInternalDlic(detail, var1.DeepLinkSource.LuaInternal)
                    var1:detectDeeplinkIntent(var19)
                    return
                end
                var1:detectURL(detail)
                return
            end

            local tbl1 = {
                name = AppPage.GenericWebPage,
                detail = detail,
                extraProps = { title = title }
            }

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                return
            end
            var6(NavigateDown(tbl1))
        end)
    end, { var6, var1 })

    local focusNavRef = useAppFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isAutoFocusRoot = true,
        isFocusable = not var8
    })

    React.useEffect(function()
        if var10 or not displayStartupMessage or not loggingEventName then
            return
        end

        var2:logEphemeralCounterEvent({
            eventName = loggingEventName,
            backends = { "EphemeralCounter" },
            lastUpdated = { 24, 2, 18 },
            description = "Startup Message Displayed Event"
        })

        var11(true)
    end, { var10, displayStartupMessage, loggingEventName })

    return {
        displayStartupMessage = displayStartupMessage,
        screenSize = screenSize,
        message = message,
        localizedStrings = localizedStrings,
        localizedLinks = localizedLinks,
        overlayColor = overlayColor,
        onDismissed = onDismissed,
        onOpenUrl = onOpenUrl,
        onActionButtonActivated = engineFeature and function() -- name: onActionButtonActivated
            var4:executeActionButton()
        end or nil,
        focusNavRef = focusNavRef
    }
end

return useStartupMessageProps
