-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent
local React = require(SocialCommonParent.React)
local Cryo = require(SocialCommonParent.Cryo)

local UIBlox = require(SocialCommonParent.UIBlox)
local PlayerTile = UIBlox.App.Tile.PlayerTile
local Interactable = UIBlox.Core.Control.Interactable
local getStandardSizeAvatarHeadShotRbxthumb = require(SocialCommonParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb

local FFlagCarouselUserTileUseProfileFrameThumbnail = require(SocialCommon.Flags.FFlagCarouselUserTileUseProfileFrameThumbnail)

local PlayerName = require(script.Parent.PlayerName)
local Constants = require(script.Parent.Constants)

local function onStateChanged() end

local tbl1 = {
    tileSize = Constants.TILE_SIZE,
    nameTopPadding = Constants.NAME_TOP_PADDING,
    contextualTopPadding = Constants.CONTEXTUAL_TOP_PADDING
}

return function(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local tileSize = var1.tileSize
    local element

    if var1.renderPlayerTile then
        element = var1.renderPlayerTile()
    else
        element = React.createElement(PlayerTile, {
            title = "",
            tileSize = UDim2.fromOffset(var1.tileSize, var1.tileSize),
            thumbnail = if var1.headshotImageUrl then var1.headshotImageUrl else getStandardSizeAvatarHeadShotRbxthumb(var1.userId, FFlagCarouselUserTileUseProfileFrameThumbnail),
            onActivated = var1.onActivatedTile,
            buttons = if var1.renderButtons then var1.renderButtons() else nil,
            Selectable = true,
            buttonRef = var1.buttonRef
        })
    end
    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        if var1.renderContextualInfo then
            return (var1.renderContextualInfo())
        end

        return nil
    end

    local function func3()
        if var1.renderPlayerName then
            return (var1.renderPlayerName())
        end

        return var1.userName and React.createElement(PlayerName, { name = var1.userName, width = var1.tileSize }) or nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = var1.layoutOrder,
        Size = UDim2.new(0, tileSize, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl4 = {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        PlayerTileFrame = React.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                Size = UDim2.fromOffset(tileSize, tileSize),
                BackgroundTransparency = 1
            },
            { PlayerTile = element }
        ),
        NameTopPadding = if var1.nameTopPadding then React.createElement(
            "Frame",
            {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(0, var1.nameTopPadding),
                BackgroundTransparency = 1
            }
        ) else nil,
        UserInfo = React.createElement(Interactable, {
            LayoutOrder = 3,
            [React.Event.Activated] = var1.onActivatedContextual,
            AutomaticSize = Enum.AutomaticSize.XY,
            onStateChanged = onStateChanged,
            BackgroundTransparency = 1,
            Selectable = false
        }, {
            UIListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            PlayerNameFrame = React.createElement(
                "Frame",
                {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY
                },
                {
                    PlayerName = func3()
                }
            ),
            ContextualTopPadding = if var1.contextualTopPadding then React.createElement(
                "Frame",
                {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(0, var1.contextualTopPadding),
                    BackgroundTransparency = 1
                }
            ) else nil,
            ContextualInfoFrame = React.createElement(
                "Frame",
                {
                    LayoutOrder = 3,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY
                },
                {
                    ContextualInfo = func2()
                }
            )
        })
    }
    return createElement(str1, tbl3, tbl4)
end
