-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent

local Signals = require(FlyoutSidePanelParent.Signals)
local VisibilityControl = require(FlyoutSidePanelParent.AppNavBar).VisibilityControl
local GetDrawerVisibleStore = require(FlyoutSidePanelParent.Drawer).Stores.GetDrawerVisibleStore

local tbl1 = {
    scrollAwayEnabled = false,
    flyoutVisible = false,
    contextualMenuVisible = false,
    flyoutVisibleStore = nil,
    disposeFlyoutVisibleEffect = nil
}

tbl1.__index = tbl1

local var1 = nil

function tbl1.getInstance()
    if not var1 then
        var1 = {}
        setmetatable(var1, tbl1)
        var1:initialize()
    end
    return var1
end

function tbl1.initialize(arg1)
    arg1.flyoutVisibleStore = GetDrawerVisibleStore(false)
    arg1.disposeFlyoutVisibleEffect = Signals.createEffect(function(arg2)
        arg1.flyoutVisible = arg1.flyoutVisibleStore.getDrawerVisible(arg2)
        arg1:updateScrollAwayState()
    end)
end

function tbl1.updateScrollAwayState(arg1)
    local var2 = arg1.scrollAwayEnabled and not (arg1.flyoutVisible or arg1.contextualMenuVisible)
    VisibilityControl.setEnabled(var2)
end

function tbl1.setScrollAwayEnabled(tbl2, scrollAwayEnabled: boolean)
    tbl2.scrollAwayEnabled = scrollAwayEnabled
    tbl2:updateScrollAwayState()
end

function tbl1.setContextualMenuVisible(tbl2, contextualMenuVisible: boolean)
    tbl2.contextualMenuVisible = contextualMenuVisible
    tbl2:updateScrollAwayState()
end

return {
    setScrollAwayEnabled = function(bool1: boolean)
        return tbl1.getInstance():setScrollAwayEnabled(bool1)
    end,
    setContextualMenuVisible = function(bool1: boolean)
        return tbl1.getInstance():setContextualMenuVisible(bool1)
    end
}
