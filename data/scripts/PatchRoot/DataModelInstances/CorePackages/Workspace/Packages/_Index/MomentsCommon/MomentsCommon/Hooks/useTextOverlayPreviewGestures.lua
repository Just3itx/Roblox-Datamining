-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Responsive = require(MomentsCommonParent.Responsive)
local TextOverlayPreviewGestureUtils = require(MomentsCommon.Utils.TextOverlayPreviewGestureUtils)

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef

local function shapeScale(num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.max(0.3, num1 * (if num2 >= 1 then (num2 - 1) ^ 1.5 + 1 else 1 - (1 - num2) ^ 1.5))
end

local function touchesStartOnOverlay(tbl1, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return false
    end
    return TextOverlayPreviewGestureUtils.touchGestureStartsOnOverlay(tbl1, arg1.AbsolutePosition, arg1.AbsoluteSize)
end

local function useTextOverlayPreviewGestures(tbl1)
    local var1 = tbl1.userInputService or UserInputService
    local var2 = tbl1.guiService or GuiService
    local var3 = Responsive.useDeviceInsets()

    local var4 = useRef(tbl1.scale)
    var4.current = tbl1.scale
    local var5 = useRef(tbl1.rotation)
    var5.current = tbl1.rotation
    local var6 = useRef(tbl1.onScaleChanged)
    var6.current = tbl1.onScaleChanged
    local var7 = useRef(tbl1.onRotationChanged)
    var7.current = tbl1.onRotationChanged

    local var8 = useRef(1)
    local var9 = useRef(0)
    local var10 = useRef(0)
    local var11 = useRef(0)
    local var12 = useRef(false)
    local var13 = useRef(false)

    local var14 = useCallback(function()
        return var2:GetGuiInset() + Vector2.new(var3.left, var3.top)
    end, { var3, var2 })

    local var15 = useCallback(function()
        local current = if tbl1.containerRef then tbl1.containerRef.current else nil

        if current == nil then
            return nil
        end

        return current.AbsolutePosition + current.AbsoluteSize / 2
    end, { tbl1.containerRef })

    local enabled = tbl1.enabled

    if enabled then
        if tbl1.selected == true then
            enabled = tbl1.preferredInput == Responsive.Input.Touch
        else
            enabled = false
        end
    end

    local enabled2 = tbl1.enabled

    if enabled2 then
        if tbl1.selected == true then
            enabled2 = tbl1.preferredInput == Responsive.Input.Pointer
        else
            enabled2 = false
        end
    end
    useEffect(function()
        if not enabled then
            return nil
        end

        local function overlayContainer() -- Luacid: Inlined by compiler; 2 call sites recovered
            return if tbl1.containerRef then tbl1.containerRef.current else nil
        end

        local connection = var1.TouchPinch:Connect(function(...)
            local var16, var17, _, var18 = ...
            local current = var6.current
            if var18 == Enum.UserInputState.Begin then
                var12.current = false

                if current == nil or not touchesStartOnOverlay(var16, (overlayContainer())) then
                    return
                end
                var8.current = var4.current
                var12.current = true
                return
            end

            if var18 ~= Enum.UserInputState.Change then
                var12.current = false
                return
            end

            if #var16 < 2 then
                var12.current = false
                return
            end

            if var12.current and current then
                current(math.max(0.3, var8.current * (if var17 >= 1 then (var17 - 1) ^ 1.5 + 1 else 1 - (1 - var17) ^ 1.5)))
            end
        end)

        local connection2 = var1.TouchRotate:Connect(function(...)
            local var16, _, _, var17 = ...
            local current = var7.current
            local touchLineAngleDegrees = TextOverlayPreviewGestureUtils.getTouchLineAngleDegrees(var16)
            if var17 == Enum.UserInputState.Begin then
                var13.current = false

                if current == nil or touchLineAngleDegrees == nil or not touchesStartOnOverlay(var16, (overlayContainer())) then
                    return
                end

                var10.current = var5.current
                var11.current = touchLineAngleDegrees
                var13.current = true
                return
            end

            if var17 ~= Enum.UserInputState.Change then
                var13.current = false
                return
            end

            if touchLineAngleDegrees == nil then
                var13.current = false
                return
            end

            if var13.current and current then
                local var18 = var10
                var18.current += TextOverlayPreviewGestureUtils.getTouchRotationStepDegrees(var11.current, touchLineAngleDegrees)

                var11.current = touchLineAngleDegrees
                current(var10.current)
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            var12.current = false
            var13.current = false
        end
    end, { enabled, tbl1.containerRef, var1 })

    local var16 = useRef(nil)
    local var17 = useRef(false)
    local var18 = useRef(1)
    local var19 = useRef(0)
    local var20 = useRef(nil)
    local var21 = useRef(nil)

    local var22 = useCallback(function()
        var16.current = nil
        var17.current = false
        if var20.current then
            var20.current:Disconnect()
            var20.current = nil
        end
        if var21.current then
            var21.current:Disconnect()
            var21.current = nil
        end
    end, {})

    local var23 = useCallback(function(current: string)
        if not enabled2 then
            return
        end
        var22()
        var16.current = current
        var17.current = true
        var8.current = var4.current
        var9.current = var5.current

        var20.current = var1.InputChanged:Connect(function(_inputObject: InputObject)
            if var16.current == nil then
                return
            end
            local var23 = var15()
            if var23 == nil then
                return
            end

            local var24 = var1:GetMouseLocation() - var14()

            if var17.current then
                local var25 = var18
                var25.current = math.max((var24 - var23).Magnitude, 1)
                local var26 = var19
                var26.current = math.atan2(var24.Y - var23.Y, var24.X - var23.X)
                var17.current = false
                return
            end
            if var16.current == "resize" then
                local current2 = var6.current
                if current2 then
                    current2((shapeScale(var8.current, (var24 - var23).Magnitude / var18.current)))
                end
            else
                local current2 = var7.current
                if current2 then
                    local num1 = math.atan2(var24.Y - var23.Y, var24.X - var23.X)
                    current2(var9.current + math.deg(num1 - var19.current))
                end
            end
        end)

        var21.current = var1.InputEnded:Connect(function()
            if #var1:GetMouseButtonsPressed() == 0 then
                var22()
            end
        end)
    end, {
        enabled2,
        var15,
        var14,
        var22,
        var1
    })

    useEffect(function()
        if not enabled2 then
            var22()
        end
        return function()
            var22()
        end
    end, { enabled2, var22 })

    return {
        onResizeHandleInputBegan = useCallback(function(_)
            var23("resize")
        end, { var23 }),
        onRotateHandleInputBegan = useCallback(function(_)
            var23("rotate")
        end, { var23 })
    }
end

return useTextOverlayPreviewGestures
