-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)

local Cell = UIBlox.App.Table.Cell
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider

local scriptParentParent = script.Parent.Parent
local Dependencies = require(scriptParentParent.Dependencies)
local GameIcon = require(Dependencies.GameIcon)
local ThemedTextLabel = require(Dependencies.ThemedTextLabel)
local withLocalization = require(Dependencies.withLocalization)

local var1 = Roact.PureComponent:extend("GameCell")

var1.validateProps = t.strictInterface(
    {
        gameId = t.number,
        layoutOrder = t.optional(t.union(t.integer, t.table)),
        onActivated = t.optional(t.callback)
    }
)
function var1.renderWithSelectionCursor(arg1, _)
    local props = arg1.props
    return withLocalization({ labelText = "CoreScripts.InGameMenu.Report.ReportExperience" })(function(arg2)
        return Roact.createElement(Cell, {
            onActivated = props.onActivated,
            layoutOrder = props.layoutOrder,
            size = UDim2.new(1, 0, 0, 72),
            head = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 72)
            }, {
                GameIcon = Roact.createElement(GameIcon, {
                    gameId = props.gameId,
                    iconSize = 48,
                    cornerRadius = UDim.new(0, 8),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5)
                }),
                Label = Roact.createElement(ThemedTextLabel, {
                    fontKey = "Header2",
                    themeKey = "TextEmphasis",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Text = arg2.labelText,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 54, 0.5, 0)
                })
            }),
            tail = Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(1, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(0, 0, 1, 0)
            })
        })
    end)
end

function var1.render(arg1)
    return withSelectionCursorProvider(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return var1
