-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local RobloxGui = CoreGui.RobloxGui

local CoreUtility = require(RobloxGui.Modules.CoreUtility)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts

local LocalPlayer = Players.LocalPlayer
while LocalPlayer == nil do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local var1 = CoreUtility.waitForChildOfClass(LocalPlayer, "PlayerGui")

local tbl1 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
}

if UserInputService:GetPlatform() == Enum.Platform.OSX then
    tbl1[Enum.KeyCode.LeftMeta] = "rbxasset://textures/ui/Controls/command.png"
    tbl1[Enum.KeyCode.RightMeta] = "rbxasset://textures/ui/Controls/command.png"
    tbl1[Enum.KeyCode.LeftAlt] = "rbxasset://textures/ui/Controls/option.png"
    tbl1[Enum.KeyCode.RightAlt] = "rbxasset://textures/ui/Controls/option.png"
end

local tbl2 = {
    ["'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
}

local tbl3 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
}

tbl3[Enum.KeyCode.PageUp] = "PgUp"
tbl3[Enum.KeyCode.PageDown] = "PgDn"
tbl3[Enum.KeyCode.Home] = "Home"
tbl3[Enum.KeyCode.End] = "End"
tbl3[Enum.KeyCode.Insert] = "Ins"
tbl3[Enum.KeyCode.Delete] = "Del"

local tbl4 = {
    [Enum.KeyCode.LeftControl] = 12,
    [Enum.KeyCode.RightControl] = 12,
    [Enum.KeyCode.LeftAlt] = 12,
    [Enum.KeyCode.RightAlt] = 12,
    [Enum.KeyCode.F10] = 12,
    [Enum.KeyCode.F11] = 12,
    [Enum.KeyCode.F12] = 12,
    [Enum.KeyCode.PageUp] = 8,
    [Enum.KeyCode.PageDown] = 8,
    [Enum.KeyCode.Home] = 8,
    [Enum.KeyCode.End] = 10,
    [Enum.KeyCode.Insert] = 10,
    [Enum.KeyCode.Delete] = 10
}

local reallyBlack = Color3.new(0.07, 0.07, 0.07)
local white = Color3.new(1, 1, 1)
local oyster = Color3.new(0.7, 0.7, 0.7)

local tweenInfo = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function getScreenGui() -- Luacid: Inlined by compiler; 2 call sites recovered
    local proximityPrompts = var1:FindFirstChild("ProximityPrompts")
    if proximityPrompts == nil then
        proximityPrompts = Instance.new("ScreenGui")
        proximityPrompts.Name = "ProximityPrompts"
        proximityPrompts.ResetOnSpawn = false
        proximityPrompts.Parent = var1
        proximityPrompts.IgnoreGuiInset = true
    end
    return proximityPrompts
end

local function createProgressBarGradient(frame: Frame, bool1: boolean, tbl5, tbl6): (UIGradient, Frame)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.fromScale(0.5, 1)
    frame2.Position = UDim2.fromScale(if bool1 then 0 else 0.5, 0)
    frame2.BackgroundTransparency = 1
    frame2.ClipsDescendants = true
    frame2.Visible = false
    frame2.Parent = frame

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.BackgroundTransparency = 1
    imageLabel.Size = UDim2.fromScale(2, 1)
    imageLabel.Position = UDim2.fromScale(if bool1 then 0 else -1, 0)
    imageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
    imageLabel.Parent = frame2

    local uiGradient = Instance.new("UIGradient")
    uiGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.51, 1),
        NumberSequenceKeypoint.new(1, 1)
    })

    uiGradient.Rotation = if bool1 then 180 else 0
    uiGradient.Parent = imageLabel

    table.insert(tbl5, TweenService:Create(imageLabel, tweenInfo, { ImageTransparency = 1 }))
    table.insert(tbl6, TweenService:Create(imageLabel, tweenInfo, { ImageTransparency = 0 }))

    return uiGradient, frame2
end

local function createCircularProgressBar(tbl5, tbl6): Frame
    local circularProgressBar = Instance.new("Frame")
    circularProgressBar.Name = "CircularProgressBar"
    circularProgressBar.Size = UDim2.fromOffset(58, 58)
    circularProgressBar.AnchorPoint = Vector2.new(0.5, 0.5)
    circularProgressBar.Position = UDim2.fromScale(0.5, 0.5)
    circularProgressBar.BackgroundTransparency = 1

    local uiGradient, frame = createProgressBarGradient(circularProgressBar, true, tbl5, tbl6)
    local uiGradient2, frame2 = createProgressBarGradient(circularProgressBar, false, tbl5, tbl6)

    local progress = Instance.new("NumberValue")
    progress.Name = "Progress"
    progress.Parent = circularProgressBar
    progress.Changed:Connect(function(value: number)
        local num1 = math.clamp(value * 360, 0, 360)
        frame.Visible = progress.Value > 0.5
        uiGradient.Rotation = math.clamp(num1, 180, 360)
        frame2.Visible = progress.Value > 0.01
        uiGradient2.Rotation = math.clamp(num1, 0, 180)
    end)

    return circularProgressBar
end

local function createPrompt(proximityPrompt: ProximityPrompt, proximityPromptInputType: Enum.ProximityPromptInputType, screenGui)
    local tbl5 = {}
    local tbl6 = {}
    local tbl7 = {}
    local tbl8 = {}
    local tweenInfo4 = TweenInfo.new(proximityPrompt.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

    local prompt = Instance.new("BillboardGui")
    prompt.Name = "Prompt"
    prompt.AlwaysOnTop = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(0.5, 1)
    frame.BackgroundTransparency = 1
    frame.BackgroundColor3 = reallyBlack
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.Position = UDim2.fromScale(0.5, 0)
    frame.Size = UDim2.fromScale(0, 1)
    frame.AutomaticSize = Enum.AutomaticSize.X
    frame.Parent = prompt

    local uiPadding = Instance.new("UIPadding")
    uiPadding.Parent = frame

    Instance.new("UICorner").Parent = frame

    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "InputFrame"
    inputFrame.Size = UDim2.fromScale(1, 1)
    inputFrame.BackgroundTransparency = 1
    inputFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
    inputFrame.Parent = frame

    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.fromScale(1, 1)
    frame2.Position = UDim2.fromScale(0.5, 0.5)
    frame2.AnchorPoint = Vector2.new(0.5, 0.5)
    frame2.BackgroundTransparency = 1
    frame2.Parent = inputFrame

    local uiScale = Instance.new("UIScale")
    uiScale.Parent = frame2

    local scale = if proximityPromptInputType == Enum.ProximityPromptInputType.Touch then 1.6 else 1.33
    table.insert(tbl5, TweenService:Create(uiScale, tweenInfo3, { Scale = scale }))
    table.insert(tbl6, TweenService:Create(uiScale, tweenInfo3, { Scale = 1 }))

    local actionText = Instance.new("TextLabel")
    actionText.Name = "ActionText"
    actionText.Font = AppFonts.default:getMedium()
    actionText.TextSize = 19
    actionText.BackgroundTransparency = 1
    actionText.TextTransparency = 1
    actionText.TextColor3 = white
    actionText.TextXAlignment = Enum.TextXAlignment.Left
    table.insert(tbl5, TweenService:Create(actionText, tweenInfo3, { TextTransparency = 1 }))
    table.insert(tbl6, TweenService:Create(actionText, tweenInfo3, { TextTransparency = 0 }))
    table.insert(tbl7, TweenService:Create(actionText, tweenInfo3, { TextTransparency = 1 }))
    table.insert(tbl8, TweenService:Create(actionText, tweenInfo3, { TextTransparency = 0 }))

    local objectText = Instance.new("TextLabel")
    objectText.Name = "ObjectText"
    objectText.Font = AppFonts.default:getMedium()
    objectText.TextSize = 14
    objectText.BackgroundTransparency = 1
    objectText.TextTransparency = 1
    objectText.TextColor3 = oyster
    objectText.TextXAlignment = Enum.TextXAlignment.Left

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout.Padding = UDim.new(-0.25, 0)
    uiListLayout.Parent = frame
    local tweenService = TweenService
    local tweenInfo5 = tweenInfo3
    local propertyTable = {
        Padding = UDim.new(-0.25, 0)
    }
    table.insert(tbl5, tweenService:Create(uiListLayout, tweenInfo5, propertyTable))
    local tweenService2 = TweenService
    local tweenInfo6 = tweenInfo3
    local propertyTable2 = {
        Padding = UDim.new(0, 0)
    }
    table.insert(tbl6, tweenService2:Create(uiListLayout, tweenInfo6, propertyTable2))
    local tweenService3 = TweenService
    local tweenInfo7 = tweenInfo3
    local propertyTable3 = {
        Padding = UDim.new(-0.25, 0)
    }
    table.insert(tbl7, tweenService3:Create(uiListLayout, tweenInfo7, propertyTable3))
    local tweenService4 = TweenService
    local tweenInfo8 = tweenInfo3
    local propertyTable4 = {
        Padding = UDim.new(0, 0)
    }
    table.insert(tbl8, tweenService4:Create(uiListLayout, tweenInfo8, propertyTable4))

    local textFrame = Instance.new("Frame")
    textFrame.Name = "TextFrame"
    textFrame.Size = UDim2.fromScale(0, 1)
    textFrame.AutomaticSize = Enum.AutomaticSize.X
    textFrame.BackgroundTransparency = 1
    textFrame.Parent = frame

    actionText.Size = UDim2.fromScale(0, 1)
    actionText.AutomaticSize = Enum.AutomaticSize.X
    actionText.Parent = textFrame

    objectText.Size = UDim2.fromScale(0, 1)
    objectText.AutomaticSize = Enum.AutomaticSize.X
    objectText.Parent = textFrame

    table.insert(tbl5, TweenService:Create(objectText, tweenInfo3, { TextTransparency = 1 }))
    table.insert(tbl6, TweenService:Create(objectText, tweenInfo3, { TextTransparency = 0 }))
    table.insert(tbl7, TweenService:Create(objectText, tweenInfo3, { TextTransparency = 1 }))
    table.insert(tbl8, TweenService:Create(objectText, tweenInfo3, { TextTransparency = 0 }))

    table.insert(tbl5, TweenService:Create(frame, tweenInfo3, { BackgroundTransparency = 1 }))
    table.insert(tbl6, TweenService:Create(frame, tweenInfo3, { BackgroundTransparency = 0.2 }))
    table.insert(tbl7, TweenService:Create(frame, tweenInfo3, { BackgroundTransparency = 1 }))
    table.insert(tbl8, TweenService:Create(frame, tweenInfo3, { BackgroundTransparency = 0.2 }))

    local roundFrame = Instance.new("Frame")
    roundFrame.Name = "RoundFrame"
    roundFrame.Size = UDim2.fromOffset(48, 48)

    roundFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    roundFrame.Position = UDim2.fromScale(0.5, 0.5)
    roundFrame.BackgroundTransparency = 1
    roundFrame.Parent = frame2

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.5, 0)
    uiCorner.Parent = roundFrame

    table.insert(tbl7, TweenService:Create(roundFrame, tweenInfo, { BackgroundTransparency = 1 }))
    table.insert(tbl8, TweenService:Create(roundFrame, tweenInfo, { BackgroundTransparency = 0.5 }))

    if proximityPromptInputType == Enum.ProximityPromptInputType.Gamepad then
        local contentId = UserInputService:GetImageForKeyCode(proximityPrompt.GamepadKeyCode)

        if contentId then
            local buttonImage = Instance.new("ImageLabel")
            buttonImage.Name = "ButtonImage"
            buttonImage.AnchorPoint = Vector2.new(0.5, 0.5)
            buttonImage.Size = UDim2.fromOffset(24, 24)
            buttonImage.Position = UDim2.fromScale(0.5, 0.5)
            buttonImage.BackgroundTransparency = 1
            buttonImage.ImageTransparency = 1
            buttonImage.Image = contentId
            buttonImage.Parent = frame2
            table.insert(tbl7, TweenService:Create(buttonImage, tweenInfo, { ImageTransparency = 1 }))
            table.insert(tbl8, TweenService:Create(buttonImage, tweenInfo, { ImageTransparency = 0 }))
        end
    elseif proximityPromptInputType == Enum.ProximityPromptInputType.Touch then
        local buttonImage = Instance.new("ImageLabel")
        buttonImage.Name = "ButtonImage"
        buttonImage.BackgroundTransparency = 1
        buttonImage.ImageTransparency = 1
        buttonImage.Size = UDim2.fromOffset(25, 31)
        buttonImage.AnchorPoint = Vector2.new(0.5, 0.5)
        buttonImage.Position = UDim2.fromScale(0.5, 0.5)
        buttonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
        buttonImage.Parent = frame2

        table.insert(tbl7, TweenService:Create(buttonImage, tweenInfo, { ImageTransparency = 1 }))
        table.insert(tbl8, TweenService:Create(buttonImage, tweenInfo, { ImageTransparency = 0 }))
    else
        local buttonImage = Instance.new("ImageLabel")
        buttonImage.Name = "ButtonImage"
        buttonImage.BackgroundTransparency = 1
        buttonImage.ImageTransparency = 1
        buttonImage.Size = UDim2.fromOffset(28, 30)
        buttonImage.AnchorPoint = Vector2.new(0.5, 0.5)
        buttonImage.Position = UDim2.fromScale(0.5, 0.5)
        buttonImage.Image = "rbxasset://textures/ui/Controls/key_single.png"
        buttonImage.Parent = frame2
        table.insert(tbl7, TweenService:Create(buttonImage, tweenInfo, { ImageTransparency = 1 }))
        table.insert(tbl8, TweenService:Create(buttonImage, tweenInfo, { ImageTransparency = 0 }))

        local stringForKeyCode = UserInputService:GetStringForKeyCode(proximityPrompt.KeyboardKeyCode)

        local var2 = tbl1[proximityPrompt.KeyboardKeyCode]
        if var2 == nil then
            var2 = tbl2[stringForKeyCode]
        end

        if var2 == nil then
            stringForKeyCode = tbl3[proximityPrompt.KeyboardKeyCode] or stringForKeyCode
        end

        if var2 then
            local buttonImage2 = Instance.new("ImageLabel")
            buttonImage2.Name = "ButtonImage"
            buttonImage2.AnchorPoint = Vector2.new(0.5, 0.5)
            buttonImage2.Size = UDim2.fromOffset(36, 36)
            buttonImage2.Position = UDim2.fromScale(0.5, 0.5)
            buttonImage2.BackgroundTransparency = 1
            buttonImage2.ImageTransparency = 1
            buttonImage2.Image = var2
            buttonImage2.Parent = frame2
            table.insert(tbl7, TweenService:Create(buttonImage2, tweenInfo, { ImageTransparency = 1 }))
            table.insert(tbl8, TweenService:Create(buttonImage2, tweenInfo, { ImageTransparency = 0 }))
        elseif stringForKeyCode ~= nil and stringForKeyCode ~= "" then
            local buttonText = Instance.new("TextLabel")
            buttonText.Name = "ButtonText"
            buttonText.AutoLocalize = false
            buttonText.Position = UDim2.fromOffset(0, -1)
            buttonText.Size = UDim2.fromScale(1, 1)
            buttonText.Font = AppFonts.default:getMedium()

            local var3 = tbl4[proximityPrompt.KeyboardKeyCode]
            buttonText.TextSize = if var3 == nil then 14 else var3

            buttonText.BackgroundTransparency = 1
            buttonText.TextTransparency = 1
            buttonText.TextColor3 = white
            buttonText.TextXAlignment = Enum.TextXAlignment.Center
            buttonText.Text = stringForKeyCode
            buttonText.Parent = frame2
            table.insert(tbl7, TweenService:Create(buttonText, tweenInfo, { TextTransparency = 1 }))
            table.insert(tbl8, TweenService:Create(buttonText, tweenInfo, { TextTransparency = 0 }))
        else
            error(
                "ProximityPrompt '" .. proximityPrompt.Name .. "' has an unsupported keycode for rendering UI: " .. tostring(proximityPrompt.KeyboardKeyCode)
            )
        end
    end
    if proximityPromptInputType == Enum.ProximityPromptInputType.Touch or proximityPrompt.ClickablePrompt then
        local textButton = Instance.new("TextButton")
        textButton.BackgroundTransparency = 1
        textButton.TextTransparency = 1
        textButton.Size = UDim2.fromScale(1, 1)
        textButton.Parent = prompt
        textButton.Selectable = false

        local bool1 = false

        textButton.InputBegan:Connect(function(input: InputObject)
            if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1)
                and input.UserInputState ~= Enum.UserInputState.Change
            then
                proximityPrompt:InputHoldBegin()
                bool1 = true
            end
        end)
        textButton.InputEnded:Connect(function(input: InputObject)
            if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and bool1 then
                bool1 = false
                proximityPrompt:InputHoldEnd()
            end
        end)

        prompt.Active = true
    end

    if proximityPrompt.HoldDuration > 0 then
        local frame3 = createCircularProgressBar(tbl7, tbl8)
        frame3.Parent = frame2
        local tweenService5 = TweenService
        local progress = frame3.Progress
        table.insert(tbl5, tweenService5:Create(progress, tweenInfo4, { Value = 1 }))
        local tweenService6 = TweenService
        local progress2 = frame3.Progress
        table.insert(tbl6, tweenService6:Create(progress2, tweenInfo2, { Value = 0 }))
    end

    local connection = nil
    local connection2 = nil

    if proximityPrompt.HoldDuration > 0 then
        connection = proximityPrompt.PromptButtonHoldBegan:Connect(function()
            for _, value in ipairs(tbl5) do
                value:Play()
            end
        end)

        connection2 = proximityPrompt.PromptButtonHoldEnded:Connect(function()
            for _, value in ipairs(tbl6) do
                value:Play()
            end
        end)
    end

    local connection3 = proximityPrompt.Triggered:Connect(function()
        for _, value in ipairs(tbl7) do
            value:Play()
        end
    end)

    local connection4 = proximityPrompt.TriggerEnded:Connect(function()
        for _, value in ipairs(tbl8) do
            value:Play()
        end
    end)

    local function updateUIFromPrompt()
        local absoluteSizeX = 72

        local yOffset = if proximityPrompt.ObjectText == nil or proximityPrompt.ObjectText == "" then 0 else 9

        actionText.Text = proximityPrompt.ActionText
        objectText.Text = proximityPrompt.ObjectText
        actionText.AutoLocalize = proximityPrompt.AutoLocalize
        actionText.RootLocalizationTable = proximityPrompt.RootLocalizationTable
        objectText.AutoLocalize = proximityPrompt.AutoLocalize
        objectText.RootLocalizationTable = proximityPrompt.RootLocalizationTable
        local offset = 24 - yOffset

        if proximityPrompt.ActionText ~= nil and proximityPrompt.ActionText ~= ""
            or proximityPrompt.ObjectText ~= nil and proximityPrompt.ObjectText ~= ""
        then
            uiPadding.PaddingRight = UDim.new(0, offset)
        else
            uiPadding.PaddingRight = UDim.new(0, 0)
        end

        actionText.Position = UDim2.new(0, 0, 0, yOffset)
        objectText.Position = UDim2.new(0, 0, 0, -10)

        prompt.Size = UDim2.fromOffset(absoluteSizeX, 72)
        prompt.SizeOffset = Vector2.new(
            proximityPrompt.UIOffset.X / prompt.Size.Width.Offset,
            proximityPrompt.UIOffset.Y / prompt.Size.Height.Offset
        )

        task.defer(function()
            RunService.RenderStepped:Wait()
            RunService.RenderStepped:Wait()

            absoluteSizeX = frame.AbsoluteSize.X
            prompt.Size = UDim2.fromOffset(absoluteSizeX, 72)
            prompt.SizeOffset = Vector2.new(
                proximityPrompt.UIOffset.X / prompt.Size.Width.Offset,
                proximityPrompt.UIOffset.Y / prompt.Size.Height.Offset
            )
        end)
    end
    local connection5 = proximityPrompt.Changed:Connect(updateUIFromPrompt)
    updateUIFromPrompt()

    prompt.Adornee = proximityPrompt.Parent
    prompt.Parent = screenGui

    local connection6 = proximityPrompt.AncestryChanged:Connect(function() -- name: updateUIAncestry
        prompt.Adornee = proximityPrompt.Parent
    end)
    for _, value in ipairs(tbl8) do
        value:Play()
    end

    local function cleanup()
        if connection then
            connection:Disconnect()
        end

        if connection2 then
            connection2:Disconnect()
        end

        connection3:Disconnect()
        connection4:Disconnect()
        connection5:Disconnect()
        connection6:Disconnect()

        for _, value in ipairs(tbl7) do
            value:Play()
        end

        wait(0.2)

        prompt.Parent = nil
    end

    return cleanup
end

local function createIndicator(proximityPrompt: ProximityPrompt, screenGui)
    local tbl5 = {}
    local tbl6 = {}

    local indicator = Instance.new("BillboardGui")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.fromOffset(15, 15)
    indicator.AlwaysOnTop = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1, 1)
    frame.BackgroundTransparency = 1
    frame.BackgroundColor3 = reallyBlack
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.Position = UDim2.fromScale(0.5, 0)
    frame.Parent = indicator

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = frame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = white
    uiStroke.Thickness = 1.5
    uiStroke.Transparency = 1
    uiStroke.Parent = frame

    table.insert(tbl5, TweenService:Create(frame, tweenInfo, { BackgroundTransparency = 1 }))
    table.insert(tbl5, TweenService:Create(uiStroke, tweenInfo, { Transparency = 1 }))
    table.insert(tbl6, TweenService:Create(frame, tweenInfo, { BackgroundTransparency = 0.2 }))
    table.insert(tbl6, TweenService:Create(uiStroke, tweenInfo, { Transparency = 0.2 }))

    indicator.Adornee = proximityPrompt.Parent
    indicator.Parent = screenGui

    local connection = proximityPrompt.AncestryChanged:Connect(function() -- name: updateUIAncestry
        indicator.Adornee = proximityPrompt.Parent
    end)
    for _, value in ipairs(tbl6) do
        value:Play()
    end

    local function cleanup()
        connection:Disconnect()

        for _, value in ipairs(tbl5) do
            value:Play()
        end

        wait(0.2)

        indicator.Parent = nil
    end

    return cleanup
end

local function onLoad()
    ProximityPromptService.PromptShown:Connect(function(prompt: ProximityPrompt, inputType: Enum.ProximityPromptInputType)
        if prompt.Style == Enum.ProximityPromptStyle.Custom then
            return
        end

        local screenGui = getScreenGui()
        local prompt2 = createPrompt(prompt, inputType, screenGui)

        local bindableEvent = Instance.new("BindableEvent")
        local connection = prompt.PromptHidden:Connect(function()
            bindableEvent:Fire()
        end)
        local connection2 = prompt.Destroying:Connect(function()
            bindableEvent:Fire()
        end)
        bindableEvent.Event:Wait()
        connection:Disconnect()
        connection2:Disconnect()

        prompt2()
    end)

    ProximityPromptService.IndicatorShown:Connect(function(prompt: ProximityPrompt)
        if prompt.Style == Enum.ProximityPromptStyle.Custom then
            return
        end

        local screenGui = getScreenGui()
        local indicator = createIndicator(prompt, screenGui)

        local bindableEvent = Instance.new("BindableEvent")
        local connection = prompt.IndicatorHidden:Connect(function()
            bindableEvent:Fire()
        end)
        local connection2 = prompt.Destroying:Connect(function()
            bindableEvent:Fire()
        end)
        bindableEvent.Event:Wait()
        connection:Disconnect()
        connection2:Disconnect()

        indicator()
    end)
end

onLoad()
