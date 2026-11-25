-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local PlayerListIcon = require(scriptParentParentParent.Common.PlayerListIcon)
local PlayerContextualMenuStore = require(scriptParentParentParent.Common.PlayerContextualMenuStore)
local Constants = require(scriptParentParentParent.Common.Constants)

local tbl1 = {
    affordance = StateLayerAffordance.Background
}
return React.memo(function(tbl2) -- name: MenuActionRow
    local var1 = useTokens()
    local item = tbl2.item
    local var2 = SignalsReact.useSignalState(PlayerContextualMenuStore.getPendingConfirmKey)
    local var3 = if item.requiresConfirm == true and var2 == item.key and item.confirmLabel ~= nil then item.confirmLabel else item.label
    local bool1 = tbl2.isInteractable ~= false
    local var4 = React.useCallback(function()
        if not bool1 then
            return
        end
        PlayerContextualMenuStore.activateMenuItem(item)
    end, { item, bool1 })

    local icon = if item.icon == nil then nil else React.createElement(
        PlayerListIcon,
        {
            icon = item.icon,
            size = var1.Size.Size_500,
            layoutOrder = 1,
            testId = "menu-action-row-icon"
        }
    )
    local tbl3 = {
        Icon = if icon == nil then nil else React.createElement(
            View,
            {
                tag = "row align-x-center align-y-center size-1000-1000",
                LayoutOrder = 1,
                testId = "menu-action-row-icon-column"
            },
            { Icon = icon }
        ),
        Label = React.createElement(View, {
            tag = "fill auto-y",
            LayoutOrder = 2,
            testId = "menu-action-row-label-column"
        }, {
            Text = React.createElement(FoundationText, {
                Text = var3,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
                testId = "menu-action-row-label"
            })
        })
    }

    local createElement = React.createElement
    local var5 = View
    local tbl4 = {
        LayoutOrder = tbl2.layoutOrder,
        onActivated = 0,
        ref = 0,
        tag = "row align-x-left align-y-center gap-none size-full-1000 auto-y",
        stateLayer = 0,
        selection = 0,
        testId = "menu-action-row"
    }

    if not bool1 then
        var4 = nil
    end

    tbl4.onActivated = var4
    tbl4.ref = tbl2.rowRef

    tbl4.stateLayer = if bool1 then tbl1 else nil
    tbl4.selection = Constants.SELECTABLE
    return createElement(var5, tbl4, tbl3)
end)
