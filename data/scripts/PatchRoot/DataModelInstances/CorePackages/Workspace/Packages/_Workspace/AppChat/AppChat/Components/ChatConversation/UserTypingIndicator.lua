-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local withStyle = require(AppChatParent.UIBlox).Style.withStyle
local Otter = require(AppChatParent.Otter)
local normalizeFontFace = require(AppChatParent.Foundation).Utility.normalizeFontFace

local UIBlox = require(AppChatParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local MessageCharacterLimit = require(script.Parent.MessageCharacterLimit)

local var1 = Roact.PureComponent:extend("UserTypingIndicator")

local tbl1 = { dampingRatio = 1.5, frequency = 1.6 }

var1.defaultProps = {
    AnchorPoint = Vector2.new(0, 0),
    LayoutOrder = 1,
    Position = UDim2.new(0, 0, 0, 0),
    ZIndex = 1,
    usersTyping = {},
    oneUserTyping = "PLACEHOLDER {DISPLAY_NAME} is typing...",
    twoUsersTyping = "PLACEHOLDER {DISPLAY_NAME_1} and {DISPLAY_NAME_2} are typing...",
    severalUsersTyping = "PLACEHOLDER Several users are typing...",
    maxCharacterLength = MessageCharacterLimit,
    height = 40
}

function var1.init(arg1)
    function arg1.getDisplayText()
        if arg1.props.usersTyping then
            if #arg1.props.usersTyping == 1 then
                return arg1.props.oneUserTyping
            end

            if #arg1.props.usersTyping == 2 then
                return arg1.props.twoUsersTyping
            end

            if #arg1.props.usersTyping > 2 then
                return arg1.props.severalUsersTyping
            end
        end
        return ""
    end

    local animationProgress, var3 = Roact.createBinding(1)

    arg1.motor = Otter.createSingleMotor(1)
    arg1.motor:start()

    arg1.motor:onStep(var3)
    arg1.animationProgress = animationProgress

    function arg1.updateAnimationGoal()
        local num1 = if #arg1.props.usersTyping > 0 then 0 else 1
        arg1.motor:setGoal(Otter.spring(num1, tbl1))
    end

    arg1.updateAnimationGoal()
end

function var1.didUpdate(arg1, arg2, _)
    if #arg2.usersTyping ~= #arg1.props.usersTyping then
        arg1.updateAnimationGoal()
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local font = arg2.Font
        local textSize = font.BaseSize * font.Footer.RelativeSize

        return Roact.createElement("Frame", {
            AnchorPoint = arg1.props.AnchorPoint,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.LayoutOrder,
            Position = arg1.props.Position,
            Size = UDim2.new(1, 0, 0, arg1.props.height),
            ZIndex = arg1.props.ZIndex
        }, {
            Layout = Roact.createElement("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }),
            ImageContainer = Roact.createElement(ImageSetLabel, {
                Size = UDim2.new(0.9, 0, 1, 0),
                BackgroundColor3 = arg2.Theme.NavigationBar.Color,
                BorderColor3 = arg2.Theme.Divider.Color,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(8, 8, 9, 9),
                Image = Images["component_assets/circle_17"],
                ImageColor3 = arg2.Theme.BackgroundUIDefault.Color,
                ImageTransparency = arg1.animationProgress:map(function<T>(arg3: T): T
                    return arg3
                end),
                Position = arg1.animationProgress:map(function(yScale: number?): UDim2
                    return UDim2.new(0, 0, yScale, 0)
                end)
            }, {
                Layout = Roact.createElement("UIListLayout", {
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                Padding = Roact.createElement("UIPadding", {
                    PaddingLeft = UDim.new(0, 12),
                    PaddingTop = UDim.new(0, 4),
                    PaddingBottom = UDim.new(0, 4),
                    PaddingRight = UDim.new(0, 12)
                }),
                TextLabel = Roact.createElement("TextLabel", {
                    Text = arg1.getDisplayText(),
                    TextSize = textSize,
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionSmall.Font),
                    TextColor3 = arg2.Theme.TextMuted.Color,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    BackgroundTransparency = 1,
                    TextTransparency = arg1.animationProgress:map(function<T>(arg3: T): T
                        return arg3
                    end)
                })
            })
        })
    end)
end

function var1.willUnmount(arg1)
    if arg1.motor then
        arg1.motor:destroy()
    end
end

return var1
