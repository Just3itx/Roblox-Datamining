-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local Otter = require(ExpChatParent.Otter)
local Timer = require(ExpChat.Timer)

local UIBlox = require(ExpChatParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Localization = require(ExpChat.Localization)

local FFlagExpChatUnmountTranslationFTUX = require(ExpChat.Flags.FFlagExpChatUnmountTranslationFTUX)

local GameSettings = UserSettings().GameSettings

local var1 = Roact.Component:extend("ChatTranslationFTUX")
var1.defaultProps = {
    timer = Timer.new(10)
}

local font = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local font2 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)

local tbl1 = { dampingRatio = 1, frequency = 2 }

if game:GetEngineFeature("TextChatServiceSettingsSaved") then
    GameSettings.ChatTranslationFTUXShown = true
end

function var1.init(arg1)
    local transparency, updateTransparency = Roact.createBinding(1)
    arg1.transparency = transparency
    arg1.updateTransparency = updateTransparency
    arg1.transparencyMotor = Otter.createSingleMotor(1)
    arg1.transparencyMotor:onStep(arg1.updateTransparency)
end

function var1.render(arg1)
    if FFlagExpChatUnmountTranslationFTUX and arg1.state.isDismissed then
        return nil
    end
    local createElement = Roact.createElement
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2.new(0, 10, 0, 20),
        Size = UDim2.new(0.25, 0, 0, 0),
        BackgroundTransparency = 1
    }
    local tbl3 = {
        BubbleTail = Roact.createElement(ImageSetLabel, {
            Size = UDim2.new(0, 15, 0, 10),
            BackgroundTransparency = 1,
            ImageTransparency = arg1.transparency,
            ImageColor3 = Color3.new(0.5, 0.5, 0.5),
            Image = Images["component_assets/triangleUp_16"],
            Position = UDim2.new(0, 15, 0, -10),
            ZIndex = 100
        }),
        BubbleBody = 0
    }

    local createElement2 = Roact.createElement
    local tbl4 = {
        Active = true,
        BackgroundTransparency = arg1.transparency,
        BackgroundColor3 = Color3.new(0.5, 0.5, 0.5),
        AutomaticSize = Enum.AutomaticSize.XY,
        ZIndex = 100,
        Style = Enum.FrameStyle.Custom
    }

    tbl4[Roact.Event.TouchTap] = function()
        arg1:fadeOut()
    end
    tbl4[Roact.Event.InputEnded] = function(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseButton1 then
            arg1:fadeOut()
        end
    end

    tbl3.BubbleBody = createElement2("Frame", tbl4, {
        RoundCorners = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 5) }),
        SizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(300, 400) }),
        Padding = Roact.createElement("UIPadding", {
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10)
        }),
        Layout = Roact.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 10)
            }
        ),
        Title = Roact.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0),
            Text = if arg1.props.FTUXTitle == "" then "Chat translation is on for supported languages" else arg1.props.FTUXTitle,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextTransparency = arg1.transparency,
            FontFace = font,
            TextSize = 16,
            TextWrapped = true,
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1, 1, 1),
            ZIndex = 101,
            LayoutOrder = 1
        }),
        Body = Roact.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0),
            Text = if arg1.props.FTUXBody == "" then "Messages you send and receive will be translated automatically" else arg1.props.FTUXBody,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextTransparency = arg1.transparency,
            FontFace = font2,
            TextSize = 16,
            TextWrapped = true,
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1, 1, 1),
            ZIndex = 101,
            LayoutOrder = 2
        })
    })
    return createElement("Frame", tbl2, tbl3)
end

function var1.fadeOut(arg1)
    if arg1.isFadingOut then
        return
    end

    arg1.isFadingOut = true

    if FFlagExpChatUnmountTranslationFTUX then
        arg1.transparencyMotor:onComplete(function()
            arg1:setState({ isDismissed = true })
        end)
    end

    arg1.transparencyMotor:setGoal((function(num1: number)
        return Otter.spring(num1, tbl1)
    end)(1))
end

function var1.didMount(arg1)
    arg1.transparencyMotor:setGoal((function(num1: number)
        return Otter.spring(num1, tbl1)
    end)(0))

    arg1.props.timer:start():andThen(function()
        arg1:fadeOut()
    end)
end

function var1.willUnmount(arg1)
    arg1.transparencyMotor:destroy()
end

return Localization.connect(function()
    return {
        FTUXTitle = "CoreScripts.TextChat.ChatTranslation.FTUX.TitleNew",
        FTUXBody = "CoreScripts.TextChat.ChatTranslation.FTUX.BodyNew"
    }
end)(var1)
