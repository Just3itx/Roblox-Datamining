-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualCursorModular = script:FindFirstAncestor("VirtualCursorModular")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local _MoveAssistController = require(VirtualCursorModular.Controllers.MoveAssistController)

local M = Enum.KeyCode.M

local cyan = Color3.fromRGB(0, 200, 255)
local darkGreen = Color3.fromRGB(40, 230, 100)
local white = Color3.fromRGB(255, 255, 255)
local cyan2 = Color3.fromRGB(0, 200, 255)
local darkGreen2 = Color3.fromRGB(40, 230, 100)
local flint = Color3.fromRGB(110, 110, 110)
local cgaBrown = Color3.fromRGB(120, 90, 0)
local newYeller = Color3.fromRGB(255, 220, 0)

local module = {}
module.__index = module

local function makeOutline(frameName: string, color3: Color3, parent)
    local frame = Instance.new("Frame")
    frame.Name = frameName
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Visible = false
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = color3
    uiStroke.Thickness = 2
    uiStroke.Parent = frame
    frame.Parent = parent
    return { rect = frame, stroke = uiStroke }
end

local function makeRay(frameName: string, color3: Color3, screenGui: ScreenGui): Frame -- Luacid: Inlined by compiler; 2 call sites recovered
    local frame = Instance.new("Frame")
    frame.Name = frameName

    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Size = UDim2.fromOffset(80, 2)
    frame.BackgroundColor3 = color3
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = screenGui
    return frame
end

local function makeCandidateVisual(_container)
    local outline = makeOutline("CandidateRect", flint, _container)

    local aimDot = Instance.new("Frame")
    aimDot.Name = "AimDot"
    aimDot.AnchorPoint = Vector2.new(0.5, 0.5)
    aimDot.Size = UDim2.fromOffset(8, 8)
    aimDot.BorderSizePixel = 0
    aimDot.Visible = false
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = aimDot
    aimDot.Parent = _container

    return {
        rect = outline.rect,
        stroke = outline.stroke,
        aimDot = aimDot
    }
end

function module.new()
    local moveAssistDebug = Instance.new("ScreenGui")
    moveAssistDebug.Name = "MoveAssistDebug"
    moveAssistDebug.IgnoreGuiInset = true
    moveAssistDebug.DisplayOrder = 100000
    moveAssistDebug.ResetOnSpawn = false
    moveAssistDebug.Enabled = false

    local rect = makeOutline("AssistRadius", cyan, moveAssistDebug).rect
    rect.AnchorPoint = Vector2.new(0.5, 0.5)
    rect.Visible = true
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = rect

    local frame = makeRay("InputRay", white, moveAssistDebug)
    local frame2 = makeRay("FinalRay", cyan2, moveAssistDebug)

    local statsPanel = Instance.new("TextLabel")
    statsPanel.Name = "StatsPanel"
    statsPanel.Position = UDim2.fromOffset(12, 12)
    statsPanel.Size = UDim2.fromOffset(260, 228)
    statsPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    statsPanel.BackgroundTransparency = 0.4
    statsPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statsPanel.TextXAlignment = Enum.TextXAlignment.Left
    statsPanel.TextYAlignment = Enum.TextYAlignment.Top
    statsPanel.Font = Enum.Font.Code
    statsPanel.TextSize = 14
    statsPanel.Text = ""
    statsPanel.Parent = moveAssistDebug

    moveAssistDebug.Parent = CoreGui

    local self = setmetatable({
        _container = moveAssistDebug,
        _radius = rect,
        _inputRay = frame,
        _finalRay = frame2,
        _label = statsPanel,
        _candidateVisuals = {},
        _mode = 0,
        _toggleConnection = nil
    }, module)

    self._toggleConnection = UserInputService.InputBegan:Connect(function(input: InputObject)
        if input.KeyCode == M then
            self:cycleMode()
        end
    end)

    return self
end

function module:cycleMode()
    self._mode = (self._mode + 1) % 3
end

function module:_getCandidateVisual(num1: number)
    local _candidateVisual = self._candidateVisuals[num1]
    if _candidateVisual then
        return _candidateVisual
    end
    local candidateVisual = makeCandidateVisual(self._container)
    self._candidateVisuals[num1] = candidateVisual
    return candidateVisual
end

local function positionRay(arg1, vector2: Vector2, vector2_2: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if vector2_2.Magnitude < 0.001 then
        arg1.Visible = false
        return
    end
    local unit = vector2_2.Unit

    local var1 = vector2 + unit * 40
    arg1.Position = UDim2.fromOffset(var1.X, var1.Y)
    arg1.Rotation = math.deg(math.atan2(unit.Y, unit.X))
    arg1.Visible = true
end

local function candidateColor(arg1, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.state == "committed" then
        return darkGreen
    end

    if arg1.state ~= "scored" then
        return flint
    end

    local alpha = if num1 > 0 then math.clamp(arg1.influence / num1, 0, 1) else 0
    return cgaBrown:Lerp(newYeller, alpha)
end

local function fmt(num1: number): string -- Luacid: Inlined by compiler; 14 call sites recovered
    return string.format("%.2f", num1)
end

function module:update(arg1, vector2: Vector2)
    if self._mode == 0 or not arg1 then
        self._container.Enabled = false
        return
    end
    self._container.Enabled = true
    self._label.Visible = self._mode == 1

    local var1 = arg1.cursorPosition - vector2

    local var2 = arg1.radius * 2
    self._radius.Size = UDim2.fromOffset(var2, var2)
    self._radius.Position = UDim2.fromOffset(var1.X, var1.Y)

    local num1 = 0
    for _, value in arg1.candidates do
        if num1 < value.influence then
            num1 = value.influence
        end
    end

    local num2 = 0
    for _, value in arg1.candidates do
        num2 += 1
        local var3 = self:_getCandidateVisual(num2)
        local color3 = candidateColor(value, num1)
        local var4 = value.position - vector2
        var3.rect.Position = UDim2.fromOffset(var4.X, var4.Y)
        var3.rect.Size = UDim2.fromOffset(value.size.X, value.size.Y)
        var3.rect.Visible = true
        var3.stroke.Color = color3

        local aimPoint = value.aimPoint
        if aimPoint and value.state ~= "skipped" then
            local var5 = aimPoint - vector2
            var3.aimDot.Position = UDim2.fromOffset(var5.X, var5.Y)
            var3.aimDot.BackgroundColor3 = color3
            var3.aimDot.Visible = true
        else
            var3.aimDot.Visible = false
        end
    end
    for i = num2 + 1, #self._candidateVisuals do
        self._candidateVisuals[i].rect.Visible = false
        self._candidateVisuals[i].aimDot.Visible = false
    end

    positionRay(self._inputRay, var1, arg1.inputDir)
    positionRay(self._finalRay, var1, arg1.finalDir)

    local _finalRay = self._finalRay
    _finalRay.BackgroundColor3 = if arg1.active then darkGreen2 else cyan2

    local committed = arg1.committed

    local var3 = (arg1.finalDir - arg1.inputDir) * arg1.inputMagnitude
    local num3 = math.deg(math.acos(math.clamp(arg1.inputDir:Dot(arg1.finalDir), -1, 1)))
    self._label.Text = string.format(
        "MoveAssist: %s\nmoveDir: (%s, %s)  mag %s\nbend: (%s, %s)  %s deg\ncommitted: %s\ninfluence: %s\nconfidence: %s (str %s)\ninputFollow: %s\narrival: %s\nintent: %s\nmasterGain: %s\nassistStrength: %s\ncandidates: %d",
        if arg1.active then "ACTIVE" else "idle",
        fmt(arg1.finalDir.X),
        fmt(arg1.finalDir.Y),
        fmt(arg1.inputMagnitude),
        fmt(var3.X),
        fmt(var3.Y),
        fmt(num3),
        if committed then committed.Name else "-",
        fmt(arg1.bestInfluence),
        fmt(arg1.confidence),
        fmt(arg1.confidenceStrength),
        fmt(arg1.inputFollowStrength),
        fmt(arg1.arrivalFactor),
        fmt(arg1.intentFactor),
        fmt(arg1.masterGain),
        fmt(arg1.assistStrength),
        num2
    )
end

function module:Destroy()
    local _toggleConnection = self._toggleConnection
    if _toggleConnection then
        _toggleConnection:Disconnect()
        self._toggleConnection = nil
    end
    self._container:Destroy()
end

return module
