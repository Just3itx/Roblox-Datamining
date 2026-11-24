-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local Otter = require(ExpChatParent.Otter)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Config = require(ExpChat.Config)

local Helpers = ExpChat.BubbleChat.Helpers
local getSpringFromSettings = require(Helpers.getSpringFromSettings)
local getAbsolutePaddingbyDimension = require(Helpers.getAbsolutePaddingbyDimension)
local ClientSettingsUtility = require(ExpChat.ClientSettings.ClientSettingsUtility)

local var1 = Roact.Component:extend("ChatBubbleDistant")
var1.defaultProps = { width = 32, height = 16 }

local function getFullHeight(arg1)
    local height = arg1.height
    if arg1.renderInsert then
        height = math.max(height, arg1.insertSize.Y)
    end

    if not arg1.chatSettings.UIPadding then
        if arg1.renderInsert then
            height = math.max(height, arg1.insertSize.Y)
        end

        return height + arg1.chatSettings.Padding * 2
    end

    local uiPadding = arg1.chatSettings.UIPadding
    local absolutePaddingbyDimension = getAbsolutePaddingbyDimension(uiPadding.PaddingTop, height)
    local absolutePaddingbyDimension2 = getAbsolutePaddingbyDimension(uiPadding.PaddingBottom, height)

    if arg1.renderInsert then
        height = math.max(height, arg1.insertSize.Y)
    end

    return height + (absolutePaddingbyDimension + absolutePaddingbyDimension2)
end

function var1.init(arg1)
    arg1.state = {}

    local width, updateWidth = Roact.createBinding(0)
    arg1.width = width
    arg1.updateWidth = updateWidth
    arg1.widthMotor = Otter.createSingleMotor(0)
    arg1.widthMotor:onStep(function(arg2)
        arg1.updateWidth(math.round(arg2))
    end)

    local height, updateHeight = Roact.createBinding((getFullHeight(arg1.props)))
    arg1.height = height
    arg1.updateHeight = updateHeight

    arg1.frameSize = Roact.joinBindings({ arg1.width, arg1.height }):map(function(tbl1: {number}): UDim2
        return UDim2.fromOffset(tbl1[1], tbl1[2])
    end)

    local transparency, updateTransparency = Roact.createBinding(1)
    arg1.transparency = transparency
    arg1.updateTransparency = updateTransparency
    arg1.transparencyMotor = Otter.createSingleMotor(1)
    arg1.transparencyMotor:onStep(arg1.updateTransparency)

    local backgroundTransparency, updateBackgroundTransparency = Roact.createBinding(1)
    arg1.backgroundTransparency = backgroundTransparency
    arg1.updateBackgroundTransparency = updateBackgroundTransparency
    arg1.backgroundTransparencyMotor = Otter.createSingleMotor(1)
    arg1.backgroundTransparencyMotor:onStep(arg1.updateBackgroundTransparency)

    if arg1.props.fadingOut then
        arg1:fadeOut()
    end
end

function var1.getDerivedStateFromProps(arg1, arg2): {fullHeight: any, fullWidth: any}?
    local var2

    if arg1.chatSettings.UIPadding then
        local width = arg1.width
        if arg1.renderInsert then
            width += arg1.insertSize.X
        end

        local uiPadding = arg1.chatSettings.UIPadding
        var2 = width + (getAbsolutePaddingbyDimension(uiPadding.PaddingLeft, width) + getAbsolutePaddingbyDimension(uiPadding.PaddingRight, width))
    elseif arg1.renderInsert then
        var2 = arg1.width + arg1.insertSize.X + arg1.chatSettings.Padding * 2
    else
        var2 = arg1.width + arg1.chatSettings.Padding * 2
    end

    local fullHeight = getFullHeight(arg1)

    return if var2 == arg2.fullWidth and fullHeight == arg2.fullHeight then nil else {
        fullWidth = var2,
        fullHeight = fullHeight
    }
end

function var1.render(arg1)
    local chatSettings = arg1.props.chatSettings

    local var2 = nil
    local var3, var4, uiCorner, uiPadding

    if arg1.props.isTextChatServiceOn then
        var3 = chatSettings.ImageLabel
        var4 = chatSettings.UIGradient
        uiCorner = chatSettings.UICorner
        uiPadding = chatSettings.UIPadding
    else
        var3 = chatSettings.BackgroundImage

        var4 = chatSettings.BackgroundGradient

        uiCorner = chatSettings.CornerEnabled and {
            CornerRadius = chatSettings.CornerRadius
        }
            or chatSettings.CornerEnabled == false and {
                CornerRadius = UDim.new(0, 0)
            }
            or var2

        uiPadding = chatSettings.Padding
            and {
                PaddingTop = UDim.new(0, chatSettings.Padding),
                PaddingRight = UDim.new(0, chatSettings.Padding),
                PaddingBottom = UDim.new(0, chatSettings.Padding),
                PaddingLeft = UDim.new(0, chatSettings.Padding)
            }
            or nil
    end

    local cornerRadius = Config.DefaultBubbleChatChildrenCustomizationProperties.UICorner.CornerRadius
    local uiPadding2 = Config.DefaultBubbleChatChildrenCustomizationProperties.UIPadding

    local insertSizeX = arg1.props.renderInsert and arg1.props.insertSize.X or 0
    local showCaret = arg1.props.chatSettings.TailVisible and arg1.props.showCaret

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.fromOffset(arg1.state.fullWidth, arg1.state.fullHeight),
        Position = UDim2.new(0.5, 0, 1, -8),
        Transparency = 1
    }
    local tbl2 = {
        Scale = Roact.createElement("UIScale", { Scale = 0.75 }),
        Carat = 0,
        RoundedFrame = 0
    }

    local tailVisible = arg1.props.chatSettings.TailVisible

    if tailVisible then
        if showCaret then
            showCaret = Roact.createElement(
                "ImageLabel",
                {
                    AnchorPoint = Vector2.new(0.5, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 1, -1),
                    Size = UDim2.fromOffset(12, 8),
                    Image = "rbxasset://textures/ui/InGameChat/Caret.png",
                    ImageColor3 = chatSettings.BackgroundColor3,
                    ImageTransparency = arg1.backgroundTransparency
                },
                {
                    Gradient = not (var4 == nil) and Roact.createElement("UIGradient", var4)
                }
            )
        end
    else
        showCaret = tailVisible
    end

    tbl2.Carat = showCaret

    tbl2.RoundedFrame = Roact.createElement(
        "ImageLabel",
        Dictionary.join(var3, {
            Size = arg1.frameSize,
            BackgroundColor3 = chatSettings.BackgroundColor3,
            BackgroundTransparency = if var3 and var3.Image ~= "" then 1 else arg1.backgroundTransparency or arg1.transparency,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            ClipsDescendants = true,
            ImageTransparency = arg1.backgroundTransparency or arg1.transparency,
            Image = var3 and var3.Image or ""
        }),
        {
            UICorner = uiCorner and Roact.createElement("UICorner", { CornerRadius = uiCorner.CornerRadius })
                or Roact.createElement("UICorner", { CornerRadius = cornerRadius }),
            Contents = Roact.createElement("Frame", {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1
            }, {
                Padding = uiPadding and Roact.createElement("UIPadding", uiPadding) or Roact.createElement("UIPadding", uiPadding2),
                UIListLayout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }
                ),
                Insert = arg1.props.renderInsert and arg1.props.renderInsert(),
                Ellipsis = Roact.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Text = "…",
                    TextColor3 = chatSettings.TextColor3,
                    TextTransparency = arg1.transparency,
                    Font = Enum.Font.BuilderSansExtraBold,
                    TextScaled = false,
                    TextSize = chatSettings.TextSize,
                    Size = UDim2.new(1, -insertSizeX, 1, 0),
                    LayoutOrder = 2
                })
            }),
            Gradient = not (var4 == nil) and Roact.createElement("UIGradient", var4)
        }
    )
    return createElement(str1, tbl1, tbl2)
end

function var1.fadeIn(arg1)
    local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "transparency")

    arg1.transparencyMotor:setGoal(springFromSettings(arg1.props.chatSettings.Transparency))

    local backgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(arg1.props.chatSettings, arg1.props.clientSettings)

    arg1.backgroundTransparencyMotor:setGoal(springFromSettings(backgroundTransparency))

    local springFromSettings2 = getSpringFromSettings(arg1.props.chatSettings, "size")
    arg1.widthMotor:setGoal(springFromSettings2(arg1.state.fullWidth))
end

function var1.fadeOut(arg1)
    arg1.transparencyMotor:onComplete(function()
        if arg1.props.onFadeOut then
            arg1.props.onFadeOut()
        end
    end)

    local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "transparency")
    arg1.transparencyMotor:setGoal(springFromSettings(1))
    arg1.backgroundTransparencyMotor:setGoal(springFromSettings(1))
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg2.fadingOut ~= arg1.props.fadingOut then
        if arg1.props.fadingOut then
            arg1:fadeOut()
            return
        end
        arg1:fadeIn()
        return
    end

    if arg1.state.fullHeight ~= arg3.fullHeight then
        arg1.updateHeight(arg1.state.fullHeight)
    end
    if arg1.state.fullWidth ~= arg3.fullWidth then
        local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "size")
        arg1.widthMotor:setGoal(springFromSettings(arg1.state.fullWidth))
    end
end

function var1.didMount(arg1)
    if arg1.props.fadingOut then
        return
    end

    local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "size")
    local springFromSettings2 = getSpringFromSettings(arg1.props.chatSettings, "transparency")

    arg1.transparencyMotor:setGoal(springFromSettings2(arg1.props.chatSettings.Transparency))

    local backgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(arg1.props.chatSettings, arg1.props.clientSettings)

    arg1.backgroundTransparencyMotor:setGoal(springFromSettings2(backgroundTransparency))

    arg1.widthMotor:setGoal(springFromSettings(arg1.state.fullWidth))
end

function var1.willUnmount(arg1)
    arg1.transparencyMotor:destroy()
    arg1.backgroundTransparencyMotor:destroy()
    arg1.widthMotor:destroy()
end

return var1
