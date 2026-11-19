-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local LocalizationService = game:GetService("LocalizationService")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local isTenFootInterface = require(CorePackages.Workspace.Packages.AppCommonLib).isTenFootInterface
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local SduiFeatureEntryPoint = require(CorePackages.Workspace.Packages.SduiSharedUtilities).SduiFeatureEntryPoint
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)

local SduiInExperienceHost = require(script.Parent.SduiInExperienceHost)

local var1 = nil

local function getLocalization() -- Luacid: Inlined by compiler; 1 call site recovered
    if var1 == nil then
        var1 = Localization.new(LocalizationService.RobloxLocaleId)
    end
    return var1
end

local function getDefaultDevice() -- Luacid: Inlined by compiler; 1 call site recovered
    if isTenFootInterface() then
        return Foundation.Enums.Device.Console
    end

    return Foundation.Enums.Device.Desktop
end

local function wrapProvider(arg1, tbl1, child) -- Luacid: Inlined by compiler; 4 call sites recovered
    return React.createElement(arg1, tbl1, { Child = child })
end

return React.memo(React.forwardRef(function(tbl1, ref) -- name: SduiInExperienceEntryPoint
    local element = React.createElement(SduiFeatureEntryPoint, {
        configKey = tbl1.configKey,
        identifier = tbl1.identifier,
        appPage = tbl1.surfaceKey,
        routeName = tbl1.routeName,
        additionalAnalyticsData = tbl1.additionalAnalyticsData,
        loadTimer = tbl1.loadTimer,
        onRetry = tbl1.onRetry,
        errorSlot = tbl1.errorSlot,
        loadingSlot = tbl1.loadingSlot,
        shouldDisplayLoading = tbl1.shouldDisplayLoading,
        shouldDisplayError = tbl1.shouldDisplayError,
        onAbsoluteSizeChange = tbl1.onAbsoluteSizeChange,
        extraLocalProps = tbl1.extraLocalProps,
        LayoutOrder = tbl1.LayoutOrder,
        Size = tbl1.Size,
        AutomaticSize = tbl1.AutomaticSize,
        Position = tbl1.Position,
        ref = ref
    })

    if not tbl1.disableAppPolicyProvider then
        element = wrapProvider(
            UniversalAppPolicy.RoactAppPolicy.Provider,
            {
                policy = { UniversalAppPolicy.AppFeaturePolicies }
            },
            element
        )
    end

    local var2 = wrapProvider(SduiInExperienceHost, { surfaceKey = tbl1.surfaceKey }, element)

    if not tbl1.disableLocalizationProvider then
        var2 = wrapProvider(LocalizationProvider, { localization = getLocalization() }, var2)
    end

    if not tbl1.disableFoundationProvider then
        var2 = wrapProvider(
            Foundation.FoundationProvider,
            {
                colorMode = tbl1.colorMode or Foundation.Enums.ColorMode.Dark,
                device = tbl1.device or getDefaultDevice()
            },
            var2
        )
    end

    return var2
end))
