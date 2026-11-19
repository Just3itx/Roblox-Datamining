-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local t = InGameMenuDependencies.t
local Roact = InGameMenuDependencies.Roact
local Cryo = InGameMenuDependencies.Cryo
local UIBlox = InGameMenuDependencies.UIBlox

local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParentParent = script.Parent.Parent.Parent
local GameIcon = require(scriptParentParentParent.Components.GameIcon)

local uDim = UDim.new(0, 8)

local var3 = Roact.PureComponent:extend("GameIconButton")

var3.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    onActivated = t.callback,
    onSelectionGained = t.optional(t.callback),
    onSelectionLost = t.optional(t.callback),
    forwardRef = t.optional(t.table)
})

function var3.renderWithSelectionCursor(arg1, arg2)
    return Roact.createElement(
        "TextButton",
        {
            Text = "",
            AnchorPoint = arg1.props.anchorPoint,
            BackgroundTransparency = 1,
            Position = arg1.props.position,
            Size = UDim2.fromOffset(32, 32),
            LayoutOrder = arg1.props.layoutOrder,
            SelectionImageObject = arg2(var2.RoundedRect),
            [Roact.Event.Activated] = arg1.props.onActivated,
            [Roact.Event.SelectionGained] = arg1.props.onSelectionGained,
            [Roact.Event.SelectionLost] = arg1.props.onSelectionLost,
            [Roact.Ref] = arg1.props.forwardRef
        },
        {
            GameIconButton = Roact.createElement(GameIcon, { gameId = game.GameId, iconSize = 32, cornerRadius = uDim })
        }
    )
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var3, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
