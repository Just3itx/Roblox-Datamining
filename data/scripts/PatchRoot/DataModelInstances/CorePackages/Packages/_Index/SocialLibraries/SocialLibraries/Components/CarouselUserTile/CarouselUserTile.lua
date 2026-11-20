-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local llama = dependencies.llama

local UIBlox = dependencies.UIBlox
local PlayerTile = UIBlox.App.Tile.PlayerTile
local Interactable = UIBlox.Core.Control.Interactable

local getUserAvatarImage = require(SocialLibraries.User.getUserAvatarImage)
local PlayerName = require(script.Parent.PlayerName)
local _StyleTypes = require(script.Parent.StyleTypes)
local Constants = require(script.Parent.Constants)

local function onStateChanged() end

local tbl1 = {
    tileSize = Constants.TILE_SIZE,
    nameTopPadding = Constants.NAME_TOP_PADDING,
    contextualTopPadding = Constants.CONTEXTUAL_TOP_PADDING
}

return function(tbl2)
    local var1 = llama.Dictionary.join(tbl1, tbl2)
    local tileSize = var1.tileSize

    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        if var1.renderButtons then
            return (var1.renderButtons())
        end

        return nil
    end

    local function func3()
        if var1.renderPlayerTile then
            return (var1.renderPlayerTile())
        end

        return (Roact.createElement(PlayerTile, {
            tileSize = UDim2.fromOffset(var1.tileSize, var1.tileSize),
            thumbnail = getUserAvatarImage(var1.userId),
            onActivated = var1.onActivatedTile,
            buttons = func2()
        }))
    end

    local function func4() -- Luacid: Inlined by compiler; 1 call site recovered
        if var1.renderContextualInfo then
            return (var1.renderContextualInfo())
        end

        return nil
    end

    local function func5()
        if var1.renderPlayerName then
            return (var1.renderPlayerName())
        end

        return var1.userName and Roact.createElement(PlayerName, { name = var1.userName, width = var1.tileSize }) or nil
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = var1.layoutOrder,
        Size = UDim2.fromOffset(tileSize, 0),
        BackgroundTransparency = 1
    }
    local tbl4 = {
        UIListLayout = Roact.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        PlayerTileFrame = Roact.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                Size = UDim2.fromOffset(tileSize, tileSize),
                BackgroundTransparency = 1
            },
            {
                PlayerTile = func3()
            }
        ),
        NameTopPadding = if var1.nameTopPadding then Roact.createElement(
            "Frame",
            {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(0, var1.nameTopPadding),
                BackgroundTransparency = 1
            }
        ) else nil,
        UserInfo = Roact.createElement(Interactable, {
            LayoutOrder = 3,
            [Roact.Event.Activated] = var1.onActivatedContextual,
            AutomaticSize = Enum.AutomaticSize.XY,
            onStateChanged = onStateChanged,
            BackgroundTransparency = 1
        }, {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            PlayerNameFrame = Roact.createElement(
                "Frame",
                {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY
                },
                {
                    PlayerName = func5()
                }
            ),
            ContextualTopPadding = if var1.contextualTopPadding then Roact.createElement(
                "Frame",
                {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(0, var1.contextualTopPadding),
                    BackgroundTransparency = 1
                }
            ) else nil,
            ContextualInfoFrame = Roact.createElement(
                "Frame",
                {
                    LayoutOrder = 3,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY
                },
                {
                    ContextualInfo = func4()
                }
            )
        })
    }
    return createElement(str1, tbl3, tbl4)
end
