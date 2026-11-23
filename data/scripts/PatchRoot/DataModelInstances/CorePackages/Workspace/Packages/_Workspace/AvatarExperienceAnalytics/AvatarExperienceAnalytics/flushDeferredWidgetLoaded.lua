-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getUnifiedDeferredEventStore = require(script.Parent.Store.getUnifiedDeferredEventStore)
local WIDGET_LOADED = require(script.Parent.UnifiedEventLogEnums).MarketplaceUnifiedAction.WIDGET_LOADED

local function flushDeferredWidgetLoaded()
    local unifiedDeferredEventStore = getUnifiedDeferredEventStore(false)
    unifiedDeferredEventStore.markEntered()

    for _, value in (unifiedDeferredEventStore.takePending(WIDGET_LOADED)) do
        value()
    end
end

return flushDeferredWidgetLoaded
