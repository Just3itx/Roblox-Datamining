-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local PlayerListVisibilityStore = require(scriptParentParentParent.Common.PlayerListVisibilityStore)
local PlayerContextualMenuStore = require(scriptParentParentParent.Common.PlayerContextualMenuStore)

local Constants = require(scriptParentParentParent.Common.Constants)

local stateLayer = {
    affordance = StateLayerAffordance.None
}

local function LeaderboardScrimMobile()
    local var1 = useTokens()
    local var2 = SignalsReact.useSignalBinding(PlayerListVisibilityStore.getEffectiveVisible)

    local onActivated = React.useCallback(function()
        PlayerContextualMenuStore.closeContextMenu()
        PlayerListVisibilityStore.setVisible(false)
    end, {})

    return React.createElement(View, {
        tag = "size-full",
        ZIndex = 0,
        backgroundStyle = var1.Color.Common.Scrim,
        Visible = var2,
        onActivated = onActivated,
        stateLayer = stateLayer,
        selection = Constants.NOT_SELECTABLE
    })
end

return React.memo(function(tbl2) -- name: LeaderboardScrim
    if not tbl2.isSmallTouchDevice then
        return nil
    end
    return React.createElement(LeaderboardScrimMobile)
end)
