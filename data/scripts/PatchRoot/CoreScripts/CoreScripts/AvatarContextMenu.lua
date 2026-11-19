-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local isStudio = game:GetService("RunService"):IsStudio()
local bool1 = false

local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local tweenInfo2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local CorePackages = game:GetService("CorePackages")

local bool2 = false
function enableAvatarContextMenu(arg1)
    bool1 = not not arg1
    if bool1 and not bool2 then
        bool2 = true
        RbxAnalyticsService:TrackEvent("Game", "AvatarContextMenuEnabled", "placeId: " .. tostring(game.PlaceId))
    end
end

StarterGui:RegisterSetCore("SetAvatarContextMenuEnabled", enableAvatarContextMenu)
StarterGui:RegisterSetCore("AvatarContextMenuEnabled", enableAvatarContextMenu)

StarterGui:RegisterGetCore("AvatarContextMenuEnabled", function()
    return bool1
end)

local Modules = CoreGui.RobloxGui.Modules
local AvatarContextMenu = Modules.AvatarContextMenu

local ContextMenuGui = require(AvatarContextMenu.ContextMenuGui)
local ContextMenuItems = require(AvatarContextMenu.ContextMenuItems)
local ContextMenuUtil = require(AvatarContextMenu.ContextMenuUtil)
local SelectedCharacterIndicator = require(AvatarContextMenu.SelectedCharacterIndicator)
local ThemeHandler = require(AvatarContextMenu.ThemeHandler)

local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local BackpackScript = if FFlagEnableNewBackpack then nil else require(Modules.BackpackScript)
local EmotesMenuMaster = require(Modules.EmotesMenu.EmotesMenuMaster)

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)

local FFlagAvatarContextMenuItemsChatButtonRefactor = require(Modules.Flags.FFlagAvatarContextMenuItemsChatButtonRefactor)

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserRaycastUpdateAPI2")
end)
local var1 = success and result

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.PlayerAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

if LocalPlayer.UserId <= 0 and not isStudio then
    return
end

local bool3 = false

local bool4 = false
local var2 = nil

local currentInput = nil
local var3 = nil

local currentInput2 = nil

local connection = nil

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

local instance = ContextMenuGui:CreateMenuFrame(ThemeHandler:GetTheme())
local contextMenuItems = ContextMenuItems.new(instance.Content.ContextActionList)

function SetSelectedPlayer(arg1, arg2)
    if var2 == arg1 then
        return
    end

    var2 = arg1
    SelectedCharacterIndicator:ChangeSelectedPlayer(var2, ThemeHandler:GetTheme())

    if FFlagAvatarContextMenuItemsChatButtonRefactor then
        local tbl1 = {}
        local success2, result2 = pcall(function(): boolean
            return Chat:CanUserChatAsync(LocalPlayer.UserId)
        end)

        tbl1.localPlayerChatEnabled = success2 and (RunService:IsStudio() or result2)
        tbl1.localPlayerCanChatWithSelectedPlayer = false
        if var2 then
            tbl1.localPlayerCanChatWithSelectedPlayer = ContextMenuUtil:GetCanChatWith(var2)
        end
        contextMenuItems:BuildContextMenuItems(var2, tbl1)
    else
        contextMenuItems:BuildContextMenuItems(var2)
    end

    ContextMenuGui:SwitchToPlayerEntry(var2, arg2)
end

function OpenMenu(theme)
    bool3 = true

    instance.Visible = true
    instance.Content.ContextActionList.CanvasPosition = Vector2.new(0, 0)
    instance.Position = theme.OffScreenPosition

    connection = ContextMenuGui.SelectedPlayerChanged:connect(function()
        SetSelectedPlayer(ContextMenuGui:GetSelectedPlayer())
    end)

    instance.Position = theme.OffScreenPosition
    local tween = TweenService:Create(instance, tweenInfo, { Position = theme.OnScreenPosition })
    tween:Play()
    tween.Completed:wait()

    bool3 = false
end

function BindMenuActions()
    local function func1(_, userInputState, _) -- Luacid: Inlined by compiler; 1 call site recovered
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end
        CloseContextMenu()
    end
    ContextActionService:BindCoreAction("EscapeAvatarContextMenu", func1, false, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB)

    ContextActionService:BindCoreAction("SwitchPageAvatarContextMenu", function(_, userInputState, arg1)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end

        if arg1.KeyCode == Enum.KeyCode.ButtonR1 then
            ContextMenuGui:OffsetPlayerEntry(1)
            return
        end

        if arg1.KeyCode == Enum.KeyCode.ButtonL1 then
            ContextMenuGui:OffsetPlayerEntry(-1)
        end
    end, false, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL1)

    local connection2 = nil
    connection2 = GuiService.MenuOpened:connect(function()
        connection2:disconnect()
        func1(nil, Enum.UserInputState.Begin, nil)
    end)
end

function BuildPlayerCarousel(_, arg1)
    local tbl1 = {}
    local players = Players:GetPlayers()
    for i = 1, #players do
        if not (players[i].UserId > 0 or isStudio) or players[i] == LocalPlayer then
            continue
        end

        local playerPosition = ContextMenuUtil:GetPlayerPosition(players[i])
        if not playerPosition then
            continue
        end

        local magnitude = (arg1 - playerPosition).magnitude
        table.insert(tbl1, { players[i], magnitude })
    end

    table.sort(tbl1, function(arg2, arg3): boolean -- name: closestPlayerComp
        return arg2[2] > arg3[2]
    end)
    ContextMenuGui:BuildPlayerCarousel(tbl1, ThemeHandler:GetTheme())
end

Players.PlayerRemoving:connect(function(player: Player)
    if bool4 and player ~= var2 then
        ContextMenuGui:RemovePlayerEntry(player)
    end
end)

local function CloseOtherOpenCoreGui() -- Luacid: Inlined by compiler; 1 call site recovered
    if EmotesMenuMaster:isOpen() then
        EmotesMenuMaster:close()
    end

    if FFlagEnableNewBackpack then
        Features.setVisibility(Features.FeatureName.Backpack, false)
    elseif BackpackScript.IsOpen then
        BackpackScript.OpenClose()
    end
end

function OpenContextMenu(arg1, arg2)
    if bool3 or bool4 or not bool1 then
        return
    end

    bool4 = true
    CloseOtherOpenCoreGui()
    BuildPlayerCarousel(arg1, arg2)
    ContextMenuUtil:DisablePlayerMovement()
    BindMenuActions()
    SetSelectedPlayer(arg1, true)

    ContextMenuGui:UpdateGuiTheme(ThemeHandler:GetTheme())
    OpenMenu(ThemeHandler:GetTheme())
end

function CloseContextMenu()
    GuiService.SelectedCoreObject = nil

    ContextActionService:UnbindCoreAction("EscapeAvatarContextMenu")
    ContextActionService:UnbindCoreAction("SwitchPageAvatarContextMenu")

    ContextMenuUtil:EnablePlayerMovement()
    if connection then
        connection:disconnect()
    end

    local tween = TweenService:Create(instance, tweenInfo2, { Position = UDim2.new(0.5, 0, 1, instance.AbsoluteSize.Y) })
    tween:Play()
    tween.Completed:wait()

    instance.Visible = false
    SetSelectedPlayer(nil)
    bool4 = false
end
ContextMenuGui:SetCloseMenuFunc(CloseContextMenu)
local closeContextMenu = CloseContextMenu
contextMenuItems:SetCloseMenuFunc(closeContextMenu)

local function isPointInside(position, absolutePosition, vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return position.X >= absolutePosition.X
        and position.X <= vector2.X
        and position.Y >= absolutePosition.Y
        and position.Y <= vector2.Y
end

function PointInSwipeArea(position): boolean
    local absolutePosition = instance.AbsolutePosition

    local nameTag = instance.Content:FindFirstChild("NameTag")
    return (isPointInside(
        position,
        absolutePosition,
        Vector2.new(absolutePosition.x + instance.AbsoluteSize.x, nameTag.AbsolutePosition.y + nameTag.AbsoluteSize.y)
    ))
end

function LocalPlayerHasToolEquipped()
    if not LocalPlayer.Character then
        return false
    end
    for _, child in ipairs(LocalPlayer.Character:GetChildren()) do
        if child:IsA("BackpackItem") then
            return true
        end
    end

    return false
end

function shouldIgnoreLocalCharacter()
    if not LocalPlayer.Character then
        return
    end

    local head = LocalPlayer.Character:FindFirstChild("Head")
    if head and head:IsA("BasePart") then
        return head.LocalTransparencyModifier >= 0.95
    end
end

function clickedOnPoint(arg1)
    local currentCamera = workspace.CurrentCamera
    if not currentCamera or LocalPlayerHasToolEquipped() then
        return
    end

    local ray = currentCamera:ScreenPointToRay(arg1.X, arg1.Y)

    if var1 then
        raycastParams.FilterDescendantsInstances = shouldIgnoreLocalCharacter() and { LocalPlayer.Character } or {}
        local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 100, raycastParams)
        local var4 = if raycastResult then ContextMenuUtil:FindPlayerFromPart(raycastResult.Instance) else nil

        if var4 and (isStudio and var4 ~= LocalPlayer or var4 ~= LocalPlayer and var4.UserId > 0) then
            if bool4 then
                SetSelectedPlayer(var4)
                return
            end
            OpenContextMenu(var4, raycastResult.Position)
            return
        end
        if not var4 and bool4 then
            CloseContextMenu()
        end
    else
        local ray2 = Ray.new(ray.Origin, ray.Direction * 100)
        local var4, var5

        if shouldIgnoreLocalCharacter() then
            var4, var5 = workspace:FindPartOnRay(ray2, LocalPlayer.Character, false, true)
        else
            var4, var5 = workspace:FindPartOnRay(ray2, nil, false, true)
        end
        local var6 = ContextMenuUtil:FindPlayerFromPart(var4)

        if var6 and (isStudio and var6 ~= LocalPlayer or var6 ~= LocalPlayer and var6.UserId > 0) then
            if bool4 then
                SetSelectedPlayer(var6)
                return
            end
            OpenContextMenu(var6, var5)
            return
        end
        if not var6 and bool4 then
            CloseContextMenu()
        end
    end
end

function OnUserInput(arg1, input)
    if input.UserInputState == Enum.UserInputState.Begin and currentInput == nil then
        currentInput = input
        var3 = arg1
    elseif currentInput == input and input.UserInputState == Enum.UserInputState.Change then
        if (arg1 - var3).magnitude > 5 then
            currentInput = nil
            var3 = nil
        end
    elseif input.UserInputState == Enum.UserInputState.End and currentInput == input then
        currentInput = nil
        var3 = nil
        clickedOnPoint(arg1)
    end
end

function OnMouseMoved(arg1)
    if not bool4 and currentInput and (arg1 - var3).magnitude > 20 then
        currentInput = nil
        var3 = nil
    end
end

function trackTouchSwipeInput(input)
    if input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    if not currentInput2 and input.UserInputState == Enum.UserInputState.Begin then
        if PointInSwipeArea(input.Position) then
            currentInput2 = input
        end
    elseif currentInput2 == input and input.UserInputState == Enum.UserInputState.End then
        spawn(function()
            currentInput2 = nil
        end)
    end
end

local function functionProcessInput(input: InputObject, gameProcessedEvent: boolean)
    trackTouchSwipeInput(input)

    if gameProcessedEvent then
        if input == currentInput then
            currentInput = nil
        end

        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        OnUserInput(Vector2.new(input.Position.X, input.Position.Y), input)
    elseif input.UserInputType == Enum.UserInputType.MouseMovement then
        OnMouseMoved(Vector2.new(input.Position.X, input.Position.Y))
    end
end

UserInputService.InputBegan:Connect(functionProcessInput)
UserInputService.InputChanged:Connect(functionProcessInput)
UserInputService.InputEnded:Connect(functionProcessInput)

UserInputService.TouchSwipe:Connect(function(swipeDirection: Enum.SwipeDirection, _: number, gameProcessedEvent: boolean)
    if not gameProcessedEvent or not bool4 or not currentInput2 then
        return
    end

    local num1 = 0
    if swipeDirection == Enum.SwipeDirection.Left then
        num1 = 1
    elseif swipeDirection == Enum.SwipeDirection.Right then
        num1 = -1
    end

    if num1 ~= 0 then
        ContextMenuGui:OffsetPlayerEntry(num1)
        SetSelectedPlayer(ContextMenuGui:GetSelectedPlayer())
    end
end)

LocalPlayer.FriendStatusChanged:Connect(function(player: Player, friendStatus: Enum.FriendStatus)
    if player and player == var2 then
        local isPlayerBlockedByUserId = BlockingUtility:IsPlayerBlockedByUserId(player.UserId)
        contextMenuItems:UpdateFriendButton(friendStatus, isPlayerBlockedByUserId)
    end
end)

if FFlagEnableNewBackpack then
    Features.onVisibilityChanged(Features.FeatureName.Backpack, function(arg1)
        if arg1 and bool4 then
            CloseContextMenu()
        end
    end)
else
    BackpackScript.StateChanged.Event:Connect(function(arg1)
        if arg1 and bool4 then
            CloseContextMenu()
        end
    end)
end

EmotesMenuMaster.EmotesMenuToggled.Event:Connect(function(arg1)
    if arg1 and bool4 then
        CloseContextMenu()
    end
end)

function GetWorldPoint(arg1)
    if arg1.Character then
        local humanoidRootPart = arg1.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            return humanoidRootPart.Position
        end
    end
    if arg1 ~= LocalPlayer then
        return GetWorldPoint(LocalPlayer)
    end
    return Vector3.new(0, 0, 0)
end

StarterGui:RegisterGetCore("AvatarContextMenuTarget", function()
    return var2
end)

StarterGui:RegisterSetCore("AvatarContextMenuTarget", function(arg1)
    if typeof(arg1) ~= "Instance" or not arg1:IsA("Player") then
        if arg1 == nil then
            CloseContextMenu()
        else
            error("AvatarContextMenuTarget argument must be a Player or nil")
        end

        return
    end

    if arg1.Parent == nil then
        error("AvatarContextMenuTarget Player must be in the game")
        return
    end

    if bool4 or bool3 then
        SetSelectedPlayer(arg1, true)
        return
    end
    OpenContextMenu(arg1, GetWorldPoint(arg1))
end)

local function getClosestPlayer()
    if not LocalPlayer.Character then
        return
    end

    local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end
    local humanoidRootPartPosition = humanoidRootPart.Position

    local var4 = nil
    local huge = math.huge
    local position = nil
    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player == LocalPlayer or not player.Character then
            continue
        end

        local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart2 and (humanoidRootPart2.Position - humanoidRootPartPosition).magnitude < huge then
            huge = (humanoidRootPart2.Position - humanoidRootPartPosition).magnitude
            position = humanoidRootPart2.Position
            var4 = player
        end
    end

    return var4, position
end

ContextActionService:BindCoreAction("GamepadOpenAvatarContextMenu", function(_, userInputState, _) -- name: gamepadOpenMenu
    if not bool1 then
        return Enum.ContextActionResult.Pass
    end

    if GuiService.SelectedCoreObject or GuiService.SelectedObject then
        return Enum.ContextActionResult.Pass
    end

    if userInputState ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Sink
    end

    if bool4 then
        CloseContextMenu()
    else
        local var4, var5 = getClosestPlayer()
        if var4 then
            OpenContextMenu(var4, var5)
        end
    end

    return Enum.ContextActionResult.Sink
end, false, Enum.KeyCode.DPadUp)
