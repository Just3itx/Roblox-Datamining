-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local GamepadService = game:GetService("GamepadService")
local CoreGui = game:GetService("CoreGui")

local var1 = nil

local Input = require(scriptParent.Input)
local Interface = require(scriptParent.Interface)
local Properties = require(scriptParent.Properties)
local isCircleContainedInGuiObject = require(scriptParent.isCircleContainedInGuiObject)
local isSelectableGuiObject = require(scriptParent.isSelectableGuiObject)
local RotatePointAroundObject = require(scriptParent.RotatePointAroundObject)

local num1 = 1

local bool1 = false

local sin = math.sin
local cos = math.cos
local _abs = math.abs
local max = math.max
local min = math.min
local sign = math.sign
local abs = math.abs

local tbl1 = ({})

local var2 = nil
local var3 = nil
local huge = math.huge

local function contains(arg1, arg2, arg3): boolean -- Luacid: unused: defined but never referenced
    return arg1.x >= arg2.x and arg1.y >= arg2.y and arg1.x <= arg3.x and arg1.y <= arg3.y
end

local function handleScrollingFrame(arg1, arg2, arg3)
    if not arg1:IsA("ScrollingFrame") then
        return false
    end
    if not arg1.ScrollingEnabled then
        return false
    end

    if tbl1[arg1] then
        return false
    end
    tbl1[arg1] = true

    local thumbstick2Vector = Input:GetThumbstick2Vector()
    local var4 = Properties.ScrollingSpeed * arg3
    local scrollingRadius = Properties.ScrollingRadius
    local absoluteCanvasSize = arg1.AbsoluteCanvasSize
    local absoluteSize = arg1.AbsoluteSize
    local scrollingDirection = arg1.ScrollingDirection
    local bool2 = absoluteCanvasSize.X > absoluteSize.X
        and (scrollingDirection == Enum.ScrollingDirection.XY or scrollingDirection == Enum.ScrollingDirection.X)
    local bool3 = absoluteCanvasSize.Y > absoluteSize.Y
        and (scrollingDirection == Enum.ScrollingDirection.XY or scrollingDirection == Enum.ScrollingDirection.Y)
    local absoluteSize2 = arg1.AbsoluteSize
    local absolutePosition = arg1.AbsolutePosition
    local num2 = arg1.Rotation / 180 * math.pi

    if abs(thumbstick2Vector.x) > Properties.ThumbstickDeadzone and bool2 then
        arg1.CanvasPosition += Vector2.new(thumbstick2Vector.x * var4, 0)
    end

    if abs(thumbstick2Vector.y) > Properties.ThumbstickDeadzone and bool3 then
        arg1.CanvasPosition += Vector2.new(0, thumbstick2Vector.y * var4)
    end

    local vector2 = Vector2.new(cos(num2), (sin(num2)))

    local vector2_2 = Vector2.new(-sin(num2), (cos(num2)))
    local var5 = Vector2.new(arg2.X, arg2.Y) - absolutePosition

    local var6 = var5:Dot(vector2) - absoluteSize2.X / 2
    local var7 = var5:Dot(vector2_2) - absoluteSize2.Y / 2
    local var8 = Vector2.new(abs(var6), (abs(var7))) - absoluteSize2 / 2
    local magnitude = Vector2.new(max(var8.x, 0), (max(var8.y, 0))).Magnitude
    if abs(min(max(var8.x, var8.y), 0) + magnitude) < scrollingRadius then
        local var9 = abs(var8.x)

        if var9 < abs(var8.y) and bool2 then
            arg1.CanvasPosition += Vector2.new(sign(var6) * var4, 0)
            Interface:SetArrow(sign(var6), 0)
            return true
        end

        local var10 = abs(var8.x)

        if abs(var8.y) <= var10 and bool3 then
            arg1.CanvasPosition += Vector2.new(0, sign(var7) * var4)
            Interface:SetArrow(0, (sign(var7)))
            return true
        end
    end

    return false
end

local function findClosestOrOccludingGuiObject(_, tbl2, arg1, arg2)
    for _, value in ipairs(tbl2) do
        if handleScrollingFrame(value, arg1, arg2) then
            bool1 = true
            return
        end

        local var4 = isSelectableGuiObject(value)

        if var4 and not var2 then
            var2 = value
        end

        if var4 then
            local absolutePosition = value.AbsolutePosition
            local var5 = value.AbsolutePosition + value.AbsoluteSize

            local num2 = 0
            local var6 = if value.AbsoluteRotation == 0 then arg1 else RotatePointAroundObject(arg1, value)

            if var6.x < absolutePosition.x or var6.y < absolutePosition.y or var6.x > var5.x or var6.y > var5.y then
                local var7 = if var6.x < absolutePosition.x then absolutePosition.x - var6.x elseif var6.x > var5.x then var6.x - var5.x else 0
                local var8 = if var6.y < absolutePosition.y then absolutePosition.y - var6.y elseif var6.y > var5.y then var6.y - var5.y else 0
                num2 = math.sqrt(math.pow(var7, 2) + math.pow(var8, 2))
            end

            if num2 < huge then
                var2 = value
                huge = num2
            end
        end

        if value.Visible
            and value.Active
            and value.Interactable
            and isCircleContainedInGuiObject(arg1, Properties.CursorRadius * Properties.OcclusionRadiusScale, value)
        then
            var3 = value
            return
        end
    end
end

local function handleScrollingInAncestors(arg1, arg2, arg3, arg4)
    local parent = arg1.Parent
    while parent and parent ~= arg2 do
        if handleScrollingFrame(parent, arg3, arg4) then
            bool1 = true
            return
        end
        parent = parent.Parent
    end
end

local function processCursorPosition(position: Vector2, radius: number, arg1)
    table.clear(tbl1)
    var2 = nil
    var3 = nil
    huge = math.huge

    position -= GuiService:GetGuiInset()

    if var1 == nil then
        var1 = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end

    local var4 = not var1 and {} or var1:GetGuiObjectsInCircle(position, radius)
    local guiObjectsInCircle = CoreGui:GetGuiObjectsInCircle(position, radius)

    bool1 = false

    for _, value in ipairs({ { CoreGui, guiObjectsInCircle }, { var1, var4 } }) do
        local var5 = value[1]
        local var6 = value[2]

        findClosestOrOccludingGuiObject(var5, var6, position, arg1)

        if bool1 then
            return nil
        end

        if var2 then
            handleScrollingInAncestors(var2, var5, position, arg1)
        end

        if bool1 then
            return nil
        end
        if var3 and var3 ~= var2 then
            handleScrollingInAncestors(var3, var5, position, arg1)
        end

        if bool1 then
            return nil
        end

        if var3 then
            return var2
        end
    end

    return var2
end

local function getMaxSpeed() -- Luacid: Inlined by compiler; 1 call site recovered
    return GuiService:GetScreenResolution().Magnitude * Properties.MaxSpeedRelative
end

return function(arg1, arg2)
    local var4 = GuiService:GetScreenResolution() + GuiService:GetGuiInset()

    local thumbstickVector = Input:GetThumbstickVector()
    local vector2 = GamepadService:GetGamepadCursorPosition()

    local _vector2 = Vector2.new()

    if arg1.SelectedObject == nil then
        num1 = 1
        Interface:SetCursorHighlight(false)
    end

    if bool1 then
        num1 = Properties.ScrollingSlowDown
    end

    local var5 = thumbstickVector * getMaxSpeed() * num1

    if var5.Magnitude > 0 then
        local var6 = vector2 + var5 * arg2
        local x = math.clamp(var6.x, 0, var4.x)
        local y = math.clamp(var6.y, 0, var4.y)
        vector2 = Vector2.new(x, y)
    end

    Interface:SetCursorPosition(vector2)
    GamepadService:SetGamepadCursorPosition(vector2)
    arg1.CursorPosition = vector2

    local var6 = processCursorPosition(vector2, Properties.SelectionRadius, arg2)

    if var6 == arg1.PreviouslySelectedObject then
        return
    end

    arg1.PreviouslySelectedObject = var6

    Interface:SetCursorHighlight(var6 ~= nil)
    if var6 then
        if var6 ~= arg1.SelectedObject then
            arg1.SelectedObject = var6
            num1 = Properties.SpeedAdjustmentTarget
        end
    else
        arg1.SelectedObject = nil
        num1 = 1
    end

    if arg1.SelectedObject == nil then
        GuiService.SelectedObject = nil
        GuiService.SelectedCoreObject = nil
    elseif arg1.SelectedObject:IsDescendantOf(CoreGui) then
        GuiService.SelectedCoreObject = arg1.SelectedObject
        GuiService.SelectedObject = nil
    elseif arg1.SelectedObject:IsDescendantOf(var1) then
        GuiService.SelectedObject = arg1.SelectedObject
        GuiService.SelectedCoreObject = nil
    end
end
