-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local RunService = game:GetService("RunService")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local Otter = require(AvatarExperienceCommonParent.Otter)
local React = require(AvatarExperienceCommonParent.React)

local Constants = require(AvatarExperienceCommon.Constants)

local tbl1 = { dampingRatio = 1, frequency = 3.5 }

local function useArrowNavScrollBehavior(tbl2)
    local holdConnRef = React.useRef(nil)
    local motorRef = React.useRef(nil)
    local timeOfInputBeganRef = React.useRef(0)

    if tbl2.defaultUseProps then
        if tbl2.defaultUseProps.buttonRefs ~= nil then
            if tbl2.defaultUseProps.buttonWidth ~= nil then
                error("Cannot set both buttonWidth and buttonRefs")
            end
            if tbl2.defaultUseProps.numButtons ~= nil then
                error("Cannot set both numButtons and buttonRefs")
            end
        end
        if tbl2.defaultUseProps.buttonWidth ~= nil and tbl2.defaultUseProps.numButtons == nil then
            error("If setting buttonWidth must also set numButtons")
        end
        if tbl2.defaultUseProps.buttonWidth == nil and tbl2.defaultUseProps.numButtons ~= nil then
            error("If setting numButtons must also set buttonWidth")
        end

        if tbl2.defaultUseProps.buttonRefs == nil
            and tbl2.defaultUseProps.buttonWidth == nil
            and tbl2.defaultUseProps.numButtons == nil
        then
            error("Must set either buttonRefs or (buttonWidth and numButtons)")
        end
    end

    local function disconnectHoldConn() -- Luacid: Inlined by compiler; 3 call sites recovered
        if holdConnRef.current then
            holdConnRef.current:Disconnect()
            holdConnRef.current = nil
        end
    end

    local function getNewCanvasPosition(x: number) -- Luacid: Inlined by compiler; 1 call site recovered
        return tbl2.defaultUseProps.scrollingFrameRef.current.CanvasPosition + Vector2.new(x, 0)
    end

    local function setMotor(num1: number)
        if motorRef.current then
            motorRef.current:destroy()
        end
        motorRef.current = Otter.createSingleMotor(num1)
        if not motorRef.current then
            return
        end

        motorRef.current:onStep(function(x: number)
            tbl2.defaultUseProps.updateCanvasPosition(Vector2.new(x, 0))
        end)
        motorRef.current:onComplete(function(x: number)
            tbl2.defaultUseProps.updateCanvasPosition(Vector2.new(x, 0))
        end)
    end

    local function getScrollToLocation(isLeft: string)
        local tbl3 = {}
        local buttonRefs = tbl2.defaultUseProps.buttonRefs
        local buttonWidth = tbl2.defaultUseProps.buttonWidth
        local numButtons = tbl2.defaultUseProps.numButtons

        if buttonWidth and numButtons then
            tbl3 = table.create(numButtons, buttonWidth)
        elseif buttonRefs then
            for _, buttonRef in buttonRefs do
                if not (buttonRef and buttonRef.current) then
                    continue
                end

                local offset = buttonRef.current.Size.X.Offset or 0

                if offset == 0 then
                    offset = buttonRef.current.AbsoluteSize.X
                end

                table.insert(tbl3, offset)
            end
        end

        local current = tbl2.defaultUseProps.scrollingFrameRef.current
        local buttonPadding = tbl2.defaultUseProps.buttonPadding

        if isLeft == Constants.NAVIGATION_DIRECTION.IS_LEFT then
            local num1 = 0

            for _, value in tbl3 do
                if not (num1 + value + buttonPadding <= current.CanvasPosition.X) then
                    break
                end

                num1 = num1 + value + buttonPadding
            end

            local num2 = 0
            for _, value in tbl3 do
                if not (num2 + value + buttonPadding <= current.AbsoluteSize.X * 0.8) then
                    break
                end

                num2 = num2 + value + buttonPadding
                num1 = num1 - value - buttonPadding
            end

            return math.max(0, num1)
        end

        local num1 = 0

        for _, value in tbl3 do
            if not (num1 + value + buttonPadding <= current.CanvasPosition.X) then
                break
            end

            num1 = num1 + value + buttonPadding
        end

        local num2 = 0
        for _, value in tbl3 do
            if not (num2 + value + buttonPadding <= current.AbsoluteSize.X * 0.8) then
                break
            end

            num2 = num2 + value + buttonPadding
            num1 = num1 + value + buttonPadding
        end

        return num1
    end

    local function getGoal(isLeft: string)
        return Otter.spring(getScrollToLocation(isLeft), tbl1)
    end

    local function onPressHoldInputBegan(arg1, str1: string)
        if arg1.UserInputState ~= Enum.UserInputState.Begin then
            return
        end
        timeOfInputBeganRef.current = tick()
        disconnectHoldConn()

        holdConnRef.current = RunService.RenderStepped:Connect(function(deltaTime: number)
            local var4 = tick() - timeOfInputBeganRef.current
            local isLeft = Constants.NAVIGATION_DIRECTION.IS_LEFT
            local newCanvasPosition = getNewCanvasPosition((if str1 == isLeft then -1 else 1) * 500 * deltaTime * var4 ^ 2)
            tbl2.defaultUseProps.updateCanvasPosition(newCanvasPosition)
        end)
    end

    local function onPressHoldInputEnded(arg1, isLeft: string)
        if arg1.UserInputState ~= Enum.UserInputState.End then
            return
        end
        local current = tbl2.defaultUseProps.scrollingFrameRef.current
        if tick() - timeOfInputBeganRef.current <= 0.5 then
            if motorRef.current then
                motorRef.current:destroy()
            end
            setMotor(current.CanvasPosition.X)
            if motorRef.current then
                motorRef.current:setGoal(getGoal(isLeft))
            end
        elseif motorRef.current then
            motorRef.current:setGoal(Otter.instant(current.CanvasPosition.X))
        end

        disconnectHoldConn()
    end

    React.useEffect(function()
        if tbl2.defaultUseProps then
            setMotor(0)
        end

        return function()
            disconnectHoldConn()

            if motorRef.current then
                motorRef.current:destroy()
                motorRef.current = nil
            end
        end
    end, {})

    return {
        holdConnRef = holdConnRef,
        motorRef = motorRef,
        timeOfInputBeganRef = timeOfInputBeganRef,
        handleInputBegan = function(_, arg1)
            local var4 = tbl2.onPressHoldInputBegan or onPressHoldInputBegan
            if var4 then
                var4(arg1, tbl2.navDirection or "")
            end
        end,
        handleInputEnded = function(_, arg1)
            local var4 = tbl2.onPressHoldInputEnded or onPressHoldInputEnded
            if var4 then
                var4(arg1, tbl2.navDirection or "")
            end
        end,
        disconnectHoldConn = disconnectHoldConn
    }
end

return useArrowNavScrollBehavior
