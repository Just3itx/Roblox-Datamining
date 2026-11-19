-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")

local RobloxGui = CoreGui.RobloxGui
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider
local React = require(CorePackages.Packages.React)
local requestInternalWrapper = require(CorePackages.Workspace.Packages.Http).NetworkLayers.requestInternalWrapper
local RoactNetworking = require(CorePackages.Workspace.Packages.RoactServiceTags).RoactNetworking
local RoactServices = require(CorePackages.Workspace.Packages.RoactServices).RoactServices

local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local useRegistryEntry = FocusNavigationUtils.FocusNavigableSurfaceRegistry.useRegistryEntry

local DynamicReportInExpContainer = require(CorePackages.Workspace.Packages.GenericAbuseReporting.DynamicReportInExpContainer)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local useCaptureScreenshotV2 = require(AbuseReportMenu.Hooks.useCaptureScreenshotV2)
local useSettingsHubCloseButton = require(script.Parent.useSettingsHubCloseButton)
local isAbuseReportMenuOpenCloseSignalEnabled = require(AbuseReportMenu.Flags.isAbuseReportMenuOpenCloseSignalEnabled)
local FFlagReportFocusNavCloseButton = require(AbuseReportMenu.Flags.FFlagReportFocusNavCloseButton)

local FIntAbuseReportTabClearCapturedScreenshotOnCloseFixDelay = require(AbuseReportMenu.Flags.FIntAbuseReportTabClearCapturedScreenshotOnCloseFixDelay)
local safetyServiceSignals = require(script.Parent.safetyServiceSignals)

local inExpChatMessagesLoader = require(script.Parent.inExpChatMessagesLoader)
local inExpVoiceUsersLoader = require(script.Parent.inExpVoiceUsersLoader)

local setTimeout = require(CorePackages.Packages.LuauPolyfill).setTimeout

local function shouldEmitMenuOpenCloseSignal() -- Luacid: Inlined by compiler; 2 call sites recovered
    return isAbuseReportMenuOpenCloseSignalEnabled()
end

local function AbuseReportMenuContentInner(tbl1)
    local isFocusable = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.CentralOverlay) == nil
    local var1, var2

    if FFlagReportFocusNavCloseButton then
        var1, var2 = useSettingsHubCloseButton(tbl1.getSettingsHubRef, tbl1.isReportTabVisible)
    else
        var1 = nil
        var2 = nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0)
    }
    local tbl3 = {
        FocusNavigationCoreScriptsWrapper = React.createElement(FocusRoot, {
            frameProps = {
                Size = UDim2.new(1, 0, 1, 0),
                SelectionBehaviorUp = if FFlagReportFocusNavCloseButton and var1 ~= nil then Enum.SelectionBehavior.Escape else nil,
                NextSelectionUp = var1
            },
            isFocusable = isFocusable,
            isAutoFocusRoot = not (FFlagReportFocusNavCloseButton and var2),
            isIsolated = true,
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.RouterView
        }, {
            DynamicReportInExpContainer = React.createElement(DynamicReportInExpContainer, {
                onClose = tbl1.onClose,
                isReportTabVisible = tbl1.isReportTabVisible,
                reportAnythingSnapshotRef = tbl1.reportAnythingSnapshotRef,
                inExpChatMessagesLoader = inExpChatMessagesLoader,
                inExpVoiceUsersLoader = inExpVoiceUsersLoader,
                voiceChatServiceManager = default,
                preselectedPlayer = tbl1.preselectedPlayer,
                onReportFinish = tbl1.onReportFinish
            })
        })
    }
    return createElement(str1, tbl2, tbl3)
end

local function AbuseReportMenuContent(tbl1)
    local isReportTabVisible, var2 = React.useState(false)
    local preselectedPlayer, var4 = React.useState(nil)

    local var5 = useCaptureScreenshotV2()

    local var6 = React.useRef(tbl1.hideReportTab)
    var6.current = tbl1.hideReportTab
    local var7 = React.useRef(tbl1.showReportTab)
    var7.current = tbl1.showReportTab

    local var8 = React.useRef(false)

    local var9 = React.useRef(false)

    React.useEffect(function()
        tbl1.registerOnReportTabDisplaying(function() -- name: onOpen
            if var8.current then
                return
            end

            var8.current = true
            var2(true)
            var5.captureIfApplicable({ hide = var6.current, show = var7.current })
        end)
        tbl1.registerOnReportTabHidden(function()
            if var5.getIsCapturing() then
                return
            end

            var8.current = false
            var9.current = false
            var2(false)
            var4(nil)

            if shouldEmitMenuOpenCloseSignal() then
                safetyServiceSignals.reportMenuTabClose()
            end
        end)

        tbl1.registerSetNextPlayerToReport(function(arg1)
            var4(arg1)
        end)

        tbl1.registerOnSettingsHidden(function()
            setTimeout(function()
                if not var8.current then
                    var5.reset()
                end
            end, FIntAbuseReportTabClearCapturedScreenshotOnCloseFixDelay)
        end)
    end, {
        tbl1.registerOnReportTabHidden,
        tbl1.registerSetNextPlayerToReport,
        tbl1.registerOnSettingsHidden,
        tbl1.registerOnReportTabDisplaying,
        var5.captureIfApplicable,
        var5.getIsCapturing,
        var5.reset
    })

    React.useEffect(function()
        if isReportTabVisible
            and not var9.current
            and shouldEmitMenuOpenCloseSignal()
            and (not var5.isCaptureApplicable or var5.isScreenshotTaken)
        then
            var9.current = true
            safetyServiceSignals.reportMenuTabOpen()
        end
    end, { isReportTabVisible, var5.isScreenshotTaken, var5.isCaptureApplicable })

    local createElement = React.createElement
    local func1 = AbuseReportMenuContentInner
    local tbl2 = {
        isReportTabVisible = isReportTabVisible,
        preselectedPlayer = preselectedPlayer,
        reportAnythingSnapshotRef = var5.snapshotRef,
        getSettingsHubRef = if FFlagReportFocusNavCloseButton then tbl1.getSettingsHubRef else nil,
        onClose = tbl1.hideReportTab,
        onReportFinish = 0
    }

    function tbl2.onReportFinish()
        var4(nil)
    end

    return createElement(func1, tbl2)
end

local function AbuseReportMenu2(tbl1)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    return React.createElement(
        CoreScriptsRootProvider,
        nil,
        React.createElement(LocalizationProvider, { localization = localization }, {
            ServicesProvider = React.createElement(
                RoactServices.ServiceProvider,
                {
                    services = {
                        [RoactNetworking] = requestInternalWrapper(HttpService)
                    }
                },
                {
                    AbuseReportMenuContent = React.createElement(AbuseReportMenuContent, tbl1)
                }
            )
        })
    )
end
return AbuseReportMenu2
