-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent
local React = require(ImpressionsParent.React)
local ImpressionsTracker = require(script.Parent.ImpressionsTracker)
local ImpressionsTrackerWithoutNavigation = require(script.Parent.ImpressionsTrackerWithoutNavigation)
local useNavigation = require(ImpressionsParent.Navigation).useNavigation
local useViewportBounds = require(ImpressionsParent.ViewportUtils).useViewportBounds
local SharedFlags = require(ImpressionsParent.SharedFlags)
local SignalsReact = require(ImpressionsParent.SignalsReact)
local GetShortcutBarStatusStore = require(ImpressionsParent.AppShortcutBarStore).GetShortcutBarStatusStore

local FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions = SharedFlags.FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions
local FFlagLuaAppRespectClipAncestorImpressions = SharedFlags.FFlagLuaAppRespectClipAncestorImpressions
local FFlagUnifyShortcutBarFixImpressions = SharedFlags.FFlagUnifyShortcutBarFixImpressions
local FFlagOptionalNavigation = SharedFlags.FFlagOptionalNavigation
local FFlagLuaAppSduiGameDwell = SharedFlags.FFlagLuaAppSduiGameDwell

return function(tbl1)
    local var1 = if FFlagOptionalNavigation then useNavigation() else nil
    local var2 = if FFlagUnifyShortcutBarFixImpressions then SignalsReact.useSignalState(GetShortcutBarStatusStore(false).getShortcutBarReservedHeight) else nil
    local var3 = nil
    local var4

    if FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions then
        local var5 = useViewportBounds
        local parentRef = tbl1.parentRef
        local var6 = nil
        local respectClipAncestors = if FFlagLuaAppRespectClipAncestorImpressions then tbl1.respectClipAncestors else nil

        if not FFlagUnifyShortcutBarFixImpressions then
            var2 = nil
        end

        var4, var3 = var5(parentRef, var6, respectClipAncestors, var2)
    else
        local var5 = useViewportBounds
        local parentRef = tbl1.parentRef
        local var6 = nil
        local respectClipAncestors = if FFlagLuaAppRespectClipAncestorImpressions then tbl1.respectClipAncestors else nil

        if not FFlagUnifyShortcutBarFixImpressions then
            var2 = nil
        end

        var4 = var5(parentRef, var6, respectClipAncestors, var2)
    end

    local tbl2 = {
        pageContext = tbl1.pageContext,
        parentRef = tbl1.parentRef,
        impressionsTag = tbl1.impressionsTag,
        scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
        sendImpressions = tbl1.sendImpressions,
        dataUpdatedTimestamp = tbl1.dataUpdatedTimestamp,
        viewPortBounds = var4,
        viewPortFillBounds = 0
    }

    if not FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions then
        var3 = nil
    end

    tbl2.viewPortFillBounds = var3

    if FFlagLuaAppSduiGameDwell then
        tbl2.visibilityObserver = tbl1.visibilityObserver
    end

    if not FFlagOptionalNavigation or var1 ~= nil then
        return React.createElement(ImpressionsTracker, tbl2)
    end

    tbl2.pageContext = nil
    return React.createElement(ImpressionsTrackerWithoutNavigation, tbl2)
end
