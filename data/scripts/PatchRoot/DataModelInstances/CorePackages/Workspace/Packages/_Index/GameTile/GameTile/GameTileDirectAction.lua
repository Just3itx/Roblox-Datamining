-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local Cryo = require(GameTileParent.Cryo)
local DiscoveryAnalytics = require(GameTileParent.DiscoveryAnalytics)
local Foundation = require(GameTileParent.Foundation)
local React = require(GameTileParent.React)
local SharedFlags = require(GameTileParent.SharedFlags)

local _GameTileOverflowMenu = require(GameTile.GameTileOverflowMenu)
local useGameTileActions = require(GameTile.useGameTileActions)

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local gameTileOverflowMenuAction = DiscoveryAnalytics.Events.gameTileOverflowMenuAction

local FFlagLuaAppEnableNxMRoduxApportioning = SharedFlags.FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppGameTileDirectActionTelemetry = SharedFlags.FFlagLuaAppGameTileDirectActionTelemetry

local function GameTileDirectAction(arg1)
    local var1 = useTokens()
    local availableMenuItems = React.useMemo(function()
        return {
            [arg1.actionId] = true
        }
    end, { arg1.actionId })
    local var3 = Cryo.Dictionary.join(arg1, { availableMenuItems = availableMenuItems })

    local var4 = if FFlagLuaAppGameTileDirectActionTelemetry then React.useCallback(function(str1: string)
        gameTileOverflowMenuAction({
            universeId = arg1.universeId,
            sortId = arg1.collectionId or "",
            actionType = "GameTileOverflowMenuItemActivated",
            menuItem = str1,
            availableMenuItems = str1,
            contentType = if FFlagLuaAppEnableNxMRoduxApportioning then arg1.contentType else nil,
            isDirectAction = true
        }, arg1.appPage)
    end, {
        arg1.appPage,
        arg1.universeId,
        arg1.collectionId,
        if FFlagLuaAppEnableNxMRoduxApportioning then arg1.contentType else nil
    }) else nil

    local var5 = useGameTileActions

    if not FFlagLuaAppGameTileDirectActionTelemetry then
        var4 = nil
    end

    local var6 = var5(var3, var4)[1]

    if not (var6 and arg1.isHovered) then
        return nil
    end
    local icon = arg1.iconOverride or var6.icon
    local id = var6.id
    local onActivated = var6.onActivated
    if not (icon and id and onActivated) then
        return nil
    end

    return React.createElement(View, {
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -var1.Padding.Medium, 0, var1.Padding.Medium),
        backgroundStyle = var1.Color.OverMedia.OverMedia_0,
        tag = "auto-xy radius-circle"
    }, {
        IconButton = React.createElement(IconButton, {
            icon = icon,
            isCircular = true,
            onActivated = function()
                onActivated(id)
            end,
            size = IconSize.Small,
            testId = "game-tile-direct-action",
            variant = ButtonVariant.Utility
        })
    })
end

return GameTileDirectAction
