-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent

local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")

local React = require(CoreGuiCommonParent.React)

local function normalizeStickY(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = math.abs(num1)

    if num2 <= 0.2 then
        return 0
    end

    return math.sign(num1) * (num2 - 0.2) / 0.8
end

local function scrollByStick(current, num1: number, deltaTime: number)
    local num2 = math.max(0, current.AbsoluteCanvasSize.Y - current.AbsoluteWindowSize.Y)
    if num2 == 0 then
        return
    end

    local num3 = normalizeStickY(num1)

    if num3 == 0 then
        return
    end

    local y = math.clamp(current.CanvasPosition.Y + deltaTime * -num3 * 1000, 0, num2)
    current.CanvasPosition = Vector2.new(current.CanvasPosition.X, y)
end

local function useGamepadStickScroll(tbl1)
    React.useEffect(function()
        if not tbl1.enabled then
            return
        end

        local var1 = tbl1.contextActionServiceOverride or ContextActionService
        local var2 = tbl1.runServiceOverride or RunService
        local var3 = nil

        var1:BindCoreAction(tbl1.actionName, function(_, userInputState, arg1): Enum.ContextActionResult
            if userInputState == Enum.UserInputState.Change then
                var3 = arg1
            elseif userInputState == Enum.UserInputState.End then
                var3 = nil
            end
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.Thumbstick2)

        local connection = var2.RenderStepped:Connect(function(deltaTime: number)
            local current = tbl1.scrollingFrameRef.current
            if var3 ~= nil and current ~= nil then
                scrollByStick(current, var3.Position.Y, deltaTime)
            end
        end)

        return function()
            var1:UnbindCoreAction(tbl1.actionName)
            connection:Disconnect()
        end
    end, {
        tbl1.actionName,
        tbl1.enabled,
        tbl1.scrollingFrameRef,
        tbl1.contextActionServiceOverride,
        tbl1.runServiceOverride
    })
end

return useGamepadStickScroll
