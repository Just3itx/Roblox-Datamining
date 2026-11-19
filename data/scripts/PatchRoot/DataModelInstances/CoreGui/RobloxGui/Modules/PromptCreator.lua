-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")

local bool1 = game:DefineFastFlag("PromptCreatorTransientDialog", false)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Modules = RobloxGui:WaitForChild("Modules")
local TenFootInterface = require(Modules:WaitForChild("TenFootInterface"))
local VR = Modules:WaitForChild("VR")
local Dialog = require(VR:WaitForChild("Dialog"))

local var1 = nil
local var2 = nil
local var3 = nil

function getViewportSize(): Vector2
    while not game.Workspace.CurrentCamera do
        game.Workspace.Changed:Wait()
    end
    assert(game.Workspace.CurrentCamera, "")

    while game.Workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0)
        or game.Workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) do
        game.Workspace.CurrentCamera.Changed:Wait()
    end

    return game.Workspace.CurrentCamera.ViewportSize
end

local isEnabled = TenFootInterface:IsEnabled()
local bool2 = false
local bool3 = UserInputService.TouchEnabled == true and UserInputService.MouseEnabled == false
local bool4 = bool3 and getViewportSize().Y <= 370
local bool5 = bool3 and not bool4

local IsCurrentlyPrompting = false

local bool7 = false
local CoreGuiNavigationEnabled = false
local GuiNavigationEnabled = false
local AutoSelectGuiEnabled = false

local tbl1 = {
    WindowTitle = "Confirm",
    MainText = "Is this okay?",
    ConfirmationText = "Confirm",
    CancelText = "Cancel",
    CancelActive = true,
    StripeColor = Color3.new(0.01, 0.72, 0.34),
    Image = nil,
    ImageConsoleVR = nil,
    PromptCompletedCallback = nil
}

local PromptCompletedCallback = nil
local var4 = nil

local tbl2 = {}

local uDim2 = UDim2.new(0, 438, 0, 300)
local uDim2_2 = UDim2.new(0.5, -219, 0, -300)
local uDim2_3 = UDim2.new(0.5, -219, 0.5, -150)

local yOffset = 52

local num1 = 24

if isEnabled or bool2 then
    uDim2 = UDim2.new(1, 0, 0, 690)
    uDim2_2 = UDim2.new(0, 0, 0, -690)
    uDim2_3 = UDim2.new(0, 0, 0.5, -345)
elseif bool4 then
    uDim2 = UDim2.new(0.9, 0, 0.9, 0)
    uDim2_2 = UDim2.new(0.05, 0, -0.9, 0)
    uDim2_3 = UDim2.new(0.05, 0, 0.05, 0)
elseif bool5 then
    uDim2 = UDim2.new(0, 400, 0, 305)
    uDim2_2 = UDim2.new(0.5, -200, 0, -305)
    uDim2_3 = UDim2.new(0.5, -200, 0.5, -152)
end

if bool4 then
    yOffset = 44
end

if isEnabled or bool2 then
    num1 = 42
end

local function createFrame(frameName: string, frameSize, position, backgroundTransparency: number, backgroundColor3): Frame
    local frame = Instance.new("Frame")
    frame.Name = frameName
    frame.Size = frameSize
    frame.Position = position or UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = backgroundTransparency
    frame.BackgroundColor3 = backgroundColor3 or Color3.new()
    frame.BorderSizePixel = 0
    frame.ZIndex = 8

    return frame
end

local function createTextLabel(textLabelName, size, textLabelPosition, font, textSize, textLabelText): TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = textLabelName
    textLabel.Size = size or UDim2.new(0, 0, 0, 0)
    textLabel.Position = textLabelPosition
    textLabel.BackgroundTransparency = 1
    textLabel.Font = font
    textLabel.TextSize = textSize
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Text = textLabelText
    textLabel.ZIndex = 8

    return textLabel
end

local function createScrollingTextLabel(name: string, scrollingFrameSize, scrollingTextParentPosition, font: Enum.Font, fontSize: number, string: string, scrollBarThickness: number): Frame | TextLabel
    local textLabel = createTextLabel(name, scrollingFrameSize, scrollingTextParentPosition, font, fontSize, string)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.TextWrapped = true

    if not (TextService:GetTextSize(string, fontSize, font, Vector2.new(scrollingFrameSize.X.Offset, 10000)).Y > scrollingFrameSize.Y.Offset) then
        return textLabel
    end

    local vector2 = Vector2.new(scrollingFrameSize.X.Offset - (scrollBarThickness + 20), 10000)
    local vector2_2 = TextService:GetTextSize(string, fontSize, font, vector2)

    local scrollingTextParent = Instance.new("Frame")
    scrollingTextParent.Name = "ScrollingTextParent"
    scrollingTextParent.BackgroundTransparency = 1
    scrollingTextParent.BackgroundColor3 = Color3.new(1, 1, 1)
    scrollingTextParent.BorderSizePixel = 0
    scrollingTextParent.Position = scrollingTextParentPosition
    scrollingTextParent.Size = scrollingFrameSize - UDim2.new(0, scrollBarThickness * 2, 0, 0)

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Selectable = true
    scrollingFrame.Name = "ScrollingFrame"
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollingFrame.Size = scrollingFrameSize
    scrollingFrame.CanvasSize = UDim2.new(0, vector2.X - scrollBarThickness * 2, 0, vector2_2.Y)
    scrollingFrame.ScrollBarThickness = scrollBarThickness
    scrollingFrame.SelectionImageObject = Instance.new("ImageLabel")
    scrollingFrame.SelectionImageObject.Name = "EmptySelectionImage"
    scrollingFrame.SelectionImageObject.BackgroundTransparency = 1
    scrollingFrame.SelectionImageObject.Image = ""
    scrollingFrame.Active = false

    scrollingFrame.SelectionGained:connect(function()
        scrollingTextParent.BackgroundTransparency = 0.15
    end)

    scrollingFrame.SelectionLost:connect(function()
        scrollingTextParent.BackgroundTransparency = 1
    end)

    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.Size = UDim2.new(0, vector2.X, 0, vector2_2.Y)
    textLabel.Parent = scrollingFrame

    scrollingFrame.Parent = scrollingTextParent

    return scrollingTextParent
end

local function createImageLabel(imageLabelName: string, imageLabelSize, imageLabelPosition, image, callback): ImageLabel -- Luacid: Inlined by compiler; 3 call sites recovered
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = imageLabelName
    imageLabel.Size = imageLabelSize
    imageLabel.BackgroundTransparency = 1
    imageLabel.Position = imageLabelPosition
    imageLabel.Image = image

    if callback then
        callback(imageLabel)
    end

    return imageLabel
end

local function createImageButtonWithText(imageButtonName: string, imageButtonSize, imageButtonPosition, image: string, image2: string, text, font): ImageButton
    local imageButton = Instance.new("ImageButton")
    imageButton.Name = imageButtonName
    imageButton.Size = imageButtonSize
    imageButton.Position = imageButtonPosition
    imageButton.Image = image
    imageButton.BackgroundTransparency = 1
    imageButton.AutoButtonColor = false
    imageButton.ZIndex = 8
    imageButton.Modal = true
    imageButton.Selectable = true
    imageButton.SelectionImageObject = Instance.new("ImageLabel")
    imageButton.SelectionImageObject.Name = "EmptySelectionImage"
    imageButton.SelectionImageObject.BackgroundTransparency = 1
    imageButton.SelectionImageObject.Image = ""

    local textLabel = createTextLabel(imageButtonName .. "Text", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), font, num1, text)
    textLabel.ZIndex = 9
    textLabel.Parent = imageButton

    imageButton.MouseEnter:connect(function()
        imageButton.Image = image2
    end)
    imageButton.MouseLeave:connect(function()
        imageButton.Image = image
    end)
    imageButton.MouseButton1Click:connect(function()
        imageButton.Image = image
    end)
    imageButton.SelectionGained:connect(function()
        imageButton.Image = image2
    end)
    imageButton.SelectionLost:connect(function()
        imageButton.Image = image
    end)

    return imageButton
end

local function createPromptDialog()
    var2 = createFrame("PromptDialog", uDim2, uDim2_2, 1, nil)
    var2.Visible = false
    var2.Active = true
    var2.Parent = RobloxGui

    var3 = createFrame("ContainerFrame", UDim2.new(1, 0, 1, 0), nil, 0.36, Color3.new(0, 0, 0))
    var3.ZIndex = 8
    var3.Parent = var2
end

local function destroyPromptDialog() -- Luacid: Inlined by compiler; 2 call sites recovered
    if var2 then
        var2:Destroy()
        var2 = nil
        var3 = nil
    end
end

function AddDefaultsToPromptOptions(arg1, arg2)
    for k, value in pairs(arg2) do
        if arg1[k] == nil then
            arg1[k] = value
        end
    end
end

function CreatePromptVRorConsole(arg1)
    local xOffset

    if arg1.ImageConsoleVR then
        local imageLabel = createImageLabel(
            "Image",
            UDim2.new(0, 600, 0, 600),
            UDim2.new(0, 100, 0, 45),
            arg1.ImageConsoleVR,
            arg1.FetchImageFunctionConsoleVR
        )
        imageLabel.ZIndex = 9
        imageLabel.Parent = var3
        xOffset = 800
    else
        xOffset = 90
    end

    local textLabel = createTextLabel(
        "WindowTitle",
        UDim2.new(0, 800, 0, 60),
        UDim2.new(0, xOffset, 0, 60),
        Enum.Font.SourceSansBold,
        48,
        arg1.WindowTitle
    )
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.Parent = var3
    textLabel.ZIndex = 9

    local frame = createFrame("ColorStripe", UDim2.new(0, 832, 0, 4), UDim2.new(0, xOffset, 0, 120), 0, arg1.StripeColor)
    frame.ZIndex = 9
    frame.Parent = var3

    createScrollingTextLabel(
        "MainText",
        UDim2.new(0, 800, 0, 450),
        UDim2.new(0, xOffset, 0, 152),
        Enum.Font.SourceSansBold,
        44,
        arg1.MainText,
        16
    ).Parent = var3

    local rect = Rect.new(8, 8, 56, 56)
    local slice = Enum.ScaleType.Slice

    local imageButton = createImageButtonWithText(
        "ConfirmButton",
        UDim2.new(0, 320, 0, 80),
        UDim2.new(0, xOffset, 1, -125),
        "rbxasset://textures/ui/VR/button.png",
        "rbxasset://textures/ui/VR/buttonSelected.png",
        arg1.ConfirmationText,
        Enum.Font.SourceSans
    )
    imageButton.Parent = var3
    imageButton.ScaleType = slice
    imageButton.SliceCenter = rect

    imageButton.MouseButton1Click:connect(function()
        OnPromptEnded(true)
    end)

    if not arg1.CancelActive then
        return
    end

    local imageButton2 = createImageButtonWithText(
        "CancelButton",
        UDim2.new(0, 320, 0, 80),
        UDim2.new(0, xOffset + 340, 1, -125),
        "rbxasset://textures/ui/VR/button.png",
        "rbxasset://textures/ui/VR/buttonSelected.png",
        arg1.CancelText,
        Enum.Font.SourceSans
    )
    imageButton2.Parent = var3
    imageButton2.ScaleType = slice
    imageButton2.SliceCenter = rect

    imageButton2.MouseButton1Click:connect(function()
        OnPromptEnded(false)
    end)
end

function CreatePromptPCorTablet(arg1)
    local textLabel = createTextLabel(
        "WindowTitle",
        UDim2.new(1, 0, 0, yOffset),
        UDim2.new(0, 0, 0, 0),
        Enum.Font.SourceSansBold,
        24,
        arg1.WindowTitle
    )
    textLabel.Parent = var3
    textLabel.ZIndex = 9

    local frame = createFrame("ColorStripe", UDim2.new(1, 0, 0, 2), nil, 0, arg1.StripeColor)
    frame.Position = UDim2.new(0, 0, 0, yOffset)
    frame.ZIndex = 9
    frame.Parent = var3
    local scrollingTextLabel

    if arg1.Image then
        local imageLabel = createImageLabel(
            "Image",
            UDim2.new(0, 150, 0, 150),
            UDim2.new(0, 15, 0, yOffset + 17),
            arg1.Image,
            arg1.FetchImageFunction
        )
        imageLabel.ZIndex = 9
        imageLabel.Parent = var3

        if bool5 then
            scrollingTextLabel = createScrollingTextLabel(
                "MainText",
                UDim2.new(0, 195, 0, 150),
                UDim2.new(0, 185, 0, yOffset + 17),
                Enum.Font.SourceSansBold,
                22,
                arg1.MainText,
                8
            )
        else
            scrollingTextLabel = createScrollingTextLabel(
                "MainText",
                UDim2.new(0, 233, 0, 150),
                UDim2.new(0, 185, 0, yOffset + 17),
                Enum.Font.SourceSansBold,
                22,
                arg1.MainText,
                8
            )
        end
    elseif bool5 then
        scrollingTextLabel = createScrollingTextLabel(
            "MainText",
            UDim2.new(0, 360, 0, 150),
            UDim2.new(0, 20, 0, yOffset + 17),
            Enum.Font.SourceSansBold,
            22,
            arg1.MainText,
            8
        )
    else
        scrollingTextLabel = createScrollingTextLabel(
            "MainText",
            UDim2.new(0, 398, 0, 150),
            UDim2.new(0, 20, 0, yOffset + 17),
            Enum.Font.SourceSansBold,
            22,
            arg1.MainText,
            8
        )
    end

    scrollingTextLabel.Parent = var3

    local rect = Rect.new(8, 8, 56, 56)
    local slice = Enum.ScaleType.Slice
    local imageButtonWithText

    if bool5 then
        if arg1.CancelActive then
            imageButtonWithText = createImageButtonWithText(
                "ConfirmButton",
                UDim2.new(0, 128, 0, 44),
                UDim2.new(0.5, -138, 1, -59),
                "rbxasset://textures/ui/VR/button.png",
                "rbxasset://textures/ui/VR/buttonSelected.png",
                arg1.ConfirmationText,
                Enum.Font.SourceSansBold
            )
        else
            imageButtonWithText = createImageButtonWithText(
                "ConfirmButton",
                UDim2.new(0, 128, 0, 44),
                UDim2.new(0.5, -64, 1, -59),
                "rbxasset://textures/ui/VR/button.png",
                "rbxasset://textures/ui/VR/buttonSelected.png",
                arg1.ConfirmationText,
                Enum.Font.SourceSans
            )
        end
    elseif arg1.CancelActive then
        imageButtonWithText = createImageButtonWithText(
            "ConfirmButton",
            UDim2.new(0, 128, 0, 38),
            UDim2.new(0.5, -138, 1, -53),
            "rbxasset://textures/ui/VR/button.png",
            "rbxasset://textures/ui/VR/buttonSelected.png",
            arg1.ConfirmationText,
            Enum.Font.SourceSansBold
        )
    else
        imageButtonWithText = createImageButtonWithText(
            "ConfirmButton",
            UDim2.new(0, 128, 0, 38),
            UDim2.new(0.5, -64, 1, -53),
            "rbxasset://textures/ui/VR/button.png",
            "rbxasset://textures/ui/VR/buttonSelected.png",
            arg1.ConfirmationText,
            Enum.Font.SourceSans
        )
    end

    imageButtonWithText.Parent = var3
    imageButtonWithText.ScaleType = slice
    imageButtonWithText.SliceCenter = rect

    imageButtonWithText.MouseButton1Click:connect(function()
        OnPromptEnded(true)
    end)

    if not arg1.CancelActive then
        return
    end

    local imageButtonWithText2

    if bool5 then
        imageButtonWithText2 = createImageButtonWithText(
            "CancelButton",
            UDim2.new(0, 128, 0, 44),
            UDim2.new(0.5, 10, 1, -59),
            "rbxasset://textures/ui/VR/button.png",
            "rbxasset://textures/ui/VR/buttonSelected.png",
            arg1.CancelText,
            Enum.Font.SourceSans
        )
    else
        imageButtonWithText2 = createImageButtonWithText(
            "CancelButton",
            UDim2.new(0, 128, 0, 38),
            UDim2.new(0.5, 10, 1, -53),
            "rbxasset://textures/ui/VR/button.png",
            "rbxasset://textures/ui/VR/buttonSelected.png",
            arg1.CancelText,
            Enum.Font.SourceSans
        )
    end
    imageButtonWithText2.Parent = var3
    imageButtonWithText2.ScaleType = slice
    imageButtonWithText2.SliceCenter = rect

    imageButtonWithText2.MouseButton1Click:connect(function()
        OnPromptEnded(false)
    end)

    imageButtonWithText2.NextSelectionLeft = imageButtonWithText
    imageButtonWithText.NextSelectionRight = imageButtonWithText2
end

function CreatePromptPhone(arg1)
    local textLabel = createTextLabel(
        "WindowTitle",
        UDim2.new(1, 0, 0, yOffset),
        UDim2.new(0, 0, 0, 0),
        Enum.Font.SourceSansBold,
        24,
        arg1.WindowTitle
    )
    textLabel.Parent = var3
    textLabel.ZIndex = 9

    local frame = createFrame("ColorStripe", UDim2.new(1, 0, 0, 2), nil, 0, arg1.StripeColor)
    frame.Position = UDim2.new(0, 0, 0, yOffset)
    frame.ZIndex = 9
    frame.Parent = var3
    local scrollingTextLabel

    if arg1.Image then
        local imageLabel = createImageLabel(
            "Image",
            UDim2.new(0, 120, 0, 120),
            UDim2.new(0, 15, 0, yOffset + 17),
            arg1.Image,
            arg1.FetchImageFunction
        )
        imageLabel.ZIndex = 9
        imageLabel.Parent = var3

        scrollingTextLabel = createScrollingTextLabel(
            "MainText",
            UDim2.new(0, var3.AbsoluteSize.X - 175, 0, 120),
            UDim2.new(0, 155, 0, yOffset + 17),
            Enum.Font.SourceSansBold,
            20,
            arg1.MainText,
            8
        )
    else
        scrollingTextLabel = createScrollingTextLabel(
            "MainText",
            UDim2.new(1, var3.AbsoluteSize.X - 40, 0, 120),
            UDim2.new(0, 20, 0, yOffset + 17),
            Enum.Font.SourceSansBold,
            20,
            arg1.MainText,
            8
        )
    end
    scrollingTextLabel.Parent = var3

    local rect = Rect.new(8, 8, 56, 56)
    local slice = Enum.ScaleType.Slice
    local imageButtonWithText

    if arg1.CancelActive then
        imageButtonWithText = createImageButtonWithText(
            "ConfirmButton",
            UDim2.new(0, 128, 0, 44),
            UDim2.new(0.5, -138, 1, -59),
            "rbxasset://textures/ui/VR/button.png",
            "rbxasset://textures/ui/VR/buttonSelected.png",
            arg1.ConfirmationText,
            Enum.Font.SourceSansBold
        )
    else
        imageButtonWithText = createImageButtonWithText(
            "ConfirmButton",
            UDim2.new(0, 128, 0, 44),
            UDim2.new(0.5, -64, 1, -59),
            "rbxasset://textures/ui/VR/button.png",
            "rbxasset://textures/ui/VR/buttonSelected.png",
            arg1.ConfirmationText,
            Enum.Font.SourceSans
        )
    end
    imageButtonWithText.Parent = var3
    imageButtonWithText.ScaleType = slice
    imageButtonWithText.SliceCenter = rect

    imageButtonWithText.MouseButton1Click:connect(function()
        OnPromptEnded(true)
    end)

    if not arg1.CancelActive then
        return
    end

    local imageButton = createImageButtonWithText(
        "CancelButton",
        UDim2.new(0, 128, 0, 44),
        UDim2.new(0.5, 10, 1, -59),
        "rbxasset://textures/ui/VR/button.png",
        "rbxasset://textures/ui/VR/buttonSelected.png",
        arg1.CancelText,
        Enum.Font.SourceSans
    )
    imageButton.Parent = var3
    imageButton.ScaleType = slice
    imageButton.SliceCenter = rect

    imageButton.MouseButton1Click:connect(function()
        OnPromptEnded(false)
    end)
end

function CreatePromptFromOptions(arg1)
    var3:ClearAllChildren()

    if bool2 or isEnabled then
        CreatePromptVRorConsole(arg1)
    elseif bool4 then
        CreatePromptPhone(arg1)
    else
        CreatePromptPCorTablet(arg1)
    end
end

function SetSelectedObject()
    local cancelButton = var3:FindFirstChild("CancelButton")
    if cancelButton then
        GuiService.SelectedCoreObject = cancelButton
        return
    end
    local confirmButton = var3:FindFirstChild("ConfirmButton")
    if confirmButton then
        GuiService.SelectedCoreObject = confirmButton
    end
end

function OnTweenInFinished()
    if bool7 or isEnabled then
        SetSelectedObject()
    end
end

function ConnectActiveEvents()
    local function OnInputChanged(input: InputObject)
        local userInputType = input.UserInputType
        local userInputType2 = Enum.UserInputType
        if bool2
            or not valueInTable(
                userInputType,
                {
                    userInputType2.Gamepad1,
                    userInputType2.Gamepad2,
                    userInputType2.Gamepad3,
                    userInputType2.Gamepad4
                }
            )
        then
            bool7 = false
            return
        end

        if input.KeyCode ~= Enum.KeyCode.Thumbstick1 and input.KeyCode ~= Enum.KeyCode.Thumbstick2 then
            bool7 = true
            return
        end

        if math.abs(input.Position.X) > 0.1 or math.abs(input.Position.Z) > 0.1 or math.abs(input.Position.Y) > 0.1 then
            bool7 = true
        end
    end

    table.insert(tbl2, UserInputService.InputChanged:connect(OnInputChanged))
    table.insert(tbl2, UserInputService.InputBegan:connect(OnInputChanged))

    local tbl3 = tbl2
    local changed = GuiService.Changed

    table.insert(tbl3, changed:connect(function(property: string)
        if not IsCurrentlyPrompting then
            return
        end

        if property == "CoreGuiNavigationEnabled" then
            if GuiService.CoreGuiNavigationEnabled ~= true then
                CoreGuiNavigationEnabled = GuiService.CoreGuiNavigationEnabled
                GuiService.CoreGuiNavigationEnabled = true
            end
        elseif property == "GuiNavigationEnabled" then
            if GuiService.GuiNavigationEnabled ~= false then
                GuiNavigationEnabled = GuiService.GuiNavigationEnabled
                GuiService.GuiNavigationEnabled = false
            end
        elseif property == "AutoSelectGuiEnabled" and GuiService.AutoSelectGuiEnabled ~= false then
            AutoSelectGuiEnabled = GuiService.AutoSelectGuiEnabled
            GuiService.AutoSelectGuiEnabled = false
        end
    end))
end

function DisconnectActiveEvents()
    for _, value in ipairs(tbl2) do
        value:Disconnect()
    end
    tbl2 = {}
end

function ShowPrompt()
    var2.Visible = true
    if isEnabled then
        UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
    end
    if bool2 then
        var1 = var1 or Dialog.new()

        var2.Position = uDim2_3
        var1:SetContent(var2)
        var1:Show(true)
        DisableControllerMovement()
        return
    end
    var2:TweenPositionInternal(uDim2_3, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.3, true, OnTweenInFinished)
    DisableControllerMovement()
    EnableControllerInput()
end

function HidePrompt()
    local function onClosed() -- Luacid: Inlined by compiler; 1 call site recovered
        IsCurrentlyPrompting = false
        GuiService.CoreGuiNavigationEnabled = CoreGuiNavigationEnabled
        GuiService.GuiNavigationEnabled = GuiNavigationEnabled
        GuiService.AutoSelectGuiEnabled = AutoSelectGuiEnabled
        GuiService.SelectedCoreObject = nil
        if isEnabled then
            UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
        end
        if bool1 then
            DisconnectActiveEvents()
            destroyPromptDialog()
            return
        end

        var2.Visible = false
    end

    if not bool2 then
        var2:TweenPositionInternal(uDim2_2, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.3, true, onClosed)

        return
    end

    var2.Position = uDim2_2
    if var1 then
        var1:Close()
    end

    onClosed()
end

function DoCreatePrompt(arg1)
    PromptCompletedCallback = arg1.PromptCompletedCallback
    AddDefaultsToPromptOptions(arg1, tbl1)
    var4 = arg1
    CreatePromptFromOptions(arg1)
    ShowPrompt()
end

function OnPromptEnded(arg1)
    if PromptCompletedCallback then
        if var4.CancelActive then
            spawn(function()
                PromptCompletedCallback(arg1)
            end)
        else
            spawn(function()
                PromptCompletedCallback(true)
            end)
        end
    end

    HidePrompt()
    EnableControllerMovement()
    DisableControllerInput()
end

function NoOpFunc() end

function EnableControllerMovement()
    ContextActionService:UnbindCoreAction("doNothingThumbstick2PromptCreator")
    ContextActionService:UnbindCoreAction("doNothingAButtonPromptCreator")
end

function DisableControllerMovement()
    ContextActionService:BindCoreAction("doNothingThumbstick2PromptCreator", NoOpFunc, false, Enum.KeyCode.Thumbstick2)
    ContextActionService:BindCoreAction("doNothingAButtonPromptCreator", NoOpFunc, false, Enum.KeyCode.ButtonA)
end

function EnableControllerInput()
    ContextActionService:BindCoreAction("CoreScriptPromptCreatorCancel", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end
        if var4.CancelActive then
            OnPromptEnded(false)
        end
    end, false, Enum.KeyCode.ButtonB)

    ContextActionService:BindCoreAction("CoreScriptPromptCreatorSelect", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end
        if GuiService.SelectedCoreObject == nil then
            SetSelectedObject()
        end
    end, false, Enum.KeyCode.ButtonSelect)
end

function DisableControllerInput()
    ContextActionService:UnbindCoreAction("CoreScriptPromptCreatorCancel")
    ContextActionService:UnbindCoreAction("CoreScriptPromptCreatorSelect")
end

function valueInTable(userInputType, arg1)
    for _, value in pairs(arg1) do
        if value == userInputType then
            return true
        end
    end
    return false
end

function SetupGamepadSelection()
    CoreGuiNavigationEnabled = GuiService.CoreGuiNavigationEnabled
    GuiNavigationEnabled = GuiService.GuiNavigationEnabled
    AutoSelectGuiEnabled = GuiService.AutoSelectGuiEnabled

    GuiService.SelectedCoreObject = nil
    GuiService.CoreGuiNavigationEnabled = true
    GuiService.GuiNavigationEnabled = false
    GuiService.AutoSelectGuiEnabled = false
end

if not bool1 then
    createPromptDialog()

    local function OnInputChanged(input: InputObject)
        local userInputType = input.UserInputType
        local userInputType2 = Enum.UserInputType
        if bool2
            or not valueInTable(
                userInputType,
                {
                    userInputType2.Gamepad1,
                    userInputType2.Gamepad2,
                    userInputType2.Gamepad3,
                    userInputType2.Gamepad4
                }
            )
        then
            bool7 = false
            return
        end

        if input.KeyCode ~= Enum.KeyCode.Thumbstick1 and input.KeyCode ~= Enum.KeyCode.Thumbstick2 then
            bool7 = true
            return
        end

        if math.abs(input.Position.X) > 0.1 or math.abs(input.Position.Z) > 0.1 or math.abs(input.Position.Y) > 0.1 then
            bool7 = true
        end
    end
    UserInputService.InputChanged:connect(OnInputChanged)
    UserInputService.InputBegan:connect(OnInputChanged)

    local function OnVREnabled(vrEnabled) -- Luacid: Inlined by compiler; 2 call sites recovered
        if vrEnabled then
            var1 = var1 or Dialog.new()

            var1:SetContent(var2)
            bool2 = true
            return
        end
        bool2 = false
        if var1 then
            var1:SetContent(nil)
        end
        var2.Parent = RobloxGui
    end

    spawn(function()
        OnVREnabled(UserInputService.VREnabled)
    end)

    UserInputService.Changed:connect(function(property: string)
        if property == "VREnabled" then
            OnVREnabled(UserInputService.VREnabled)
        end
    end)

    GuiService.Changed:connect(function(property: string)
        if not IsCurrentlyPrompting then
            return
        end

        if property == "CoreGuiNavigationEnabled" then
            if GuiService.CoreGuiNavigationEnabled ~= true then
                CoreGuiNavigationEnabled = GuiService.CoreGuiNavigationEnabled
                GuiService.CoreGuiNavigationEnabled = true
            end
        elseif property == "GuiNavigationEnabled" then
            if GuiService.GuiNavigationEnabled ~= false then
                GuiNavigationEnabled = GuiService.GuiNavigationEnabled
                GuiService.GuiNavigationEnabled = false
            end
        elseif property == "AutoSelectGuiEnabled" and GuiService.AutoSelectGuiEnabled ~= false then
            AutoSelectGuiEnabled = GuiService.AutoSelectGuiEnabled
            GuiService.AutoSelectGuiEnabled = false
        end
    end)
end

function module.CreatePrompt(_, arg1): boolean
    if IsCurrentlyPrompting then
        return false
    end
    IsCurrentlyPrompting = true

    if bool1 then
        createPromptDialog()
        ConnectActiveEvents()
    end

    SetupGamepadSelection()
    DoCreatePrompt(arg1)
    return true
end

function module.IsCurrentlyPrompting(_)
    return IsCurrentlyPrompting
end

return module
