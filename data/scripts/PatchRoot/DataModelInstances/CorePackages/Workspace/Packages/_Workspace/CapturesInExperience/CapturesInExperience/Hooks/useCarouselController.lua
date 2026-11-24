-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local UserInputService = game:GetService("UserInputService")

local Otter = require(scriptParentParentParent.Otter)
local React = require(scriptParentParentParent.React)
local ReactUtils = require(scriptParentParentParent.ReactUtils)
local Responsive = require(scriptParentParentParent.Responsive)
local RoactUtils = require(scriptParentParentParent.RoactUtils)
local SocialCommon = require(scriptParentParentParent.SocialCommon)

local useAnalytics = require(scriptParentParent.Analytics.useAnalytics)
local useBinding = React.useBinding
local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local useEventConnection = ReactUtils.useEventConnection
local useIsHovered = SocialCommon.Hooks.useIsHovered
local useIsTouchDown = SocialCommon.Hooks.useIsTouchDown
local useLastInput = Responsive.useLastInput

local EventNames = require(scriptParentParent.Analytics.EventNames)
local getClosestItemToCenter = require(scriptParentParent.Utils.getClosestItemToCenter)

local FFlagUseMediaPlayerInCarousel = require(scriptParentParentParent.SharedFlags).FFlagUseMediaPlayerInCarousel

local tbl1 = { dampingRatio = 1, frequency = 4 }

local function isWithinEpsilon(num1: number, num2: number, num3: number): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return math.abs(num1 - num2) < num3
end

local function createController(carouselRef, arg1, callback: (...any) -> (...any))
    local connection = nil
    local bool1 = false
    local var1 = nil
    local getIsNavigationLocked = false
    local num1 = 0
    local getWasTouched = false

    local function resetTouchState() -- Luacid: Inlined by compiler; 2 call sites recovered
        bool1 = false
        getWasTouched = false
    end

    local function resetMotor(num2: number, func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?)
        if var1 then
            var1:destroy()
            var1 = nil
        end

        local singleMotor = Otter.createSingleMotor(num2)
        var1 = singleMotor
        singleMotor:onStep(function(x)
            if var1 ~= singleMotor then
                singleMotor:destroy()
                return
            end

            if bool1 then
                singleMotor:destroy()
                var1 = nil
                return
            end

            if isWithinEpsilon(x, num1, 0.5) then
                x = num1
            end
            if func1 and func1(num2, x) then
                return
            end

            if carouselRef.current then
                carouselRef.current.CanvasPosition = Vector2.new(x, 0)
            end
        end)

        if func2 then
            singleMotor:onComplete(func2)
        end

        singleMotor:start()
    end
    local function setGoal(vector2: Vector2, num2: number, bool4: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
        if not var1 then
            return
        end
        assert(var1 ~= nil, "setGoal called before resetMotor")

        num1 = vector2.X * (num2 - 1)

        if bool4 then
            var1:setGoal(Otter.instant(num1))
            return
        end
        var1:setGoal(Otter.spring(num1, tbl1))
    end

    local tbl2 = {
        carouselRef = carouselRef,
        getWasTouched = function()
            return getWasTouched
        end,
        getIsNavigationLocked = function()
            return getIsNavigationLocked
        end,
        handleDeleteTransition = function(callback2: (...any) -> (...any), callback3: (...any) -> (...any), vector2: Vector2, num2: number, bool4: boolean, callback4: (...any) -> (...any))
            local current = carouselRef.current
            local current2 = arg1.current
            if not (current and current2) then
                return
            end
            assert(current ~= nil, "carousel should exist")
            assert(current2 ~= nil, "selectedItem should exist")

            local scrollingEnabled = current.ScrollingEnabled
            current.ScrollingEnabled = false
            resetTouchState()
            getIsNavigationLocked = true

            local function handleDeleteNextImageMovement()
                resetMotor(current.CanvasPosition.X, function(num3: number, num4: number): boolean -- name: onStep
                    local num5 = math.abs(num3 - num4)
                    local xOffset = math.round(vector2.X - num5)
                    current2.Size = UDim2.fromOffset(xOffset, vector2.Y)

                    return num2 == 1
                end, function()
                    callback4()
                    current2.Visible = false
                    callback2(1)
                    getIsNavigationLocked = false

                    current.ScrollingEnabled = scrollingEnabled
                end)

                setGoal(vector2, num2 - 1, bool4 or UserGameSettings.ReducedMotion)
            end

            local function handleDeleteImagesFadeIn()
                if not callback3 then
                    return
                end
                assert(callback3 ~= nil, "setPostDeletionItemBinding should exist")
                resetMotor(current.CanvasPosition.X, function(_, _: number): boolean
                    return num2 == 1
                end, function()
                    callback4()
                    current2.Visible = false
                    local singleMotor = Otter.createSingleMotor(0)
                    singleMotor:onStep(function(arg2)
                        callback2(arg2)
                        callback3(1)
                    end)
                    singleMotor:onComplete(function()
                        getIsNavigationLocked = false

                        current.ScrollingEnabled = scrollingEnabled
                    end)
                    singleMotor:setGoal(Otter.spring(1, { frequency = 2 }))
                end)

                setGoal(vector2, num2 - 1, true)
            end

            local function handleDeleteNextImageFadeOut()
                if not callback3 then
                    return
                end
                assert(callback3 ~= nil, "setPostDeletionItemBinding should exist")
                local singleMotor = Otter.createSingleMotor(1)
                singleMotor:onStep(callback3)
                singleMotor:onComplete(handleDeleteImagesFadeIn)
                singleMotor:setGoal(Otter.spring(0, { frequency = 6 }))
            end

            local singleMotor = Otter.createSingleMotor(1)
            singleMotor:onStep(callback2)
            local num3

            if UserGameSettings.ReducedMotion then
                singleMotor:onComplete(handleDeleteNextImageFadeOut)
                num3 = 6
            else
                singleMotor:onComplete(handleDeleteNextImageMovement)
                num3 = 4
            end
            singleMotor:setGoal(Otter.spring(0, { frequency = num3 }))
        end,
        handleInertialMove = function(vector2: Vector2, num2: number)
            local current = carouselRef.current
            if bool1 or not current then
                return
            end

            assert(current ~= nil, "carousel should not be nil")

            local var2 = -current:GetSampledInertialVelocity().X
            current:ClearInertialScrolling()

            local var3, var4 = getClosestItemToCenter(vector2, current)
            if math.abs(var2) < 60 and var3 == num2 then
                if var4 > 0.5 then
                    local canvasPositionX = current.CanvasPosition.X

                    if var1 then
                        var1:destroy()
                        var1 = nil
                    end

                    local singleMotor = Otter.createSingleMotor(canvasPositionX)
                    var1 = singleMotor
                    local var5 = nil

                    singleMotor:onStep(function(x)
                        if var1 ~= singleMotor then
                            singleMotor:destroy()
                            return
                        end

                        if bool1 then
                            singleMotor:destroy()
                            var1 = nil
                            return
                        end

                        if isWithinEpsilon(x, num1, 0.5) then
                            x = num1
                        end
                        if var5 and var5(canvasPositionX, x) then
                            return
                        end

                        if carouselRef.current then
                            carouselRef.current.CanvasPosition = Vector2.new(x, 0)
                        end
                    end)

                    singleMotor:start()
                    setGoal(vector2, num2, false)
                    return
                end

                return
            end

            if connection then
                connection:Disconnect()
                connection = nil
            end

            connection = RunService.RenderStepped:Connect(function(deltaTime: number)
                local current2 = carouselRef.current
                if not current2 or bool1 then
                    assert(connection ~= nil, "handleInertialMoveConn should exist")
                    connection:Disconnect()
                    connection = nil
                    return
                end

                assert(current2 ~= nil, "carousel should not be nil")

                local var5, var6 = getClosestItemToCenter(vector2, current2)

                if not (math.abs(var2) < 60) then
                    current2.CanvasPosition += Vector2.new(var2 * deltaTime, 0)

                    local num3 = math.max(var6 / (vector2.X / 2) * 1.25, 0.85)

                    local num4 = if math.abs(var2) < 120 then 0.7 else num3 * 0.95

                    var2 *= num4 ^ (deltaTime / (1 / 60))
                    return
                end

                assert(connection ~= nil, "handleInertialMoveConn should exist")
                connection:Disconnect()
                connection = nil

                if var5 ~= num2 then
                    callback(var5)

                    return
                end

                local canvasPositionX = current2.CanvasPosition.X

                if var1 then
                    var1:destroy()
                    var1 = nil
                end

                local singleMotor = Otter.createSingleMotor(canvasPositionX)
                var1 = singleMotor
                local var7 = nil

                singleMotor:onStep(function(x)
                    if var1 ~= singleMotor then
                        singleMotor:destroy()
                        return
                    end

                    if bool1 then
                        singleMotor:destroy()
                        var1 = nil
                        return
                    end

                    if isWithinEpsilon(x, num1, 0.5) then
                        x = num1
                    end
                    if var7 and var7(canvasPositionX, x) then
                        return
                    end

                    if carouselRef.current then
                        carouselRef.current.CanvasPosition = Vector2.new(x, 0)
                    end
                end)

                singleMotor:start()

                setGoal(vector2, num2, false)
            end)
        end,
        onInputBegan = function(_, arg2)
            if getIsNavigationLocked then
                return
            end

            if arg2.UserInputType == Enum.UserInputType.Touch then
                bool1 = true
                getWasTouched = true
            end
        end,
        resetMotor = resetMotor,
        resetTouchState = resetTouchState,
        setGoal = setGoal,
        setIsNavigationLocked = function(bool4: boolean)
            if bool4 == true then
                resetTouchState()
            end

            getIsNavigationLocked = bool4
        end
    }
    tbl2.resetMotor(0)

    return tbl2
end

return function(vector2: Vector2, num1: number, callback: (...any) -> (...any))
    local var1 = useAnalytics()
    local selectedItemFadeOutBinding, var3 = useBinding(1)

    local postDeletionItemBinding, var5 = useBinding(1)
    local carouselRef = React.useRef(nil)
    local var6, var7, var8 = useIsHovered()
    local var9 = useIsTouchDown()
    local selectedItemRef = React.useRef(nil)
    local var11 = useLastInput()

    local var12 = React.useRef(nil)

    if var12.current == nil then
        var12.current = createController(carouselRef, selectedItemRef, callback)
    end

    local current = var12.current
    assert(current ~= nil, "carouselController should exist")

    React.useEffect(function()
        local current2 = carouselRef.current
        if not current2 then
            return
        end
        assert(current2 ~= nil, "carousel should exist")

        local bool1 = not not UserGameSettings.ReducedMotion

        current.resetMotor(current2.CanvasPosition.X)
        current.setGoal(vector2, num1, bool1)
    end, { num1 })

    useEffectOnce(function()
        current.setGoal(vector2, num1, true)
    end, num1 ~= nil)

    React.useEffect(function()
        current.setGoal(vector2, num1, true)
    end, { vector2 })

    React.useEffect(function()
        if not var9 and current.getWasTouched() then
            current.resetTouchState()
            current.handleInertialMove(vector2, num1)
        end
    end, { var9 })

    local var13 = React.useCallback(function(num2: number)
        local current2 = carouselRef.current
        if not current2 then
            return
        end
        assert(current2 ~= nil, "carousel should exist")

        if current.getIsNavigationLocked() then
            return
        end

        local closestItemToCenter = getClosestItemToCenter(vector2, current2)
        if var6 and num2 > 0 then
            callback(closestItemToCenter - 1)
        elseif var6 and num2 < 0 then
            callback(closestItemToCenter + 1)
        end
    end, { var6, vector2 })

    useEventConnection(UserInputService.PointerAction, var13)

    local var14 = React.useCallback(function(swipeDirection)
        if not UserGameSettings.ReducedMotion then
            return
        end
        local current2 = carouselRef.current
        if not current2 then
            return
        end
        assert(current2 ~= nil, "carousel should exist")

        if current.getIsNavigationLocked() then
            return
        end

        local closestItemToCenter = getClosestItemToCenter(vector2, current2)
        if swipeDirection == Enum.SwipeDirection.Left then
            callback(closestItemToCenter + 1)
        elseif swipeDirection == Enum.SwipeDirection.Right then
            callback(closestItemToCenter - 1)
        end
    end, {})

    useEventConnection(UserInputService.TouchSwipe, var14)

    React.useEffect(function()
        ContextActionService:BindCoreAction("CapturesCarouselNavigateShortcutAction", function(_, userInputState, arg1)
            local current2 = carouselRef.current
            if not current2 then
                return
            end
            assert(current2 ~= nil, "carousel should exist")

            if current.getIsNavigationLocked() then
                return
            end

            if userInputState ~= Enum.UserInputState.End then
                return
            end

            var1.fireEvent(EventNames.CapturesCarouselNavigatedByKeyboard)
            local closestItemToCenter = getClosestItemToCenter(vector2, current2)
            if arg1.KeyCode == Enum.KeyCode.Left then
                callback(closestItemToCenter - 1)
            elseif arg1.KeyCode == Enum.KeyCode.Right then
                callback(closestItemToCenter + 1)
            end
        end, false, Enum.KeyCode.Left, Enum.KeyCode.Right)

        return function()
            ContextActionService:UnbindCoreAction("CapturesCarouselNavigateShortcutAction")
        end
    end, {})

    return {
        carouselInputBegan = React.useCallback(function(arg1, arg2)
            if current.getIsNavigationLocked() then
                return
            end

            if UserGameSettings.ReducedMotion then
                var7(arg1, arg2)
            else
                current.onInputBegan(arg1, arg2)
                var7(arg1, arg2)
            end
        end, { current.onInputBegan, var7 }),
        carouselInputEnded = React.useCallback(function(arg1, arg2)
            if FFlagUseMediaPlayerInCarousel and var11 == "Touch" and not current.getWasTouched() then
                current.onInputBegan(arg1, arg2)
            end
            var8(arg1, arg2)
        end, { var8 }),
        carouselRef = carouselRef,
        deleteSelectedItem = React.useCallback(function(arg1)
            current.handleDeleteTransition(var3, var5, vector2, num1, false, arg1)
        end, { vector2, num1, var3 }),
        postDeletionItemBinding = postDeletionItemBinding,
        selectedItemFadeOutBinding = selectedItemFadeOutBinding,
        selectedItemRef = selectedItemRef,
        setIsNavigationLocked = current.setIsNavigationLocked
    }
end
