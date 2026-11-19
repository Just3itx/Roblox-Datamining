-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    [Enum.DialogPurpose.Quest] = { "rbxasset://textures/ui/dialog_purpose_quest.png", Vector2.new(10, 34) },
    [Enum.DialogPurpose.Help] = { "rbxasset://textures/ui/dialog_purpose_help.png", Vector2.new(20, 35) },
    [Enum.DialogPurpose.Shop] = { "rbxasset://textures/ui/dialog_purpose_shop.png", Vector2.new(22, 43) }
}

local num1 = 24
local Size24 = Enum.FontSize.Size24

local vector2 = Vector2.new(80, 90)
local xOffset = 350

local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local bool1 = false

local bool2 = false
local LocalPlayer = Players.LocalPlayer
while LocalPlayer == nil do
    Players.PlayerAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local Character = LocalPlayer.Character
Character = Character and Character.Parent ~= nil and Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function(character: Model)
    Character = character
end)

function setUsingGamepad(arg1, _)
    if arg1.UserInputType == Enum.UserInputType.Gamepad1
        or arg1.UserInputType == Enum.UserInputType.Gamepad2
        or arg1.UserInputType == Enum.UserInputType.Gamepad3
        or arg1.UserInputType == Enum.UserInputType.Gamepad4
    then
        bool1 = true
        return
    end
    bool1 = false
end

game:GetService("UserInputService").InputBegan:Connect(setUsingGamepad)
game:GetService("UserInputService").InputChanged:Connect(setUsingGamepad)

local frame = nil
local tbl2 = {
    nil,
    nil,
    nil,
    nil
}
local var1 = nil
local tbl3 = {}
local var2 = nil
local var3 = nil

local tbl4 = ({})
local var4 = nil

local CoreGui = game:GetService("CoreGui")
local _CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui.RobloxGui
local SetDialogInUse = game:GetService("RobloxReplicatedStorage"):WaitForChild("SetDialogInUse", math.huge)

local billboardGui = nil
local frame2 = nil
local tbl5 = ({})
local tbl6 = ({})
local TouchControlFrame = nil
local bool3 = false

local isEnabled = require(RobloxGui.Modules.TenFootInterface):IsEnabled()
local Utility = require(RobloxGui.Modules.Settings.Utility)
local GameTranslator = require(RobloxGui.Modules.GameTranslator)
local isSmallTouchScreen = Utility:IsSmallTouchScreen()

if isEnabled then
    Size24 = Enum.FontSize.Size36
    num1 = 36
    xOffset = 500
elseif isSmallTouchScreen then
    Size24 = Enum.FontSize.Size14
    num1 = 14
    xOffset = 250
end

local var5 = if RobloxGui:FindFirstChild("ControlFrame") then RobloxGui.ControlFrame else RobloxGui
local TouchEnabled = game:GetService("UserInputService").TouchEnabled

local function isDialogMultiplePlayers(arg1) -- Luacid: unused: defined but never referenced
    local success, result = pcall(function(): boolean
        return arg1.BehaviorType == Enum.DialogBehaviorType.MultiplePlayers
    end)

    if not (success and result) then
        result = false
    end

    return result
end

function currentTone()
    return if var2 then var2.Tone else Enum.DialogTone.Neutral
end

function createChatNotificationGui()
    billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ChatNotificationGui"
    billboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
    billboardGui.Size = UDim2.new(vector2.X / 31.5, 0, vector2.Y / 31.5, 0)
    billboardGui.SizeOffset = Vector2.new(0, 0)
    billboardGui.StudsOffset = Vector3.new(0, 3.7, 0)
    billboardGui.Enabled = true
    billboardGui.RobloxLocked = true
    billboardGui.Active = true

    local background = Instance.new("ImageButton")
    background.Name = "Background"
    background.Active = false
    background.BackgroundTransparency = 1
    background.Position = UDim2.new(0, 0, 0, 0)
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Image = ""
    background.Parent = billboardGui

    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Position = UDim2.new(0, 0, 0, 0)
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.Image = ""
    icon.BackgroundTransparency = 1
    icon.Parent = background

    local activationButton = Instance.new("ImageLabel")
    activationButton.Name = "ActivationButton"
    activationButton.Position = UDim2.new(-0.3, 0, -0.4, 0)
    activationButton.Size = UDim2.new(0.8, 0, 0.8 * (vector2.X / vector2.Y), 0)
    activationButton.Image = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonX)
    activationButton.BackgroundTransparency = 1
    activationButton.Visible = false
    activationButton.Parent = background
end

function getChatColor(dialogTone)
    if dialogTone == Enum.DialogTone.Neutral then
        return Enum.ChatColor.Blue
    end

    if dialogTone == Enum.DialogTone.Friendly then
        return Enum.ChatColor.Green
    end

    if dialogTone == Enum.DialogTone.Enemy then
        return Enum.ChatColor.Red
    end
end

function styleChoices()
    for _, value in pairs(tbl2) do
        value.BackgroundTransparency = 1
    end
    var1.BackgroundTransparency = 1
end

function styleMainFrame(dialogTone)
    if dialogTone == Enum.DialogTone.Neutral then
        frame.Style = Enum.FrameStyle.ChatBlue
    elseif dialogTone == Enum.DialogTone.Friendly then
        frame.Style = Enum.FrameStyle.ChatGreen
    elseif dialogTone == Enum.DialogTone.Enemy then
        frame.Style = Enum.FrameStyle.ChatRed
    end

    styleChoices()
end

function setChatNotificationTone(clone, purpose, dialogTone)
    if dialogTone == Enum.DialogTone.Neutral then
        clone.Background.Image = "rbxasset://textures/ui/chatBubble_blue_notify_bkg.png"
    elseif dialogTone == Enum.DialogTone.Friendly then
        clone.Background.Image = "rbxasset://textures/ui/chatBubble_green_notify_bkg.png"
    elseif dialogTone == Enum.DialogTone.Enemy then
        clone.Background.Image = "rbxasset://textures/ui/chatBubble_red_notify_bkg.png"
    end

    local image, var7 = unpack(tbl1[purpose])
    local var8 = var7 / vector2
    clone.Background.Icon.Size = UDim2.new(var8.X, 0, var8.Y, 0)
    clone.Background.Icon.Position = UDim2.new(0.5 - var8.X / 2, 0, 0.4 - var8.Y / 2, 0)
    clone.Background.Icon.Image = image
end

function createMessageDialog()
    frame2 = Instance.new("Frame")
    frame2.Name = "DialogScriptMessage"
    frame2.Style = Enum.FrameStyle.Custom
    frame2.BackgroundTransparency = 0.5
    frame2.BackgroundColor3 = Color3.new(31 / 255, 31 / 255, 31 / 255)
    frame2.Visible = false
    frame2.RobloxLocked = true

    local text = Instance.new("TextLabel")
    text.Name = "Text"
    text.Position = UDim2.new(0, 0, 0, -1)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.FontSize = Enum.FontSize.Size14
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Parent = frame2
end

function showMessage(text, xOffset2: number?)
    frame2.Text.Text = text
    frame2.Size = UDim2.new(0, xOffset2, 0, 40)
    frame2.Position = UDim2.new(0.5, -xOffset2 / 2, 0.5, -40)
    frame2.Visible = true
    wait(2)
    frame2.Visible = false
end

function variableDelay(arg1)
    local num2 = math.min(string.len(arg1), 100)
    wait(num2 / 75 * 1.5 + 0.75)
end

function resetColor(arg1)
    arg1.BackgroundTransparency = 1
end

function wanderDialog()
    frame.Visible = false
    endDialog()
    showMessage("Chat ended because you walked away", 350)
end

function timeoutDialog()
    frame.Visible = false
    endDialog()
    showMessage("Chat ended because you didn't reply", 350)
end

function normalEndDialog()
    endDialog()
end

function endDialog()
    if var4 then
        tbl4[var4] = false
        var4 = nil
    end

    local var6 = var2
    var2 = nil
    if var6 and var6.InUse then
        delay(5, function()
            SetDialogInUse:FireServer(var6, false)
            var6.InUse = false
        end)
    end

    for k, value in pairs(tbl5) do
        if k and value then
            value.Enabled = not k.InUse
        end
    end

    ContextActionService:UnbindCoreAction("Nothing")
    var3 = nil

    if TouchControlFrame then
        TouchControlFrame.Visible = true
    end

    if bool3 then
        var5.BottomLeftControl.Visible = false
    end

    if GuiService.SelectedCoreObject and GuiService.SelectedCoreObject.Parent == frame then
        GuiService.SelectedCoreObject = nil
    end
end

function sanitizeMessage(arg1)
    return if string.len(arg1) == 0 then "..." else arg1
end

local function chatFunc(arg1, ...)
    local success, result = pcall(function(): boolean
        return arg1.BehaviorType == Enum.DialogBehaviorType.MultiplePlayers
    end)

    if success and result then
        game:GetService("Chat"):ChatLocal(...)
        return
    end
    game:GetService("Chat"):Chat(...)
end

function selectChoice(textButton)
    if not var2 then
        return
    end

    renewKillswitch(var2)

    if not Character:FindFirstAncestorOfClass("Workspace") then
        return
    end

    frame.Visible = false
    if textButton == var1 then
        chatFunc(var2, Character, var1.UserPrompt.Text, getChatColor(currentTone()))

        normalEndDialog()
        return
    end
    local var6 = tbl3[textButton]

    chatFunc(var2, Character, sanitizeMessage(var6.UserDialog), getChatColor(currentTone()))
    wait(1)

    if not var2 then
        return
    end

    var2:SignalDialogChoiceSelected(LocalPlayer, var6)
    chatFunc(var2, var3, sanitizeMessage(var6.ResponseDialog), getChatColor(currentTone()))

    variableDelay(var6.ResponseDialog)
    presentDialogChoices(var3, var6:GetChildren(), var6)
end

function newChoice(): TextButton
    local frame3 = Instance.new("Frame")
    frame3.Visible = false

    local textButton = Instance.new("TextButton")
    textButton.BackgroundColor3 = Color3.new(227 / 255, 227 / 255, 227 / 255)
    textButton.BackgroundTransparency = 1
    textButton.AutoButtonColor = false
    textButton.BorderSizePixel = 0
    textButton.Text = ""
    textButton.MouseEnter:connect(function()
        textButton.BackgroundTransparency = 0
    end)
    textButton.MouseLeave:connect(function()
        textButton.BackgroundTransparency = 1
    end)
    textButton.SelectionImageObject = frame3
    textButton.Activated:connect(function()
        selectChoice(textButton)
    end)
    textButton.RobloxLocked = true

    local userPrompt = Instance.new("TextLabel")

    userPrompt.AutoLocalize = false
    userPrompt.Name = "UserPrompt"
    userPrompt.BackgroundTransparency = 1
    userPrompt.Font = Enum.Font.SourceSans
    userPrompt.FontSize = Size24
    userPrompt.Position = UDim2.new(0, 40, 0, 0)
    userPrompt.Size = UDim2.new(1, -72, 1, 0)
    userPrompt.TextXAlignment = Enum.TextXAlignment.Left
    userPrompt.TextYAlignment = Enum.TextYAlignment.Center
    userPrompt.TextWrap = true
    userPrompt.Parent = textButton

    local rbXchatDialogSelectionButton = Instance.new("ImageLabel")
    rbXchatDialogSelectionButton.Name = "RBXchatDialogSelectionButton"
    rbXchatDialogSelectionButton.Position = UDim2.new(0, 0, 0.5, -16.5)
    rbXchatDialogSelectionButton.Size = UDim2.new(0, 33, 0, 33)
    rbXchatDialogSelectionButton.Image = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonA)
    rbXchatDialogSelectionButton.BackgroundTransparency = 1
    rbXchatDialogSelectionButton.Visible = false
    rbXchatDialogSelectionButton.Parent = textButton

    return textButton
end

function initialize(frame3)
    for i = 1, 4 do -- Luacid: Re-rolled loop
        tbl2[i] = newChoice()
    end

    var1 = newChoice()
    var1.UserPrompt.Text = "Goodbye!"
    var1.Size = UDim2.new(1, 28, 0, num1 + 12)

    frame = Instance.new("Frame")
    frame.Name = "UserDialogArea"
    frame.Size = UDim2.new(0, xOffset, 0, 200)
    frame.Style = Enum.FrameStyle.ChatBlue
    frame.Visible = false

    for _, value in pairs(tbl2) do
        value.RobloxLocked = true
        value.Parent = frame
    end

    var1.RobloxLocked = true
    var1.Parent = frame

    frame.RobloxLocked = true
    frame.Parent = frame3
end

function presentDialogChoices(arg1, children, arg2)
    if not var2 then
        return
    end

    var3 = arg1
    local tbl7 = {}
    for _, child in pairs(children) do
        if child:IsA("DialogChoice") then
            table.insert(tbl7, child)
        end
    end
    table.sort(tbl7, function(arg3, arg4): boolean
        return arg3.Name < arg4.Name
    end)

    if #tbl7 == 0 then
        normalEndDialog()
        return
    end

    local num2 = 1
    local num3 = 0
    tbl3 = {}
    for _, value in pairs(tbl2) do
        value.Visible = false
    end

    for _, value in pairs(tbl7) do
        if not (num2 <= #tbl2) then
            continue
        end
        tbl2[num2].Size = UDim2.new(1, 28, 0, num1 * 3)
        GameTranslator:TranslateAndRegister(tbl2[num2].UserPrompt, value, value.UserDialog)
        local yOffset = math.ceil(tbl2[num2].UserPrompt.TextBounds.Y / num1) * num1 + 12

        tbl2[num2].Position = UDim2.new(0, -11, 0, num3 + -8)
        tbl2[num2].Size = UDim2.new(1, 28, 0, yOffset)
        tbl2[num2].Visible = true

        tbl3[tbl2[num2]] = value

        num3 = num3 + yOffset + 1
        num2 += 1
    end

    var1.Size = UDim2.new(1, 28, 0, num1 * 3)
    var1.UserPrompt.Text = if arg2.GoodbyeDialog == "" then "Goodbye!" else arg2.GoodbyeDialog
    local yOffset = math.ceil(var1.UserPrompt.TextBounds.Y / num1) * num1 + 12
    var1.Size = UDim2.new(1, 28, 0, yOffset)
    var1.Position = UDim2.new(0, -11, 0, num3 + -8)
    var1.Visible = true

    if not arg2.GoodbyeChoiceActive then
        var1.Visible = false
        frame.Size = UDim2.new(0, xOffset, 0, num3 + 34 + -16)
    else
        frame.Size = UDim2.new(0, xOffset, 0, num3 + var1.AbsoluteSize.Y + 34 + -16)
    end

    frame.Position = UDim2.new(0, 20, 1, -frame.Size.Y.Offset - 20)
    if isSmallTouchScreen then
        local touchGui = LocalPlayer.PlayerGui:FindFirstChild("TouchGui")
        TouchControlFrame = touchGui and touchGui:FindFirstChild("TouchControlFrame")

        if TouchControlFrame then
            TouchControlFrame.Visible = false
        end

        frame.Position = UDim2.new(0, 10, 1, -frame.Size.Y.Offset)
    elseif not (TouchEnabled or var5.BottomLeftControl.Visible) then
        var5.BottomLeftControl.Visible = true
        bool3 = true
    end

    styleMainFrame(currentTone())
    frame.Visible = true

    if bool1 then
        game:GetService("GuiService").SelectedCoreObject = tbl2[1]
    end
end

function doDialog(arg1)
    if arg1.InitialPrompt == "" then
        warn("Can't start a dialog with an empty InitialPrompt")
        return
    end

    local success, result = pcall(function(): boolean
        return arg1.BehaviorType == Enum.DialogBehaviorType.MultiplePlayers
    end)

    local var6 = if success then result or false else false

    if arg1.InUse and not var6 then
        return
    end
    var2 = arg1
    arg1.InUse = true

    ContextActionService:BindCoreAction("Nothing", function() end, false, Enum.UserInputType.Gamepad1, Enum.UserInputType.Gamepad2, Enum.UserInputType.Gamepad3, Enum.UserInputType.Gamepad4)

    SetDialogInUse:FireServer(arg1, true)

    chatFunc(arg1, arg1.Parent, arg1.InitialPrompt, getChatColor(arg1.Tone))
    variableDelay(arg1.InitialPrompt)

    presentDialogChoices(arg1.Parent, arg1:GetChildren(), arg1)
end

function renewKillswitch(arg1)
    if var4 then
        tbl4[var4] = false
        var4 = nil
    end

    var4 = coroutine.create(function(arg2)
        wait(15)
        if arg2 == nil then
            return
        end

        if tbl4[arg2] == nil then
            SetDialogInUse:FireServer(arg1, false)
            arg1.InUse = false
        end
        tbl4[arg2] = nil
    end)

    coroutine.resume(var4, var4)
end

function checkForLeaveArea()
    while var2 do
        if var2.Parent and LocalPlayer:DistanceFromCharacter(var2.Parent.Position) >= var2.ConversationDistance then
            wanderDialog()
        end
        wait(1)
    end
end

function startDialog(arg1)
    if not arg1.Parent or not arg1.Parent:IsA("BasePart") then
        return
    end

    RbxAnalyticsService:TrackEvent("Dialogue", "Old Dialogue", "Conversation Initiated")

    if LocalPlayer:DistanceFromCharacter(arg1.Parent.Position) >= arg1.ConversationDistance then
        showMessage("You are too far away to chat!", 300)
        return
    end

    for k, value in pairs(tbl5) do
        if k and value then
            value.Enabled = false
        end
    end

    renewKillswitch(arg1)

    delay(1, checkForLeaveArea)
    doDialog(arg1)
end

function removeDialog(arg1)
    if tbl5[arg1] then
        tbl5[arg1]:Destroy()
        tbl5[arg1] = nil
    end
    if tbl6[arg1] then
        tbl6[arg1]:disconnect()
        tbl6[arg1] = nil
    end
end

function addDialog(dialog)
    if not dialog.Parent then
        return
    end

    if not dialog.Parent:IsA("BasePart") or not dialog:IsDescendantOf(game.Workspace) then
        tbl6[dialog] = dialog.Changed:connect(function(arg1)
            if arg1 == "Parent" and dialog.Parent then
                removeDialog(dialog)
                addDialog(dialog)
            end
        end)

        return
    end

    bool2 = true
    RbxAnalyticsService:TrackEvent("Dialogue", "Old Dialogue", "Used In Place", nil, game.PlaceId)

    local billboardGuiClone = billboardGui:clone()
    billboardGuiClone.Adornee = dialog.Parent
    billboardGuiClone.RobloxLocked = true
    local bool4 = not dialog.InUse

    if not bool4 then
        local success, result = pcall(function(): boolean
            return dialog.BehaviorType == Enum.DialogBehaviorType.MultiplePlayers
        end)

        if success then
            bool4 = result or false
        else
            bool4 = false
        end
    end

    billboardGuiClone.Enabled = bool4
    billboardGuiClone.Parent = CoreGui

    billboardGuiClone.Background.MouseButton1Click:connect(function()
        startDialog(dialog)
    end)
    setChatNotificationTone(billboardGuiClone, dialog.Purpose, dialog.Tone)

    if game:GetEngineFeature("ClosestVisibleDialogAPI") then
        dialog:SetGuiObject(billboardGuiClone)
    end
    tbl5[dialog] = billboardGuiClone

    tbl6[dialog] = dialog.Changed:connect(function(arg1)
        if arg1 == "Parent" and dialog.Parent then
            removeDialog(dialog)
            addDialog(dialog)
            return
        end

        if arg1 ~= "InUse" then
            if arg1 == "Tone" or arg1 == "Purpose" then
                setChatNotificationTone(billboardGuiClone, dialog.Purpose, dialog.Tone)
            end

            return
        end

        local var6 = dialog

        local success, result = pcall(function(): boolean
            return var6.BehaviorType == Enum.DialogBehaviorType.MultiplePlayers
        end)

        if not (success and result) then
            local var7 = billboardGuiClone
            var7.Enabled = var2 == nil and not dialog.InUse
        else
            billboardGuiClone.Enabled = var2 ~= dialog
        end

        if dialog.InUse then
            return
        end

        local var7 = dialog

        local success2, result2 = pcall(function(): boolean
            return var7.BehaviorType == Enum.DialogBehaviorType.MultiplePlayers
        end)

        if not (success2 and result2) and dialog == var2 then
            timeoutDialog()
        end
    end)
end

function onLoad()
    createChatNotificationGui()

    createMessageDialog()
    frame2.RobloxLocked = true
    frame2.Parent = var5

    var5:WaitForChild("BottomLeftControl")

    local dialogFrame = Instance.new("Frame")
    dialogFrame.Name = "DialogFrame"
    dialogFrame.Position = UDim2.new(0, 0, 0, 0)
    dialogFrame.Size = UDim2.new(0, 0, 0, 0)
    dialogFrame.BackgroundTransparency = 1
    dialogFrame.RobloxLocked = true

    game:GetService("GuiService"):AddSelectionParent("RBXDialogGroup", dialogFrame)

    if TouchEnabled and not isSmallTouchScreen then
        dialogFrame.Position = UDim2.new(0, 20, 0.5, 0)
        dialogFrame.Size = UDim2.new(0.25, 0, 0.1, 0)
        dialogFrame.Parent = var5
    elseif isSmallTouchScreen then
        dialogFrame.Position = UDim2.new(0, 0, 0.9, -10)
        dialogFrame.Size = UDim2.new(0.25, 0, 0.1, 0)
        dialogFrame.Parent = var5
    else
        dialogFrame.Parent = var5.BottomLeftControl
    end
    initialize(dialogFrame)

    game:GetService("CollectionService").ItemAdded:Connect(function(instance: Instance)
        if instance:IsA("Dialog") then
            addDialog(instance)
        end
    end)
    game:GetService("CollectionService").ItemRemoved:Connect(function(instance: Instance)
        if instance:IsA("Dialog") then
            removeDialog(instance)
        end
    end)
    for _, value in pairs(game:GetService("CollectionService"):GetCollection("Dialog")) do
        if value:IsA("Dialog") then
            addDialog(value)
        end
    end
end

function getLocalHumanoidRootPart()
    if LocalPlayer.Character then
        return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end
end

function dialogIsValid(arg1)
    return arg1 and arg1.Parent and arg1.Parent:IsA("BasePart")
end

local var6 = nil
local GetClosestDialogToPosition = GuiService.GetClosestDialogToPosition

game:GetService("RunService").Heartbeat:Connect(function()
    local var7 = nil

    local localHumanoidRootPart = getLocalHumanoidRootPart()
    if localHumanoidRootPart then
        local localHumanoidRootPartPosition = localHumanoidRootPart.Position
        var7 = GetClosestDialogToPosition(GuiService, localHumanoidRootPartPosition)
    end

    if getLocalHumanoidRootPart() and dialogIsValid(var7) and var2 == nil then
        local triggerDistance = var7.TriggerDistance
        local triggerOffset = var7.TriggerOffset

        local var8 = LocalPlayer:DistanceFromCharacter(var7.Parent.Position + triggerOffset)

        if triggerDistance ~= 0 and var8 < var7.ConversationDistance and var8 < triggerDistance then
            startDialog(var7)
        end
    end

    if bool1 ~= true then
        return
    end

    if localHumanoidRootPart and game:GetEngineFeature("ClosestVisibleDialogAPI") then
        local localHumanoidRootPartPosition = localHumanoidRootPart.Position
        var7 = GuiService.GetClosestVisibleDialogToPosition(GuiService, localHumanoidRootPartPosition)
    end
    if var7 == var6 then
        return
    end

    if tbl5[var6] then
        tbl5[var6].Background.ActivationButton.Visible = false
    end
    var6 = var7
    ContextActionService:UnbindCoreAction("StartDialogAction")
    if var7 == nil then
        return
    end

    ContextActionService:BindCoreAction("StartDialogAction", function(_, userInputState, _)
        if userInputState == Enum.UserInputState.Begin and var7 and var7.Parent then
            startDialog(var7)
        end
    end, false, Enum.KeyCode.ButtonX)
    if tbl5[var7] then
        tbl5[var7].Background.ActivationButton.Visible = true
    end
end)

local SelectedCoreObject = nil

GuiService.Changed:connect(function(property: string)
    if property ~= "SelectedCoreObject" then
        return
    end

    if SelectedCoreObject and SelectedCoreObject:FindFirstChild("RBXchatDialogSelectionButton") then
        SelectedCoreObject:FindFirstChild("RBXchatDialogSelectionButton").Visible = false
        SelectedCoreObject.BackgroundTransparency = 1
    end
    SelectedCoreObject = GuiService.SelectedCoreObject
    if SelectedCoreObject and SelectedCoreObject:FindFirstChild("RBXchatDialogSelectionButton") then
        SelectedCoreObject:FindFirstChild("RBXchatDialogSelectionButton").Visible = true
        SelectedCoreObject.BackgroundTransparency = 0
    end
end)

onLoad()
