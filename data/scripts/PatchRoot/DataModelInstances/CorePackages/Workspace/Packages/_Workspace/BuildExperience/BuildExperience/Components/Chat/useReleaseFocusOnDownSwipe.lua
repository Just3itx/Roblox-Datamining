-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local _useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)

local function getInputPosition(inputObject: InputObject): Vector2 -- Luacid: Inlined by compiler; 5 call sites recovered
    return Vector2.new(inputObject.Position.X, inputObject.Position.Y)
end

local function isPositionHorizontallyInsideGuiObject(vector2: Vector2, current): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = vector2.X - current.AbsolutePosition.X
    return var1 >= 0 and var1 <= current.AbsoluteSize.X
end

local function isDownSwipe(vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1

    if vector2.Y >= 24 then
        local vector2Y = vector2.Y
        bool1 = math.abs(vector2.X) < vector2Y
    else
        bool1 = false
    end

    return bool1
end

local function didDownSwipeCrossGuiObject(vector2: Vector2, vector2_2: Vector2, current): boolean
    if not isDownSwipe(vector2_2 - vector2) then
        return false
    end

    local absolutePositionX = current.AbsolutePosition.X
    local var1 = absolutePositionX + current.AbsoluteSize.X
    local num1 = math.min(vector2.X, vector2_2.X)
    local num2 = math.max(vector2.X, vector2_2.X)
    local absolutePositionY = current.AbsolutePosition.Y
    local var2 = absolutePositionY + current.AbsoluteSize.Y

    return absolutePositionX <= num2 and num1 <= var1 and vector2.Y <= var2 and absolutePositionY <= vector2_2.Y
end

local function useReleaseFocusOnDownSwipe(arg1, arg2)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)

    local var4 = React.useCallback(function()
        if var3.current then
            var3.current:Disconnect()
            var3.current = nil
        end
        var1.current = nil
        var2.current = nil
    end, {})

    local var5 = React.useCallback(function()
        local current = if arg2 then arg2.current else nil

        if current then
            current.releaseFocus()
        end
    end, { arg2 })

    React.useEffect(function()
        local function maybeReleaseFocus(current: InputObject): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
            local current2 = var2.current
            if var1.current ~= current or current2 == nil then
                return false
            end

            local current3 = arg1.current
            local vector2 = getInputPosition(current)

            if current3 == nil or not didDownSwipeCrossGuiObject(current2, vector2, current3) then
                return false
            end

            var4()
            var5()
            return true
        end

        local function handleInputChanged(inputObject: InputObject) -- Luacid: Inlined by compiler; 1 call site recovered
            if maybeReleaseFocus(inputObject) then
                return
            end
            if inputObject.UserInputState == Enum.UserInputState.End or inputObject.UserInputState == Enum.UserInputState.Cancel then
                var4()
            end
        end

        local connection = UserInputService.TouchStarted:Connect(function(touch: InputObject)
            var4()

            local current = arg1.current
            local current2 = if arg2 then arg2.current else nil

            if current == nil or current2 == nil then
                return
            end

            local vector2 = getInputPosition(touch)

            if not isPositionHorizontallyInsideGuiObject(vector2, current)
                or vector2.Y > current.AbsolutePosition.Y + current.AbsoluteSize.Y
            then
                return
            end

            var1.current = touch
            var2.current = vector2
            var3.current = touch.Changed:Connect(function()
                handleInputChanged(touch)
            end)
        end)

        local connection2 = UserInputService.TouchEnded:Connect(function(touch: InputObject)
            if var1.current == touch and not maybeReleaseFocus(touch) then
                var4()
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            var4()
        end
    end, {
        arg1,
        arg2,
        var4,
        var5
    })
end
return useReleaseFocusOnDownSwipe
