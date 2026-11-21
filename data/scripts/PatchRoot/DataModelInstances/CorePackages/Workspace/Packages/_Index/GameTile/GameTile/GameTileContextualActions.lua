-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local Cryo = require(GameTileParent.Cryo)
local Foundation = require(GameTileParent.Foundation)
local React = require(GameTileParent.React)
local Responsive = require(GameTileParent.Responsive)

local GameTileDirectAction = require(GameTile.GameTileDirectAction)
local GameTileOverflowMenu = require(GameTile.GameTileOverflowMenu)
local TileOverflowMenuItems = require(GameTile.GameTileConstants).TileOverflowMenuItems

local IconName = Foundation.Enums.IconName
local useLastInput = Responsive.useLastInput

local function countAvailableActions(availableMenuItems): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0

    for _, tileOverflowMenuItem in TileOverflowMenuItems do
        if availableMenuItems[tileOverflowMenuItem] then
            num1 += 1
        end
    end

    return num1
end

local function GameTileContextualActions(arg1)
    local var1 = useLastInput()
    local num1 = countAvailableActions(arg1.availableMenuItems)

    if var1 ~= Responsive.Input.Pointer
        or arg1.menuOpen
        or num1 ~= 1
        or not arg1.availableMenuItems[TileOverflowMenuItems.NotInterested]
    then
        return React.createElement(GameTileOverflowMenu, arg1)
    end

    return React.createElement(
        GameTileDirectAction,
        Cryo.Dictionary.join(arg1, { actionId = TileOverflowMenuItems.NotInterested, iconOverride = { name = IconName.X } })
    )
end
return GameTileContextualActions
