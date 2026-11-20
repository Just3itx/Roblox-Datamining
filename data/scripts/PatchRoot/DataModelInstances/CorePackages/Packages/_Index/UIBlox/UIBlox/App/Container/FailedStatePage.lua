-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)

local Images = require(scriptParentParentParent.App.ImageSet.Images)
local EmptyState = require(scriptParentParentParent.App.Indicator.EmptyState)
local Button = require(scriptParentParentParent.App.Button.Button)
local ButtonType = require(scriptParentParentParent.App.Button.Enum.ButtonType)

local RenderOnFailedStyle = require(scriptParentParentParent.App.Loading.Enum.RenderOnFailedStyle)

local var1 = Roact.PureComponent:extend("FailedStatePage")

var1.validateProps = t.strictInterface({
    onRetry = t.optional(t.callback),
    renderOnFailed = t.optional(RenderOnFailedStyle.isEnumValue),
    text = t.optional(t.string)
})

var1.defaultProps = {
    renderOnFailed = RenderOnFailedStyle.RetryButton
}

function var1.render(arg1)
    if arg1.props.renderOnFailed == RenderOnFailedStyle.EmptyStatePage then
        return Roact.createElement(EmptyState, {
            position = UDim2.fromScale(0.5, 0.5),
            anchorPoint = Vector2.new(0.5, 0.5),
            onActivated = arg1.props.onRetry,
            icon = Images["icons/status/noconnection_large"],
            text = arg1.props.text
        })
    elseif arg1.props.renderOnFailed == RenderOnFailedStyle.RetryButton then
        if arg1.props.onRetry then
            return Roact.createElement(Button, {
                buttonType = ButtonType.Secondary,
                size = UDim2.fromOffset(44, 44),
                position = UDim2.fromScale(0.5, 0.5),
                anchorPoint = Vector2.new(0.5, 0.5),
                onActivated = arg1.props.onRetry,
                icon = Images["icons/common/refresh"]
            })
        end
        error("OnRetry callback empty. OnRetry needs to be a function to render the RetryButton")
    else
        error("Failed to provide proper RenderOnFailedStyle")
    end
end

return var1
