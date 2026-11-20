-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local Alert = require(scriptParent.Alert)
local AlertType = require(scriptParent.Enum.AlertType)

local FitFrameOnAxis = require(scriptParentParentParentParentParent.FitFrame).FitFrameOnAxis

local Foundation = require(scriptParentParentParentParentParent.Foundation)
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local var1 = Roact.PureComponent:extend("LoadingAlert")

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    screenSize = t.Vector2,
    onMounted = t.optional(t.callback),
    titleIcon = t.optional(t.union(t.table, t.string)),
    title = t.string
})

function var1.init(arg1)
    function arg1.renderMiddleContent()
        return Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundTransparency = 1
        }, {
            Spinner = Roact.createElement(
                Loading,
                {
                    size = IconSize.Large,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }
            )
        })
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        return Roact.createElement(Alert, {
            anchorPoint = arg1.props.anchorPoint,
            alertType = AlertType.Loading,
            margin = { top = 0, bottom = 24, left = 24, right = 24 },
            maxWidth = 400,
            minWidth = 272,
            middleContent = arg1.renderMiddleContent,
            onMounted = arg1.props.onMounted,
            position = arg1.props.position,
            screenSize = arg1.props.screenSize,
            title = arg1.props.title,
            titleContent = arg1.props.titleIcon and function()
                return Roact.createElement(FitFrameOnAxis, {
                    BackgroundTransparency = 1,
                    contentPadding = UDim.new(0, 8),
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    margin = { top = 12, bottom = 0, left = 0, right = 0 },
                    minimumSize = UDim2.new(1, 0, 0, 0)
                }, {
                    Icon = Roact.createElement(ImageSetComponent.Label, {
                        BackgroundTransparency = 1,
                        Image = arg1.props.titleIcon,
                        ImageColor3 = theme.IconEmphasis.Color,
                        ImageTransparency = theme.IconEmphasis.Transparency,
                        Size = UDim2.new(0, 48, 0, 48)
                    })
                })
            end or nil
        })
    end)
end

return var1
