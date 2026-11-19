-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local CorePackages = game:GetService("CorePackages")

local isTenFootInterface = require(CorePackages.Workspace.Packages.AppCommonLib).isTenFootInterface

local AvatarContextMenu = CoreGui:WaitForChild("RobloxGui"):WaitForChild("Modules"):WaitForChild("AvatarContextMenu")
local _ThemeHandler = require(AvatarContextMenu.ThemeHandler)
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.PlayerAdded:Wait()
    LocalPlayer = Players.LocalPlayer
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.GetHeadshotForPlayer(_, arg1)
    return "rbxthumb://type=AvatarHeadShot&id=" .. arg1.UserId .. "&w=150&h=150"
end

function tbl1.HasOrGettingHeadShot(arg1, arg2): boolean
    return arg1.HeadShotUrlCache[arg2] ~= nil
end

function tbl1.FindPlayerFromPart(_, character)
    if character and character.Parent then
        while character and not character:IsA("Model") do
            character = character.Parent
        end
        if character then
            return Players:GetPlayerFromCharacter(character)
        end
    end
    return nil
end

function tbl1.GetPlayerPosition(_, arg1)
    if arg1.Character then
        local humanoidRootPart = arg1.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            return humanoidRootPart.Position
        end
    end
    return nil
end

local bool1 = true

function tbl1.DisablePlayerMovement(_)
    if not bool1 then
        return
    end

    bool1 = false

    ContextActionService:BindCoreActionAtPriority("AvatarContextMenuStopInput", function(_, userInputState): Enum.ContextActionResult
        return if userInputState == Enum.UserInputState.End then Enum.ContextActionResult.Pass else Enum.ContextActionResult.Sink
    end, false, Enum.ContextActionPriority.Low.Value, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump, Enum.UserInputType.Gamepad1, Enum.UserInputType.Gamepad2, Enum.UserInputType.Gamepad3, Enum.UserInputType.Gamepad4)
end

function tbl1.EnablePlayerMovement(_)
    if bool1 then
        return
    end

    bool1 = true

    ContextActionService:UnbindCoreAction("AvatarContextMenuStopInput")
end

function tbl1.GetFriendStatus(_, player: Player)
    local success, result = pcall(function(): Enum.FriendStatus
        return LocalPlayer:GetFriendStatus(player)
    end)
    return if success then result else Enum.FriendStatus.NotFriend
end

local tbl2 = ({})
coroutine.wrap(function()
    RobloxReplicatedStorage:WaitForChild("CanChatWith", math.huge).OnClientEvent:Connect(function(...)
        local tbl3 = { ... }

        if #tbl3 == 1 then
            for k, value in pairs(tbl3[1]) do
                tbl2[k] = value
            end

            return
        end
        if #tbl3 == 2 then
            tbl2[tbl3[1]] = tbl3[2]
        end
    end)
end)()

function tbl1.GetCanChatWith(_, arg1)
    return not BlockingUtility:IsPlayerBlockedByUserId(arg1.UserId) and (tbl2[arg1.UserId] == nil or tbl2[arg1.UserId])
end

local imageLabel = Instance.new("ImageLabel")
imageLabel.Image = ""
imageLabel.BackgroundTransparency = 1

local function MakeDefaultButton(imageButtonName, imageButtonSize, callback, arg1): ImageButton
    local imageButton = Instance.new("ImageButton")
    imageButton.Name = imageButtonName
    imageButton.Image = arg1.ButtonImage
    imageButton.ScaleType = arg1.ButtonImageScaleType
    imageButton.SliceCenter = arg1.ButtonImageSliceCenter
    imageButton.BackgroundColor3 = arg1.ButtonColor
    imageButton.BackgroundTransparency = arg1.ButtonTransparency
    imageButton.AutoButtonColor = false
    imageButton.Size = imageButtonSize
    imageButton.ZIndex = 2
    imageButton.SelectionImageObject = imageLabel
    imageButton.BorderSizePixel = 0

    local underline = Instance.new("Frame")
    underline.Name = "Underline"
    underline.BackgroundColor3 = arg1.ButtonUnderlineColor
    underline.AnchorPoint = Vector2.new(0.5, 1)
    underline.BorderSizePixel = 0
    underline.Position = UDim2.new(0.5, 0, 1, 0)
    underline.Size = UDim2.new(0.95, 0, 0, 1)
    underline.Parent = imageButton

    if callback then
        imageButton.MouseButton1Click:Connect(function()
            callback(UserInputService:GetLastInputType())
        end)
    end

    local function isPointerInput(input): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
    end

    local function selectButton() -- Luacid: Inlined by compiler; 3 call sites recovered
        imageButton.BackgroundColor3 = arg1.ButtonHoverColor
        imageButton.BackgroundTransparency = arg1.ButtonHoverTransparency
    end

    local function deselectButton() -- Luacid: Inlined by compiler; 4 call sites recovered
        imageButton.BackgroundColor3 = arg1.ButtonColor
        imageButton.BackgroundTransparency = arg1.ButtonTransparency
    end

    imageButton.InputBegan:Connect(function(input: InputObject)
        if not imageButton.Selectable or not isPointerInput(input) then
            return
        end

        selectButton()

        input:GetPropertyChangedSignal("UserInputState"):connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                deselectButton()
            end
        end)
    end)

    imageButton.InputEnded:Connect(function(input: InputObject)
        if imageButton.Selectable and GuiService.SelectedCoreObject ~= imageButton and isPointerInput(input) then
            deselectButton()
        end
    end)

    imageButton.SelectionGained:Connect(function()
        selectButton()
    end)

    imageButton.SelectionLost:Connect(function()
        deselectButton()
    end)

    local _connection = GuiService.Changed:Connect(function(property: string)
        if property ~= "SelectedCoreObject" then
            return
        end
        if GuiService.SelectedCoreObject == nil or GuiService.SelectedCoreObject ~= imageButton then
            deselectButton()
        elseif imageButton.Selectable then
            selectButton()
        end
    end)

    return imageButton
end

local function getViewportSize(): Vector2
    while not workspace.CurrentCamera do
        workspace.Changed:Wait()
    end
    assert(workspace.CurrentCamera, "")

    while workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) or workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) do
        workspace.CurrentCamera.Changed:Wait()
    end

    return workspace.CurrentCamera.ViewportSize
end

local function isSmallTouchScreen(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local viewportSize = getViewportSize()
    return UserInputService.TouchEnabled and (viewportSize.Y < 500 or viewportSize.X < 700)
end

function tbl1.MakeStyledButton(_, name, textLabelText, size, callback, arg1)
    local imageButton = MakeDefaultButton(name, size, callback, arg1)

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = name .. "TextLabel"
    textLabel.BackgroundTransparency = 1
    textLabel.BorderSizePixel = 0
    textLabel.Size = UDim2.new(1, 0, 1, -8)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.Font = arg1.Font
    textLabel.TextSize = 24 * arg1.TextScale

    if isSmallTouchScreen() then
        textLabel.TextSize = 18 * arg1.TextScale
    elseif isTenFootInterface() then
        textLabel.TextSize = 36 * arg1.TextScale
    end
    textLabel.Text = textLabelText
    textLabel.TextScaled = true
    textLabel.TextWrapped = true
    textLabel.ZIndex = 2
    textLabel.Parent = imageButton

    Instance.new("UITextSizeConstraint", textLabel).MaxTextSize = textLabel.TextSize

    return imageButton, textLabel
end

function tbl1.new()
    return (setmetatable({}, tbl1))
end

return tbl1.new()
