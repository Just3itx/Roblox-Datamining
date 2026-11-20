-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local ChatBubbleContainer = require(script.Parent.ChatBubbleContainer)
local Roact = dependencies.Roact
local withStyle = dependencies.UIBlox.Style.withStyle
local FitTextLabel = dependencies.RoactFitComponents.FitTextLabel

local var1 = Roact.PureComponent:extend("PlainText")
local defaultProps = {
    text = "",
    maxWidth = 0,
    innerPadding = 0,
    isIncoming = false,
    hasTail = false,
    LayoutOrder = 0,
    isPending = false
}

defaultProps[Roact.Change.AbsoluteSize] = function() end

var1.defaultProps = defaultProps

function var1.render(arg1)
    return withStyle(function(arg2)
        local maxWidth = arg1.props.maxWidth
        local innerPadding = arg1.props.innerPadding
        local maximumWidth = math.max(0, maxWidth - innerPadding)
        local body = arg2.Font.Body
        local var2 = arg2.Font.BaseSize * body.RelativeSize

        return Roact.createElement(ChatBubbleContainer, {
            isIncoming = arg1.props.isIncoming,
            hasTail = arg1.props.hasTail,
            isPending = arg1.props.isPending,
            padding = innerPadding,
            LayoutOrder = arg1.props.LayoutOrder,
            [Roact.Change.AbsoluteSize] = arg1.props[Roact.Change.AbsoluteSize]
        }, {
            textContent = Roact.createElement(FitTextLabel, {
                Text = arg1.props.text,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                TextColor3 = arg2.Theme.TextEmphasis.Color,
                width = FitTextLabel.Width.FitToText,
                maximumWidth = maximumWidth,
                Font = arg1.props.font or body.Font,
                TextSize = arg1.props.textSize or var2,
                TextTransparency = arg1.props.isPending and arg2.Theme.TextMuted.Transparency or 0,
                TextYAlignment = Enum.TextYAlignment.Top
            })
        })
    end)
end

return var1
