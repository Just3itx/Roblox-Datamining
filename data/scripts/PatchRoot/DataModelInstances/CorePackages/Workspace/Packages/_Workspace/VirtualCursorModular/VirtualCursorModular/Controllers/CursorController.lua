-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualCursorModular = script:FindFirstAncestor("VirtualCursorModular")
local _VirtualCursorModularParent = VirtualCursorModular.Parent

local TweenService = game:GetService("TweenService")

local VRService = game:GetService("VRService")
local CoreGui = game:GetService("CoreGui")
local Properties = require(VirtualCursorModular.Properties)

local module = {}
module.__index = module

local tbl1 = { Default = 2, Hover = 2, Pressed = 1.7, Arrow = 2 }

function module.new()
    local cursorContainer = Instance.new("ScreenGui")
    cursorContainer.Enabled = false
    cursorContainer.IgnoreGuiInset = true
    cursorContainer.DisplayOrder = math.huge
    cursorContainer.OnTopOfCoreBlur = true
    cursorContainer.Name = "CursorContainer"

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Active = false
    imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    imageLabel.Size = UDim2.fromOffset(2 * Properties.CursorRadius, 2 * Properties.CursorRadius)

    imageLabel.Image = "rbxasset://textures/ui/VirtualCursor/cursorDefault.png"
    imageLabel.Visible = false
    imageLabel.BackgroundTransparency = 1

    imageLabel.Parent = cursorContainer
    cursorContainer.Parent = CoreGui

    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
    return (setmetatable({
        _cursor = imageLabel,
        _cursorContainer = cursorContainer,
        _activeSelectionTweenIn = TweenService:Create(
            imageLabel,
            tweenInfo,
            {
                Size = UDim2.fromOffset(1.7 * Properties.CursorRadius, 1.7 * Properties.CursorRadius)
            }
        ),
        _activeSelectionTweenOut = TweenService:Create(
            imageLabel,
            tweenInfo,
            {
                Size = UDim2.fromOffset(2 * Properties.CursorRadius, 2 * Properties.CursorRadius)
            }
        ),
        _activePreviewPositionTween = nil,
        _activeOpacityTweenCompletedConnection = nil,
        _enabled = false
    }, module))
end

function module:Destroy()
    self._cursorContainer:Destroy()

    self._activeSelectionTweenIn:Destroy()
    self._activeSelectionTweenOut:Destroy()

    if self._activePreviewPositionTween then
        self._activePreviewPositionTween:Destroy()
    end

    local _activeOpacityTweenCompletedConnection = self._activeOpacityTweenCompletedConnection
    if _activeOpacityTweenCompletedConnection then
        _activeOpacityTweenCompletedConnection:Disconnect()
        self._activeOpacityTweenCompletedConnection = nil
    end
end

function module:SetCursorSize(str1: string)
    local var1 = tbl1[str1] * Properties.CursorRadius
    self._cursor.Size = UDim2.fromOffset(var1, var1)
end

function module:PlayTweenActivate()
    self._activeSelectionTweenIn:Play()
end

function module:PlayTweenDefault()
    self._activeSelectionTweenOut:Play()
end

function module:SetHighlight(bool1: boolean)
    if bool1 then
        self._cursor.Image = "rbxasset://textures/ui/VirtualCursor/cursorHover.png"
        return
    end
    self._cursor.Image = "rbxasset://textures/ui/VirtualCursor/cursorDefault.png"
end

function module:SetPosition(vector2: Vector2)
    self._cursor.Position = UDim2.fromOffset(vector2.X, vector2.Y)
end

function module:GetCursorScreenGuiOffset()
    return self._cursorContainer.AbsolutePosition
end

function module:TweenPosition(vector2: Vector2)
    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
    self._activePreviewPositionTween = TweenService:Create(self._cursor, tweenInfo, { Position = UDim2.fromOffset(vector2.X, vector2.Y) })
    self._activePreviewPositionTween:Play()
end

function module:TweenOpacity(bool1: boolean)
    local _activeOpacityTweenCompletedConnection = self._activeOpacityTweenCompletedConnection
    if _activeOpacityTweenCompletedConnection then
        _activeOpacityTweenCompletedConnection:Disconnect()
        self._activeOpacityTweenCompletedConnection = nil
    end

    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
    local tween = TweenService:Create(self._cursor, tweenInfo, { ImageTransparency = if bool1 then 0 else 1 })

    self._activeOpacityTweenCompletedConnection = tween.Completed:Connect(function()
        self._cursor.Visible = bool1
        self._cursorContainer.Enabled = bool1
    end)

    tween:Play()
end

function module:SetArrow(num1: number, num2: number)
    if num1 == -1 and num2 == 0 then
        self._cursor.Rotation = 90
    elseif num2 == 0 then
        self._cursor.Rotation = 270
    end

    if num1 == 0 and num2 == 1 then
        self._cursor.Rotation = 0
    elseif num1 == 0 then
        self._cursor.Rotation = 180
    end

    self._cursor.Image = "rbxasset://textures/ui/VirtualCursor/cursorArrow.png"
end

function module:GetEnabled()
    return self._enabled
end

function module:Enable(vector2: Vector2)
    if VRService.VREnabled then
        return
    end

    local bool1 = not VRService.VREnabled
    self._cursorContainer.Enabled = bool1
    self:SetCursorSize("Default")
    self:SetPosition(vector2)
    self._cursor.Visible = bool1

    self:TweenOpacity(true)

    self._enabled = true
end

function module:Disable()
    self:SetHighlight(false)

    self:TweenOpacity(false)

    self._enabled = false
end

return module
