-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local React = require(SduiSharedUtilitiesParent.React)
local AppPageShell = require(SduiSharedUtilitiesParent.AppPageShell)
local _AppCommonLib = require(SduiSharedUtilitiesParent.AppCommonLib)
local SduiCoreSystem = require(SduiSharedUtilitiesParent.SduiCoreSystem)

local PageContentMode = AppPageShell.PageContentMode
local PageContext = AppPageShell.PageContext
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local FFlagAppPageShellScrollToTopFocus = require(SduiSharedUtilitiesParent.SharedFlags).FFlagAppPageShellScrollToTopFocus
local FFlagSduiPageCanvasCollectionLayout = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiPageCanvasCollectionLayout

local useComponentConfig = require(SduiSharedUtilities.hooks.useComponentConfig)
local useComponentLifecycleTiming = require(SduiSharedUtilities.hooks.useComponentLifecycleTiming)
local useMissingRootWarning = require(SduiSharedUtilities.hooks.useMissingRootWarning)
local FFlagDataHydrationAccountReset = require(SduiSharedUtilitiesParent.SharedFlags).FFlagDataHydrationAccountReset
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)

local function SduiPageWholeContent(tbl1)
    local var1 = React.useContext(PageContext)

    local verticalScrollingFrameRef = var1.verticalScrollingFrameRef
    local useMemo = React.useMemo
    local function func1()
        return {
            scrollingFrameRef = verticalScrollingFrameRef,
            verticalScrollingFrameRef = verticalScrollingFrameRef,
            scrollViewPositionChangedSignal = var1.scrollViewPositionChangedSignal,
            refreshSignal = tbl1.refreshSignal,
            scrollToSelectionAnimationManagedByParent = true,
            defaultFocusRef = if FFlagAppPageShellScrollToTopFocus then tbl1.defaultFocusRef else nil,
            disableCollectionLayoutStoreProvider = if FFlagSduiPageCanvasCollectionLayout then true else nil
        }
    end

    local refreshSignal = tbl1.refreshSignal
    local defaultFocusRef = if FFlagAppPageShellScrollToTopFocus then tbl1.defaultFocusRef else nil
    local extraLocalProps = useMemo(func1, { var1, refreshSignal, defaultFocusRef, verticalScrollingFrameRef })

    local sduiComponentWrapper = getSduiComponentWrapper(tbl1.config)
    return React.createElement(sduiComponentWrapper, {
        debugName = `{tbl1.debugName}-content`,
        componentConfig = tbl1.config,
        sduiContext = tbl1.sduiContext,
        localAnalyticsData = tbl1.localAnalyticsData,
        extraLocalProps = extraLocalProps
    })
end

local function buildWholePageContent(config, tbl1)
    return { React.createElement(SduiPageWholeContent, {
            config = config,
            sduiContext = tbl1.sduiContext,
            localAnalyticsData = tbl1.localAnalyticsData,
            debugName = tbl1.debugName,
            refreshSignal = tbl1.refreshSignal,
            defaultFocusRef = if FFlagAppPageShellScrollToTopFocus then tbl1.defaultFocusRef else nil
        }) }
end

local function useSduiPageContent(tbl1)
    local var1 = useComponentConfig(tbl1.configKey, tbl1.contentIdentifier)
    if FFlagDataHydrationAccountReset then
        useMissingRootWarning(tbl1.configKey, var1)
    end
    useComponentLifecycleTiming(tbl1.pageTimer, var1 ~= nil)

    local contentMode = tbl1.contentMode or PageContentMode.Scroll
    return {
        contentMode = contentMode,
        content = {
            contentSlot = React.useMemo(function()
                if var1 == nil then
                    return nil
                elseif contentMode == PageContentMode.Scroll then
                    return (buildWholePageContent(var1, tbl1))
                end

                return (buildWholePageContent(var1, tbl1))
            end, { var1, tbl1, contentMode })
        }
    }
end

return useSduiPageContent
