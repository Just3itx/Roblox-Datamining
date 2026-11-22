-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent
local React = require(ImpressionsParent.React)
local ImpressionsTracker = require(script.Parent.ImpressionsTracker)
local ImpressionsTrackerWithoutNavigation = require(script.Parent.ImpressionsTrackerWithoutNavigation)
local useNavigation = require(ImpressionsParent.Navigation).useNavigation

local useViewportBounds = require(ImpressionsParent.ViewportUtils).useViewportBounds
local SignalsReact = require(ImpressionsParent.SignalsReact)
local GetShortcutBarStatusStore = require(ImpressionsParent.AppShortcutBarStore).GetShortcutBarStatusStore
local SharedFlags = require(ImpressionsParent.SharedFlags)

local FFlagUnifyShortcutBarFixImpressions = SharedFlags.FFlagUnifyShortcutBarFixImpressions
local FFlagOptionalNavigation = SharedFlags.FFlagOptionalNavigation
local FFlagLuaAppSduiGameDwell = SharedFlags.FFlagLuaAppSduiGameDwell

return function(tbl1)
    local var1 = if FFlagOptionalNavigation then useNavigation() else nil
    local var2 = if FFlagUnifyShortcutBarFixImpressions then SignalsReact.useSignalState(GetShortcutBarStatusStore(false).getShortcutBarReservedHeight) else nil
    local var3 = useViewportBounds
    local var4 = nil
    local ignoreBottomInset = tbl1.ignoreBottomInset
    local var5 = nil
    if not FFlagUnifyShortcutBarFixImpressions then
        var2 = nil
    end

    local viewPortBounds = var3(var4, ignoreBottomInset, var5, var2)

    local tbl2 = {
        pageContext = tbl1.pageContext,
        parentRef = tbl1.parentRef,
        impressionsTag = tbl1.impressionsTag,
        scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
        sendImpressions = tbl1.sendImpressions,
        dataUpdatedTimestamp = tbl1.dataUpdatedTimestamp,
        viewPortBounds = viewPortBounds
    }

    if FFlagLuaAppSduiGameDwell then
        tbl2.visibilityObserver = tbl1.visibilityObserver
    end

    if not FFlagOptionalNavigation or var1 ~= nil then
        return React.createElement(ImpressionsTracker, tbl2)
    end

    tbl2.pageContext = nil
    return React.createElement(ImpressionsTrackerWithoutNavigation, tbl2)
end
