-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local RobloxGui = CoreGui.RobloxGui
local CaptureMaster = require(RobloxGui.Modules.CaptureMaster)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local PermissionsProtocol = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol
local Promise = require(CorePackages.Packages.Promise)

local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
if not require(RobloxGui.Modules.Flags.GetFFlagScreenshotHudApi)() then
    return
end

local ScreenshotHud = GuiService:WaitForChild("ScreenshotHud")

local tbl1 = {
    Default = {
        BackgroundColor3 = Color3.fromRGB(0, 180, 109),
        BackgroundTransparency = 0
    },
    Hovered = {
        BackgroundColor3 = Color3.fromRGB(0, 232, 126),
        BackgroundTransparency = 0
    },
    Pressed = {
        BackgroundColor3 = Color3.fromRGB(0, 232, 126),
        BackgroundTransparency = 0.5
    }
}

local var1 = nil
local var2 = nil

local tbl2 = {}
local tbl3 = {}
local var3 = nil
local bool1 = false

local function createFrame(arg1, parent): Frame
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.new(1, 1, 1)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.Size = UDim2.new(1, 0, 1, 0)

    for k, value in pairs(arg1) do
        frame[k] = value
    end

    frame.Parent = parent

    return frame
end

local function createImageLabel(image: string, arg1, parent): ImageLabel
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Image = image

    imageLabel.BackgroundTransparency = 1
    imageLabel.BorderSizePixel = 0
    imageLabel.Position = UDim2.new(0, 0, 0, 0)
    imageLabel.Size = UDim2.new(1, 0, 1, 0)

    for k, value in pairs(arg1) do
        imageLabel[k] = value
    end

    imageLabel.Parent = parent

    return imageLabel
end

local function createImageButton(image: string, arg1, parent): ImageButton
    local imageButton = Instance.new("ImageButton")
    imageButton.Image = image

    imageButton.BackgroundTransparency = 1
    imageButton.BorderSizePixel = 0
    imageButton.Position = UDim2.new(0, 0, 0, 0)
    imageButton.Size = UDim2.new(1, 0, 1, 0)

    for k, value in pairs(arg1) do
        imageButton[k] = value
    end

    imageButton.Parent = parent

    return imageButton
end

local function createTextLabel(textLabelText, tbl4: {AnchorPoint: Vector2, Position: UDim2, Size: UDim2, TextScaled: boolean, TextWrapped: boolean}, imageButton: ImageButton): TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = textLabelText

    textLabel.BackgroundTransparency = 1
    textLabel.BorderSizePixel = 0
    textLabel.Font = AppFonts.default:getMedium()
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextSize = 20

    for k, value in pairs(tbl4) do
        textLabel[k] = value
    end

    textLabel.Parent = imageButton

    return textLabel
end

local vector2, vector2_2 = GuiService:GetGuiInset()
local frame = createFrame({
    Name = "ScreenshotHudFrame",
    Position = UDim2.new(0, -vector2.X, 0, -vector2.Y),
    Size = UDim2.new(1, vector2.X + vector2_2.X, 1, vector2.Y + vector2_2.Y),
    Visible = false
}, RobloxGui)

local frame2 = createFrame({
    Name = "ScreenshotHudContent",
    Position = UDim2.new(0, vector2.X, 0, vector2.Y),
    Size = UDim2.new(1, -vector2.X - vector2_2.X, 1, -vector2.Y - vector2_2.Y),
    Visible = false
}, frame)

local imageButton = createImageButton("", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    AutoButtonColor = false,
    BackgroundColor3 = Color3.fromRGB(0, 180, 109),
    BackgroundTransparency = 0.5,
    Name = "CameraButton",
    Position = UDim2.new(0.5, 0, 1, -50),
    Size = UDim2.fromOffset(64, 64)
}, nil)

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 32)
uiCorner.Parent = imageButton

local imageLabel = createImageLabel("", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = tbl1.Default.BackgroundColor3,
    BackgroundTransparency = tbl1.Default.BackgroundTransparency,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(52, 52)
}, imageButton)

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 26)
uiCorner2.Parent = imageLabel

local imageLabel2 = createImageLabel(
    "rbxasset://textures/ui/ScreenshotHud/Camera.png",
    {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(32, 32)
    },
    imageLabel
)

local imageButton2 = createImageButton("", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(7, 7, 8),
    BackgroundTransparency = 0,
    Name = "CloseButton",
    Position = UDim2.new(0.5, -66, 1, -50),
    Size = UDim2.fromOffset(48, 48)
}, nil)

local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(0, 24)
uiCorner3.Parent = imageButton2

local _imageLabel = createImageLabel(
    "rbxasset://textures/ui/ScreenshotHud/Close.png",
    {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(32, 32)
    },
    imageButton2
)

local imageButton3 = createImageButton("", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(0, 180, 109),
    BackgroundTransparency = 0,
    Name = "CameraButton",
    Position = UDim2.new(1, -94, 1, -78),
    Size = UDim2.fromOffset(140, 36)
}, nil)

local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 18)
uiCorner4.Parent = imageButton3

local _imageLabel2 = createImageLabel(
    "rbxasset://textures/ui/Controls/xboxY.png",
    {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 6, 0.5, 0),
        Size = UDim2.fromOffset(24, 24)
    },
    imageButton3
)

local _textLabel = createTextLabel(
    RobloxTranslator:FormatByKey("CoreScripts.ScreenshotHud.Action.TakePhoto"),
    {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 30, 0.5, 0),
        Size = UDim2.new(1, -36, 0, 20),
        TextScaled = true,
        TextWrapped = true
    },
    imageButton3
)

local imageButton4 = createImageButton("", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(7, 7, 8),
    BackgroundTransparency = 0,
    Name = "CloseButton",
    Position = UDim2.new(1, -228, 1, -78),
    Size = UDim2.fromOffset(104, 36)
}, nil)

local uiCorner5 = Instance.new("UICorner")
uiCorner5.CornerRadius = UDim.new(0, 18)
uiCorner5.Parent = imageButton4

local _imageLabel3 = createImageLabel(
    "rbxasset://textures/ui/Controls/xboxB.png",
    {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 6, 0.5, 0),
        Size = UDim2.fromOffset(24, 24)
    },
    imageButton4
)

local _textLabel2 = createTextLabel(
    RobloxTranslator:FormatByKey("CoreScripts.ScreenshotHud.Action.Cancel"),
    {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 30, 0.5, 0),
        Size = UDim2.new(1, -36, 0, 20),
        TextScaled = true,
        TextWrapped = true
    },
    imageButton4
)

local frame3 = createFrame({ Active = true, BackgroundTransparency = 0.5, Name = "FlashOverlay", Visible = false, ZIndex = 3 }, frame)

local function checkOrRequestExternalStoragePermissions()
    return PermissionsProtocol.default:checkOrRequestPermissions({ PermissionsProtocol.Permissions.WRITE_MEDIA_STORAGE }):andThen(
        function(authorized)
            return authorized == PermissionsProtocol.Status.AUTHORIZED and Promise.resolve() or Promise.reject()
        end
    )
end

local function getEnabledPlayerScreenGuis()
    local descendants = Players.LocalPlayer.PlayerGui:GetDescendants()
    local enabledPlayerScreenGuis = {}
    for _, descendant in ipairs(descendants) do
        if descendant:IsA("ScreenGui") and descendant.Enabled then
            table.insert(enabledPlayerScreenGuis, descendant)
        end
    end
    return enabledPlayerScreenGuis
end

local function getEnabledCoreGuiTypes()
    local enabledCoreGuiTypes = {}
    for _, enumItem in ipairs(Enum.CoreGuiType:GetEnumItems()) do
        if StarterGui:GetCoreGuiEnabled(enumItem) then
            table.insert(enabledCoreGuiTypes, enumItem)
        end
    end
    return enabledCoreGuiTypes
end

local function func1() end

local function onCameraButtonActivated()
    if UserInputService:GetPlatform() == Enum.Platform.Android then
        checkOrRequestExternalStoragePermissions():andThen(func1, function()
            CaptureMaster:ShowPermissionToast()
        end)

        return
    end

    func1()
end

func1 = function()
    CaptureMaster:DismissNotification()

    if var3 then
        var3:Disconnect()
        var3 = nil
    end

    local bool2 = false
    local enabledPlayerScreenGuis, bool3

    if ScreenshotHud.HidePlayerGuiForCaptures then
        enabledPlayerScreenGuis = getEnabledPlayerScreenGuis()
        for _, value in ipairs(enabledPlayerScreenGuis) do
            value.Enabled = false
        end

        bool3 = true
    else
        bool3 = false
        enabledPlayerScreenGuis = nil
    end

    local enabledCoreGuiTypes

    if ScreenshotHud.HideCoreGuiForCaptures then
        enabledCoreGuiTypes = getEnabledCoreGuiTypes()
        for _, value in ipairs(enabledCoreGuiTypes) do
            StarterGui:SetCoreGuiEnabled(value, false)
        end

        bool2 = true
    else
        enabledCoreGuiTypes = nil
    end

    local proximityPromptServiceEnabled = ProximityPromptService.Enabled
    ProximityPromptService.Enabled = false

    frame2.Visible = false

    wait(0.2)

    local tbl4 = ({})
    for _, player in pairs(Players:GetPlayers()) do
        local humanoid = player.Character and player.Character:WaitForChild("Humanoid")
        if humanoid then
            tbl4[humanoid] = humanoid.DisplayDistanceType
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end
    end

    CoreGui:TakeScreenshot()
    wait(0.2)

    frame2.Visible = true

    frame3.Visible = true

    wait(0.2)
    frame3.Visible = false

    var3 = var3 or imageButton.Activated:connect(onCameraButtonActivated)

    ProximityPromptService.Enabled = proximityPromptServiceEnabled

    for _, player in pairs(Players:GetPlayers()) do
        local humanoid = player.Character and player.Character:WaitForChild("Humanoid")
        if humanoid and tbl4[humanoid] then
            humanoid.DisplayDistanceType = tbl4[humanoid]
        end
    end

    if bool3 then
        for _, value in ipairs(enabledPlayerScreenGuis) do
            value.Enabled = true
        end
    end

    if bool2 then
        for _, value in ipairs(enabledCoreGuiTypes) do
            StarterGui:SetCoreGuiEnabled(value, true)
        end
    end

    if ScreenshotHud.CloseWhenScreenshotTaken then
        ScreenshotHud.Visible = false
    end

    RbxAnalyticsService:SendEventDeferred("client", "screenshotHud", "TakeScreenshot", { pid = tostring(game.PlaceId) })
end

local function isGamepad(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1.Name:match("^Gamepad*") ~= nil
end

local function updateGamepadButtons()
    if var1 then
        var1.Parent = nil
    end
    if var2 then
        var2.Parent = nil
    end

    var1 = if bool1 then imageButton3 else imageButton
    var2 = if bool1 then imageButton4 else imageButton2

    var1.Parent = frame2
    var2.Parent = frame2

    if ScreenshotHud.CameraButtonPosition ~= UDim2.fromOffset(0, 0) then
        var1.Position = ScreenshotHud.CameraButtonPosition
    end

    if ScreenshotHud.CloseButtonPosition ~= UDim2.fromOffset(0, 0) then
        var2.Position = ScreenshotHud.CloseButtonPosition
    end
end

local function onLastInputTypeChanged(lastInputType: Enum.UserInputType)
    local bool2 = not not isGamepad(lastInputType or UserInputService:GetLastInputType())

    if bool1 ~= bool2 then
        bool1 = bool2
        updateGamepadButtons()
    end
end

local function setupConnections()
    table.insert(tbl2, (imageButton.InputBegan:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            imageLabel.BackgroundColor3 = tbl1.Hovered.BackgroundColor3
            imageLabel.BackgroundTransparency = tbl1.Hovered.BackgroundTransparency
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            imageLabel.BackgroundColor3 = tbl1.Pressed.BackgroundColor3
            imageLabel.BackgroundTransparency = tbl1.Pressed.BackgroundTransparency
        end
    end)))

    table.insert(tbl2, (imageButton.InputEnded:Connect(function()
        imageLabel.BackgroundColor3 = tbl1.Default.BackgroundColor3
        imageLabel.BackgroundTransparency = tbl1.Default.BackgroundTransparency
    end)))
    if var3 then
        var3:Disconnect()
        var3 = nil
    end
    var3 = imageButton.Activated:connect(onCameraButtonActivated)
    table.insert(tbl2, var3)

    table.insert(tbl2, (imageButton2.Activated:connect(function()
        ScreenshotHud.Visible = false
    end)))

    ContextActionService:BindAction("ScreenshotHudGamepadClose", function(_: string, userInputState: Enum.UserInputState, inputObject: InputObject) -- name: gamepadHandleClose
        if userInputState == Enum.UserInputState.End and isGamepad(inputObject.UserInputType) then
            ScreenshotHud.Visible = false
        end
    end, false, Enum.KeyCode.ButtonB)
    table.insert(tbl3, "ScreenshotHudGamepadClose")

    ContextActionService:BindAction("ScreenshotHudGamepadCamera", function(_: string, userInputState: Enum.UserInputState, inputObject: InputObject) -- name: gamepadHandleCamera
        if userInputState == Enum.UserInputState.End and isGamepad(inputObject.UserInputType) then
            onCameraButtonActivated()
        end
    end, false, Enum.KeyCode.ButtonY)
    table.insert(tbl3, "ScreenshotHudGamepadCamera")
    local bool2 = not not isGamepad((UserInputService:GetLastInputType()))

    if bool1 ~= bool2 then
        bool1 = bool2
        updateGamepadButtons()
    end

    table.insert(tbl2, (UserInputService.LastInputTypeChanged:Connect(onLastInputTypeChanged)))
end

local function disconnectAll()
    for _, value in ipairs(tbl2) do
        value:Disconnect()
    end

    tbl2 = {}

    for _, value in ipairs(tbl3) do
        ContextActionService:UnbindAction(value)
    end
    tbl3 = {}
end

local function screenshotHudEnabled(enabled: boolean)
    frame.Visible = ScreenshotHud.Visible
    disconnectAll()

    if ScreenshotHud.Visible then
        frame2.Visible = true
        frame3.Visible = false
        setupConnections()
        CaptureMaster:Start()
    end

    RbxAnalyticsService:SendEventDeferred(
        "client",
        "screenshotHud",
        "ScreenshotHudEnabled",
        {
            pid = tostring(game.PlaceId),
            enabled = enabled
        }
    )
end
ScreenshotHud:GetPropertyChangedSignal("Visible"):Connect(function()
    screenshotHudEnabled(ScreenshotHud.Visible)
end)

ScreenshotHud:GetPropertyChangedSignal("CameraButtonIcon"):Connect(function()
    imageLabel2.Image = ScreenshotHud.CameraButtonIcon or "rbxasset://textures/ui/ScreenshotHud/Camera.png"

    RbxAnalyticsService:SendEventDeferred(
        "client",
        "screenshotHud",
        "CameraButtonIcon",
        {
            pid = tostring(game.PlaceId),
            icon = ScreenshotHud.CameraButtonIcon
        }
    )
end)
ScreenshotHud:GetPropertyChangedSignal("CameraButtonPosition"):Connect(function()
    var1.Position = ScreenshotHud.CameraButtonPosition

    RbxAnalyticsService:SendEventDeferred(
        "client",
        "screenshotHud",
        "CameraButtonPosition",
        {
            pid = tostring(game.PlaceId),
            position = tostring(ScreenshotHud.CameraButtonPosition)
        }
    )
end)

ScreenshotHud:GetPropertyChangedSignal("CloseButtonPosition"):Connect(function()
    var2.Position = ScreenshotHud.CloseButtonPosition

    RbxAnalyticsService:SendEventDeferred(
        "client",
        "screenshotHud",
        "CloseButtonPosition",
        {
            pid = tostring(game.PlaceId),
            position = tostring(ScreenshotHud.CloseButtonPosition)
        }
    )
end)
updateGamepadButtons()
screenshotHudEnabled(ScreenshotHud.Visible)
