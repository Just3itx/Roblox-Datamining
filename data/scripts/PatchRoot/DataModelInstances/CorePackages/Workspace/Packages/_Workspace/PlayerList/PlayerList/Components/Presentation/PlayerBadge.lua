-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local useTokens = require(scriptParentParentParentParent.Foundation).Hooks.useTokens

local PlayerIconInfoStore = require(scriptParentParentParentParent.PlayerIconInfoStore).PlayerIconInfoStore

local getPlayerBadgeIcon = require(scriptParentParentParent.Common.getPlayerBadgeIcon)
local LayoutValuesContext = require(scriptParentParentParent.Common.LayoutValuesContext)
local PlayerListIcon = require(scriptParentParentParent.Common.PlayerListIcon)
local PlayerRelationshipStore = require(scriptParentParentParent.Common.PlayerRelationshipStore)

return React.memo(function(tbl1) -- name: PlayerBadge
    local var1 = React.useContext(LayoutValuesContext)
    local var2 = useTokens()
    local var3 = SignalsReact.useSignalState(PlayerIconInfoStore.getPlayerIconInfoReactive(tbl1.player.UserId))

    local var4 = SignalsReact.useSignalState(PlayerRelationshipStore.getPlayerRelationshipReactive(tbl1.player.UserId))
    local icon = getPlayerBadgeIcon(var1, tbl1.player, var3, var4)

    return React.createElement(PlayerListIcon, { icon = icon, size = var2.Size.Size_400, layoutOrder = tbl1.layoutOrder })
end)
