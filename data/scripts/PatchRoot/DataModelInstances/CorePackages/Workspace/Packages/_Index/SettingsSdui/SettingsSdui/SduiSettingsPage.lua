-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingsSdui = script:FindFirstAncestor("SettingsSdui")
local SettingsSduiParent = SettingsSdui.Parent

local AppPage = require(SettingsSduiParent.RobloxAppEnums).AppPage
local CompositionTags = require(SettingsSduiParent.AppComposition).CompositionTags
local React = require(SettingsSduiParent.React)
local SduiSharedUtilities = require(SettingsSduiParent.SduiSharedUtilities)
local FFlagSduiSettingsFocusRef = require(SettingsSduiParent.SharedFlags).FFlagSduiSettingsFocusRef

local SduiPageWrapperEntryPoint = SduiSharedUtilities.SduiPageWrapperEntryPoint
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef

local SettingsSduiConstants = require(SettingsSdui.SettingsSduiConstants)
local fetchSettingsPage = require(SettingsSdui.fetchSettingsPage)

local Settings = AppPage.Settings
local ConfigKey = SettingsSduiConstants.ConfigKey
local SurfaceLoadTimeEventName = SettingsSduiConstants.SurfaceLoadTimeEventName

local composition = {
    layout = CompositionTags.Layout.Detail
}

return React.memo(function(tbl2) -- name: SduiSettingsPage
    usePageScopeRef(ConfigKey)
    local pageTimer = React.useMemo(function()
        local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
            ConfigKey,
            {
                eventName = SurfaceLoadTimeEventName,
                metadata = { page = "mount" }
            }
        )

        loadTimerWithSurfaceLoadTime.start("mount")
        return loadTimerWithSurfaceLoadTime
    end, {})

    React.useEffect(function()
        fetchSettingsPage(pageTimer)
    end, { pageTimer })

    local refresh = React.useCallback(function()
        local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
            ConfigKey,
            {
                eventName = SurfaceLoadTimeEventName,
                metadata = { page = "refresh" }
            }
        )

        loadTimerWithSurfaceLoadTime.start("refresh")
        fetchSettingsPage(loadTimerWithSurfaceLoadTime, true)
    end, {})

    return React.createElement(SduiPageWrapperEntryPoint, {
        appPage = Settings,
        configKey = ConfigKey,
        pageTimer = pageTimer,
        refresh = refresh,
        composition = composition,
        pageTopPadding = tbl2.pageTopPadding,
        defaultFocusRef = if FFlagSduiSettingsFocusRef then tbl2.defaultFocusRef else nil,
        backgroundStyle = tbl2.backgroundStyle
    })
end)
