-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local React = require(AppPageShellParent.React)
local Foundation = require(AppPageShellParent.Foundation)
local Otter = require(AppPageShellParent.Otter)
local RobloxAppEvents = require(AppPageShellParent.RobloxAppEvents)
local scrollToTop = require(AppPageShell.scrollToTop)

local View = Foundation.View
local Icon = Foundation.Icon

local FFlagAppPageShellScrollToTopFocus = require(AppPageShellParent.SharedFlags).FFlagAppPageShellScrollToTopFocus

return React.memo(function(tbl1) -- name: PullToRefreshSpinner
    local var1, var2 = React.useBinding(0)

    local var3, var4 = React.useBinding(0)

    local var5, var6 = React.useBinding(0)

    local var7, var8 = React.useBinding(0)

    local var9, var10 = React.useState("idle")
    local var11 = React.useRef("idle")
    local var12 = React.useRef(0)
    local var13 = React.useRef(0)

    local var14 = React.useRef(nil)
    if var14.current == nil then
        var14.current = Otter.createSingleMotor(0)
    end

    React.useEffect(function()
        local current = var14.current

        local var15 = current:onStep(function(arg1)
            var4(arg1)
        end)
        local var16 = current:onComplete(function()
            if var11.current ~= "tweenBack" then
                return
            end
            var11.current = "idle"
            var10("idle")
            var4(0)
        end)

        return function()
            var15()
            var16()
            current:destroy()
        end
    end, {})

    local var15 = React.useCallback(function()
        if not tbl1.onRefresh or var11.current ~= "idle" then
            return
        end

        var11.current = "refreshing"
        var10("refreshing")

        if var13.current >= -52 then
            var14.current:setGoal(Otter.spring(52, { dampingRatio = 0.735, frequency = 1.95 }))
        else
            var4(52)
        end

        local function onSettled()
            var11.current = "tweenBack"
            var10("tweenBack")
            var8(0)

            var14.current:setGoal(Otter.spring(0, { dampingRatio = 0.735, frequency = 1.95, startingValue = 52 }))
        end

        local success, result = pcall(tbl1.onRefresh)
        if not success then
            onSettled()
            return
        end

        if result and typeof(result) == "table" and result.andThen then
            result:finally(onSettled)
        else
            onSettled()
        end
    end, { tbl1.onRefresh })

    React.useEffect(function()
        if not tbl1.appEventName then
            return nil
        end

        local connection = RobloxAppEvents.ReloadPage:connect(function(appEventName)
            if appEventName ~= tbl1.appEventName then
                return
            end
            local current = tbl1.scrollingFrameRef.current
            if not current then
                return
            end

            if current.CanvasPosition.Y == 0 then
                var15()
                return
            end

            if FFlagAppPageShellScrollToTopFocus then
                scrollToTop(current)
                return
            end
            current:ScrollToTop()
        end)

        return function()
            connection:disconnect()
        end
    end, { var15, tbl1.appEventName, tbl1.scrollingFrameRef })

    if FFlagAppPageShellScrollToTopFocus then
        React.useEffect(function()
            local connection = UserInputService.StatusBarTapped:Connect(function()
                local current = tbl1.scrollingFrameRef.current
                if current then
                    scrollToTop(current)
                end
            end)

            return function()
                connection:Disconnect()
            end
        end, { tbl1.scrollingFrameRef })
    end

    React.useEffect(function()
        local connection = UserInputService.InputBegan:Connect(function(input: InputObject)
            if input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            local var16 = var12
            var16.current += 1
        end)

        local connection2 = UserInputService.InputEnded:Connect(function(input: InputObject)
            if input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            if var12.current > 0 then
                local var16 = var12
                var16.current -= 1
            end

            if var12.current > 0 then
                return
            end

            if var13.current < -52 and var11.current == "idle" then
                var15()
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var15 })

    React.useEffect(function()
        local current = tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current
        if not current then
            return nil
        end

        local connection = current:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if not tbl1.onRefresh then
                return
            end
            local canvasPositionY = current.CanvasPosition.Y
            var13.current = canvasPositionY
            var2(if canvasPositionY < 0 then canvasPositionY else 0)
        end)

        return function()
            connection:Disconnect()
        end
    end, { tbl1.scrollingFrameRef, tbl1.onRefresh })

    React.useEffect(function()
        if var9 == "idle" then
            return nil
        end

        local num1 = 0
        local connection = RunService.RenderStepped:Connect(function(deltaTime: number)
            num1 += deltaTime
            if var11.current == "refreshing" then
                var6(num1 * 540)
            elseif var11.current == "tweenBack" then
                var8(num1)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { var9 })

    local var16 = React.useMemo(function()
        return React.joinBindings({ var1, var3 }):map(function(arg1)
            local var16 = arg1[1]
            local yOffset = arg1[2]

            if var11.current == "idle" then
                if var12.current == 0 or var16 >= 0 then
                    return UDim2.new(1, 0, 0, 0)
                end
                return UDim2.new(1, 0, 0, math.min(52, math.abs(var16)))
            elseif var11.current == "refreshing" then
                return UDim2.new(1, 0, 0, math.max(yOffset, 0))
            else
                return UDim2.new(1, 0, 0, yOffset)
            end
        end)
    end, {})

    local rotation = React.useMemo(function()
        return React.joinBindings({ var1, var5 }):map(function(arg1)
            local var17 = arg1[1]
            local var18 = arg1[2]

            if var11.current == "idle" then
                if var17 >= 0 or var17 <= -52 then
                    return 0
                end

                return math.abs(var17) * 9.6 - 240
            elseif var11.current == "refreshing" then
                return var18
            end

            return 0
        end)
    end, {})

    local groupTransparency = React.useMemo(function()
        return React.joinBindings({ var1, var3, var7 }):map(function(arg1): number
            local var18 = arg1[1]
            local var19 = arg1[2]
            local var20 = arg1[3]

            if var11.current == "idle" then
                if var12.current == 0 or var18 >= 0 then
                    return 1
                end

                if var18 <= -52 then
                    return 0
                end

                return 1 - math.abs(var18) * 0.04
            end

            if var11.current ~= "refreshing" then
                return math.min(1, 2 * var20)
            end

            if not (var19 < 52) then
                return 0
            end

            return math.max(0, 1 - var19 / 52)
        end)
    end, {})

    return React.createElement(View, {
        Size = var16,
        GroupTransparency = groupTransparency,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        ZIndex = 2
    }, {
        Spinner = React.createElement(Icon, {
            name = "two-arrows-spin-clockwise",
            Rotation = rotation,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5)
        })
    })
end)
