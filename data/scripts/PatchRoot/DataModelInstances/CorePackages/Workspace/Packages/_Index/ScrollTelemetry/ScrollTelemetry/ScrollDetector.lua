-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local ScrollTelemetryParent = script:FindFirstAncestor("ScrollTelemetry").Parent
local React = require(ScrollTelemetryParent.React)

local FFlagLuaAppScrollDetectorLifecycleHardening = require(ScrollTelemetryParent.SharedFlags).FFlagLuaAppScrollDetectorLifecycleHardening

game:DefineFastInt("ScrollDetectorTimeThresholdMillis", 300000)
game:DefineFastInt("ScrollDetectorDelayMillis", 250)

local function getDelaySeconds(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return game:GetFastInt("ScrollDetectorDelayMillis") / 1000
end

local function getThresholdSeconds(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return game:GetFastInt("ScrollDetectorTimeThresholdMillis") / 1000
end

return function(tbl1)
    local var1 = React.useRef(0)
    local var2 = React.useRef(0)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(0)
    local var6 = React.useRef(0)

    local var7 = React.useRef(nil)

    local var8 = React.useRef(tbl1.onScrollStart)
    var8.current = tbl1.onScrollStart

    local var9 = React.useRef(tbl1.onScrollSettled)
    var9.current = tbl1.onScrollSettled

    if FFlagLuaAppScrollDetectorLifecycleHardening then
        local var10 = React.useRef(tbl1.sendScrollEvent)
        var10.current = tbl1.sendScrollEvent

        React.useEffect(function()
            local function func1(num1: number) -- Luacid: Inlined by compiler; 5 call sites recovered
                local var11 = var1.current - var2.current
                if var11 == 0 then
                    return
                end

                if var10.current then
                    var10.current(var11, num1 - var5.current, var2.current)
                end
            end

            local function func2()
                if not (tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current) then
                    func1(var6.current)
                    if var3.current then
                        var3.current:Disconnect()
                    end
                    var3.current = nil
                    return
                end

                local current = time()
                local var11 = current - var5.current
                local var12

                if tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current then
                    if tbl1.scrollingFrameRef.current.ScrollingDirection == Enum.ScrollingDirection.Y then
                        var12 = tbl1.scrollingFrameRef.current.CanvasPosition.Y
                    else
                        var12 = tbl1.scrollingFrameRef.current.CanvasPosition.X
                    end
                else
                    var12 = nil
                end

                local var13 = var1.current - var2.current
                local var14 = var12 - var1.current

                if not var7.current and var14 == 0 then
                    var7.current = var6.current
                elseif var7.current and var14 ~= 0 then
                    var7.current = nil
                end

                if var7.current and var7.current + getDelaySeconds() < current then
                    var1.current = var12
                    func1(var7.current)

                    if var9.current then
                        local var15 = var1.current - var2.current

                        var9.current(var15)
                    end

                    var2.current = var12
                    local current = var3.current
                    if current then
                        current:Disconnect()
                    end
                    var3.current = nil
                    return
                end

                if var13 ~= 0 and var14 ~= 0 and math.sign(var13) ~= math.sign(var14) then
                    func1(var6.current)
                    var2.current = var1.current
                    var5.current = var6.current
                elseif not var7.current and getThresholdSeconds() <= var11 then
                    var1.current = var12
                    func1(current)
                    var2.current = var12
                    var5.current = current
                end

                var1.current = var12
                var6.current = current
            end

            local function func3()
                if var3.current then
                    return
                end
                var5.current = time()
                var6.current = var5.current
                var2.current = var1.current

                var7.current = nil

                if var8.current then
                    var8.current()
                end

                var3.current = RunService.Stepped:Connect(function()
                    func2()
                end)
            end

            local connection = nil

            if tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current and var4.current ~= tbl1.scrollingFrameRef.current then
                local scrollingDirection = tbl1.scrollingFrameRef.current.ScrollingDirection
                local var11 = var1
                var11.current = if scrollingDirection == Enum.ScrollingDirection.Y then tbl1.scrollingFrameRef.current.CanvasPosition.Y else tbl1.scrollingFrameRef.current.CanvasPosition.X

                connection = tbl1.scrollingFrameRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                    func3()
                end)

                var4.current = tbl1.scrollingFrameRef.current
            end

            return function()
                if var3.current then
                    func1(var6.current)
                    var3.current:Disconnect()

                    if var9.current then
                        local var11 = var1.current - var2.current
                        var9.current(var11)
                    end
                end
                var3.current = nil

                if connection then
                    connection:Disconnect()
                end
                connection = nil

                if not (tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current) then
                    var4.current = nil
                end
            end
        end, { tbl1.scrollingFrameRef })
    else
        local function func1(num1: number) -- Luacid: Inlined by compiler; 5 call sites recovered
            local var10 = var1.current - var2.current
            if var10 == 0 then
                return
            end

            if tbl1.sendScrollEvent then
                tbl1.sendScrollEvent(var10, num1 - var5.current, var2.current)
            end
        end

        local function func2()
            if not (tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current) then
                func1(var6.current)
                if var3.current then
                    var3.current:Disconnect()
                end
                var3.current = nil
                return
            end

            local current = time()
            local var10 = current - var5.current
            local var11

            if tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current then
                if tbl1.scrollingFrameRef.current.ScrollingDirection == Enum.ScrollingDirection.Y then
                    var11 = tbl1.scrollingFrameRef.current.CanvasPosition.Y
                else
                    var11 = tbl1.scrollingFrameRef.current.CanvasPosition.X
                end
            else
                var11 = nil
            end

            local var12 = var1.current - var2.current
            local var13 = var11 - var1.current

            if not var7.current and var13 == 0 then
                var7.current = var6.current
            elseif var7.current and var13 ~= 0 then
                var7.current = nil
            end

            if var7.current and var7.current + getDelaySeconds() < current then
                var1.current = var11
                func1(var7.current)

                if var9.current then
                    local var14 = var1.current - var2.current

                    var9.current(var14)
                end

                var2.current = var11
                local current = var3.current
                if current then
                    current:Disconnect()
                end
                var3.current = nil
                return
            end

            if var12 ~= 0 and var13 ~= 0 and math.sign(var12) ~= math.sign(var13) then
                func1(var6.current)
                var2.current = var1.current
                var5.current = var6.current
            elseif not var7.current and getThresholdSeconds() <= var10 then
                var1.current = var11
                func1(current)
                var2.current = var11
                var5.current = current
            end

            var1.current = var11
            var6.current = current
        end

        local function func3()
            if var3.current then
                return
            end
            var5.current = time()
            var6.current = var5.current
            var2.current = var1.current

            var7.current = nil

            if var8.current then
                var8.current()
            end

            var3.current = RunService.Stepped:Connect(function()
                func2()
            end)
        end

        React.useEffect(function()
            local connection = nil

            if tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current and var4.current ~= tbl1.scrollingFrameRef.current then
                local scrollingDirection = tbl1.scrollingFrameRef.current.ScrollingDirection
                local var10 = var1
                var10.current = if scrollingDirection == Enum.ScrollingDirection.Y then tbl1.scrollingFrameRef.current.CanvasPosition.Y else tbl1.scrollingFrameRef.current.CanvasPosition.X

                connection = tbl1.scrollingFrameRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                    func3()
                end)

                var4.current = tbl1.scrollingFrameRef.current
            end

            return function()
                if var3.current then
                    func1(var6.current)
                    var3.current:Disconnect()

                    if var9.current then
                        local var10 = var1.current - var2.current
                        var9.current(var10)
                    end
                end
                var3.current = nil

                if connection then
                    connection:Disconnect()
                end
                connection = nil

                if not (tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current) then
                    var4.current = nil
                end
            end
        end, { tbl1.scrollingFrameRef })
    end

    return nil
end
