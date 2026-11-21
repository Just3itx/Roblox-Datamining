-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local UserInputService = game:GetService("UserInputService")
local React = require(GamePlayButtonParent.React)
local PressCaptureUtils = require(script.Parent.PressCaptureUtils)

local isPointInsideBounds = PressCaptureUtils.isPointInsideBounds
local getInputPosition = PressCaptureUtils.getInputPosition
local isPressInput = PressCaptureUtils.isPressInput

local function disconnectGlobalInputEnded(current) -- Luacid: Inlined by compiler; 5 call sites recovered
    if current.inputEndedConnection then
        current.inputEndedConnection:Disconnect()
        current.inputEndedConnection = nil
    end
end

local function disconnectInstanceListeners(current) -- Luacid: Inlined by compiler; 10 call sites recovered
    if current.destroyingConnection then
        current.destroyingConnection:Disconnect()
        current.destroyingConnection = nil
    end
    if current.instanceInputEndedConnection then
        current.instanceInputEndedConnection:Disconnect()
        current.instanceInputEndedConnection = nil
    end
end

local function clearPressTracking(current) -- Luacid: Inlined by compiler; 6 call sites recovered
    current.isPressed = false
    current.boundsPosition = nil
    current.boundsSize = nil
    disconnectInstanceListeners(current)
end

local function disconnectAllPressCapture(current) -- Luacid: Inlined by compiler; 4 call sites recovered
    clearPressTracking(current)
    disconnectGlobalInputEnded(current)
end

return function(current: (...any) -> (...any))
    local var1 = React.useRef(current)
    var1.current = current

    local var2 = React.useRef({
        isPressed = false,
        boundsPosition = nil,
        boundsSize = nil,
        destroyingConnection = nil,
        inputEndedConnection = nil,
        instanceInputEndedConnection = nil
    })

    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(false)

    local onActivated = React.useCallback(function()
        local current2 = var2.current

        if not current2.isPressed then
            var5.current = false
        elseif var5.current then
            return
        end
        var5.current = true
        disconnectAllPressCapture(current2)
        var1.current()
    end, {})

    local var7 = React.useCallback(function(arg1)
        local current2 = var2.current
        if not (current2.isPressed and current2.boundsPosition and current2.boundsSize) then
            disconnectAllPressCapture(current2)
            return
        end

        local inputPosition = getInputPosition(arg1)
        if isPointInsideBounds(inputPosition, current2.boundsPosition, current2.boundsSize) then
            onActivated()
            return
        end

        disconnectAllPressCapture(current2)
    end, { onActivated })

    local var8 = React.useCallback(function()
        local current2 = var2.current
        if current2.inputEndedConnection then
            return
        end

        current2.inputEndedConnection = UserInputService.InputEnded:Connect(function(input: InputObject)
            if not isPressInput(input) then
                return
            end
            var7(input)
        end)
    end, { var7 })

    local var9 = React.useCallback(function(arg1)
        if arg1 == nil then
            return function() end
        end

        local function onPressInstanceDestroyed()
            if not var2.current.isPressed then
                return
            end
            disconnectInstanceListeners(var2.current)
            var8()
        end

        local connection = arg1.InputBegan:Connect(function(input: InputObject)
            if not isPressInput(input) then
                return
            end

            local current2 = var2.current
            var5.current = false
            current2.isPressed = true
            current2.boundsPosition = arg1.AbsolutePosition
            current2.boundsSize = arg1.AbsoluteSize
            disconnectInstanceListeners(current2)
            current2.destroyingConnection = arg1.Destroying:Connect(onPressInstanceDestroyed)
            current2.instanceInputEndedConnection = arg1.InputEnded:Connect(function(input: InputObject)
                if isPressInput(input) and var2.current.isPressed then
                    disconnectAllPressCapture(var2.current)
                end
            end)
        end)

        return function()
            connection:Disconnect()
        end
    end, { var8 })

    local playButtonRef = React.useCallback(function(arg1)
        if var3.current then
            var3.current()
            var3.current = nil
        end

        if arg1 and arg1:IsA("GuiObject") then
            var3.current = var9(arg1)
        end
    end, { var9 })

    local loadingCaptureRef = React.useCallback(function(arg1)
        if var4.current then
            var4.current()
            var4.current = nil
        end

        if arg1 and arg1:IsA("GuiObject") then
            var4.current = var9(arg1)
        end
    end, { var9 })

    React.useEffect(function()
        return function()
            if var3.current then
                var3.current()
                var3.current = nil
            end
            if var4.current then
                var4.current()
                var4.current = nil
            end

            local current2 = var2.current
            if current2.isPressed and not current2.inputEndedConnection then
                disconnectInstanceListeners(current2)
                var8()
            elseif not current2.inputEndedConnection then
                clearPressTracking(current2)
            end
        end
    end, { var8 })

    return {
        onActivated = onActivated,
        playButtonRef = playButtonRef,
        loadingCaptureRef = loadingCaptureRef
    }
end
