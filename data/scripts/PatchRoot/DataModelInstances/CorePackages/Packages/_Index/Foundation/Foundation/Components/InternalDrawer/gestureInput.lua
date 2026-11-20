-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local Connection = require(Foundation.Utility.Wrappers.Connection)
local DragIntent = require(Foundation.Enums.DragIntent)
local Services = require(Foundation.Utility.Wrappers.Services)
local Signal = require(Foundation.Utility.Wrappers.Signal)
local swipeMath = require(script.Parent.swipeMath)

local UserInputService = Services.UserInputService

local function isPointerDown(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch
end

local function updateClaim(tbl1, num1: number, num2: number, num3: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.intent ~= DragIntent.Pending then
        return false
    end

    local var1 = swipeMath.classifyDrag(num1, num2, 8, num3)
    if var1 == DragIntent.Claim then
        tbl1.intent = DragIntent.Claim
        return true
    end
    if var1 == DragIntent.Ignore then
        tbl1.intent = DragIntent.Ignore
    end
    return false
end

local function sampleVelocity(tbl1, lastX: number, lastTime: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = lastTime - tbl1.lastTime
    if var1 > 0 then
        tbl1.velocityX = (lastX - tbl1.lastX) / var1
    end
    tbl1.lastX = lastX
    tbl1.lastTime = lastTime
end

local function isOwnHit(arg1, arg2, arg3): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg2 == arg1 or arg2:IsDescendantOf(arg1) then
        return true
    end
    return not (arg3 == nil) and (arg2 == arg3 or arg2:IsDescendantOf(arg3))
end

return {
    beginGesture = function(input, lastTime: number)
        return {
            input = input,
            startX = input.Position.X,
            startY = input.Position.Y,
            lastX = input.Position.X,
            lastTime = lastTime,
            velocityX = 0,
            intent = DragIntent.Pending,
            lastProgress = nil
        }
    end,
    canBegin = function(tbl1, arg1)
        return tbl1 == nil and isPointerDown(arg1) and UserInputService:GetFocusedTextBox() == nil
    end,
    connectPointer = function(tbl1)
        local var1 = nil

        local function stopTracking() -- Luacid: Inlined by compiler; 2 call sites recovered
            if var1 ~= nil then
                Connection.Disconnect(var1)
                var1 = nil
            end
        end

        local var2 = Signal.Connect(UserInputService.InputBegan, function(arg1)
            if tbl1.onBegan(arg1) and var1 == nil then
                var1 = Signal.Connect(UserInputService.InputChanged, tbl1.onChanged)
            end
        end)
        local var3 = Signal.Connect(UserInputService.InputEnded, function(arg1)
            if tbl1.onEnded(arg1) then
                stopTracking()
            end
        end)

        return function()
            Connection.Disconnect(var2)
            Connection.Disconnect(var3)
            stopTracking()
        end
    end,
    isForeignHit = function(arg1, arg2, arg3): boolean
        return not (arg2 == nil) and not isOwnHit(arg1, arg2, arg3)
    end,
    isInside = function(arg1, vec1: vector): boolean
        local absolutePosition = arg1.AbsolutePosition
        local absoluteSize = arg1.AbsoluteSize

        return vec1.X >= absolutePosition.X
            and vec1.Y >= absolutePosition.Y
            and vec1.X <= absolutePosition.X + absoluteSize.X
            and vec1.Y <= absolutePosition.Y + absoluteSize.Y
    end,
    matchesMove = function(arg1, arg2): boolean
        if arg2.UserInputType == Enum.UserInputType.Touch then
            return arg1 == arg2
        end

        return arg1.UserInputType == Enum.UserInputType.MouseMovement
    end,
    matchesRelease = function(arg1, arg2): boolean
        if arg2.UserInputType == Enum.UserInputType.Touch then
            return arg1 == arg2
        end

        return arg1.UserInputType == Enum.UserInputType.MouseButton1
    end,
    move = function(tbl1, arg1, num1: number?)
        local position = arg1.Position
        local positionX = position.X
        local bool1 = updateClaim(tbl1, positionX - tbl1.startX, position.Y - tbl1.startY, num1)

        local bool2 = tbl1.intent == DragIntent.Claim
        if bool2 then
            sampleVelocity(tbl1, positionX, os.clock())
        end
        return bool1, bool2, positionX
    end,
    sampleVelocity = sampleVelocity,
    setProgressIfChanged = function(tbl1, callback: (...any) -> (...any), lastProgress: number)
        if tbl1.lastProgress == lastProgress then
            return
        end
        tbl1.lastProgress = lastProgress
        callback(lastProgress)
    end,
    topGuiAt = function(arg1, vec1: vector, arg2)
        local playerGui = arg1:FindFirstAncestorWhichIsA("PlayerGui")
        if playerGui == nil then
            playerGui = arg1:FindFirstAncestorWhichIsA("CoreGui")
        end
        if playerGui == nil then
            return nil
        end
        for _, value in playerGui:GetGuiObjectsAtPosition(vec1.X, vec1.Y) do
            if typeof(value) == "Instance" and value:IsA("GuiObject") and (value.Active or isOwnHit(arg1, value, arg2)) then
                return value
            end
        end
        return nil
    end,
    updateClaim = updateClaim
}
