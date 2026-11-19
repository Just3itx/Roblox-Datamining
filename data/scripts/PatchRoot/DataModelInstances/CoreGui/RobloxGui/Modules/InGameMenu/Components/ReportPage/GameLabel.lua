-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t
local Cryo = InGameMenuDependencies.Cryo

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParentParent = script.Parent.Parent.Parent
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local Assets = require(scriptParentParentParent.Resources.Assets)

local React = require(CorePackages.Packages.React)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Image = Foundation.Image

local var3 = Roact.PureComponent:extend("GameLabel")

local strictInterface = t.strictInterface
local tbl1 = {
    gameId = t.number,
    gameName = t.string,
    LayoutOrder = t.integer,
    onActivated = t.optional(t.callback),
    [Roact.Children] = t.optional(t.table),
    buttonRef = t.optional(t.table)
}
var3.validateProps = strictInterface(tbl1)

function var3.renderButtons(arg1)
    local prop = arg1.props[Roact.Children] or {}
    return (Cryo.Dictionary.join(prop, {
        List = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 12)
        })
    }))
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local gameId = arg1.props.gameId
    local placeholderGameIcon = Assets.Images.PlaceholderGameIcon
    if arg1.props.gameId > 0 then
        placeholderGameIcon = "rbxthumb://type=GameIcon&id=" .. gameId .. "&w=150&h=150"
    end

    return withFoundationOrUIBloxStyle(function(_)
        return {}
    end, function(_)
        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl2 = {
            [React.Tag] = "data-testid=experienceLabel",
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.LayoutOrder,
            Size = UDim2.new(1, 0, 0, 70),
            Text = "",
            AutoButtonColor = false,
            SelectionImageObject = arg2(var2.Square),
            [Roact.Ref] = arg1.props.buttonRef,
            [Roact.Event.Activated] = arg1.props.onActivated
        }
        local tbl3 = { GameIcon = 0, GameNameLabel = 0, ButtonContainer = 0 }
        local element

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element = Roact.createElement(Image, {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 24, 0.5, 0),
                Size = UDim2.new(0, 44, 0, 44),
                Image = placeholderGameIcon
            })
        else
            element = Roact.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 24, 0.5, 0),
                Size = UDim2.new(0, 44, 0, 44),
                BackgroundTransparency = 1,
                Image = placeholderGameIcon
            })
        end

        tbl3.GameIcon = element

        tbl3.GameNameLabel = Roact.createElement(ThemedTextLabel, {
            fontKey = "Header2",
            themeKey = "TextEmphasis",
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 80, 0.5, 0),
            Size = UDim2.new(0, 219, 0, 22),
            Text = arg1.props.gameName,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        })

        tbl3.ButtonContainer = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -24, 0, 0),
            Size = UDim2.new(0, 0, 1, 0)
        }, arg1:renderButtons())
        return createElement(str1, tbl2, tbl3)
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return Roact.forwardRef(function(arg1, buttonRef)
    return Roact.createElement(var3, Cryo.Dictionary.join(arg1, { buttonRef = buttonRef }))
end)
