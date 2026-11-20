-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local _PaginationSize = require(Foundation.Enums.PaginationSize)

local useTokens = require(Foundation.Providers.Style.useTokens)

local Wrappers = require(Foundation.Utility.Wrappers)
local Connection = Wrappers.Connection
local Instance = Wrappers.Instance
local Signal = Wrappers.Signal

local _paginationSlotsUtils = require(script.Parent.paginationSlotsUtils)

local function usePaginationAnimatedHighlight(current: string?, arg1, tbl1, str1: string?, tbl2)
    local time100 = useTokens().Time.Time_100

    local highlightPosition, var2 = ReactOtter.useAnimatedBinding(0)

    local highlightWidth, var4 = ReactOtter.useAnimatedBinding(0)

    local activeItemHeight, var6 = React.useBinding(0)
    local isVisible, var8 = React.useBinding(false)

    local var9 = React.useRef(current)
    local var10 = React.useRef(false)
    local var11 = React.useRef(false)
    local var12 = React.useRef(nil)
    local var13 = React.useRef(nil)

    local function resetTransitionState(bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        if var12.current then
            task.cancel(var12.current)
            var12.current = nil
        end
        var10.current = false
        if bool1 then
            var11.current = false
        end
    end

    local var14 = React.useCallback(function()
        if var12.current then
            task.cancel(var12.current)
        end

        var10.current = true
        var12.current = task.delay(time100, function()
            var12.current = nil
            var10.current = false

            if not var11.current then
                return
            end

            var11.current = false
            local current2 = var13.current
            if current2 then
                current2()
            end
        end)
    end, { time100 })

    local updateHighlight = React.useCallback(function(arg2, bool1: boolean?): boolean
        if not (arg2.current and arg1.current) then
            var8(false)
            return false
        end

        local var15 = arg2.current.AbsolutePosition.X - arg1.current.AbsolutePosition.X
        local absoluteSizeX = arg2.current.AbsoluteSize.X
        local absoluteSizeY = arg2.current.AbsoluteSize.Y

        if absoluteSizeX <= 0 or absoluteSizeY <= 0 then
            var8(false)
            return false
        end

        if bool1 and var10.current then
            var11.current = true
            return false
        end

        if bool1 then
            var4(ReactOtter.instant(absoluteSizeX))
            var2(ReactOtter.instant(var15))
        else
            var11.current = false
            var14()
            local tbl3 = {
                easingStyle = Enum.EasingStyle.Linear,
                duration = time100
            }
            var2(ReactOtter.ease(var15, tbl3))
            var4(ReactOtter.ease(absoluteSizeX, tbl3))
        end

        var6(absoluteSizeY)
        var8(true)
        return true
    end, { time100, arg1, var14 })

    local var1 = React.useCallback(function()
        if not current then
            return
        end

        local var16 = tbl1[current]
        if var16 then
            updateHighlight(var16, true)
        end
    end, { current, tbl1, updateHighlight })

    React.useLayoutEffect(function()
        if not current then
            var8(false)
            var9.current = nil

            return
        end

        local var17 = tbl1[current]
        local bool1 = current == var9.current

        if not bool1 then
            resetTransitionState(false)
            var11.current = false
        end

        if var17 and var17.current and arg1.current then
            updateHighlight(var17, bool1)
        else
            var8(false)
        end

        var9.current = current
    end, {
        current,
        tbl1,
        updateHighlight,
        str1,
        tbl2
    })

    React.useEffect(function()
        if current then
            local var17 = tbl1[current]

            if var17 and var17.current and arg1.current then
                local var18 = Signal.Connect(Instance.GetPropertyChangedSignal(var17.current, "AbsoluteSize"), var1)

                local var19 = Signal.Connect(Instance.GetPropertyChangedSignal(var17.current, "AbsolutePosition"), var1)

                local var20 = Signal.Connect(Instance.GetPropertyChangedSignal(arg1.current, "AbsoluteSize"), var1)

                local var21 = Signal.Connect(Instance.GetPropertyChangedSignal(arg1.current, "AbsolutePosition"), var1)

                return function()
                    Connection.Disconnect(var18)
                    Connection.Disconnect(var19)
                    Connection.Disconnect(var20)
                    Connection.Disconnect(var21)
                end
            end
        end

        return function() end
    end, { current, tbl1, var1 })

    React.useEffect(function()
        var13.current = var1
    end, { var1 })

    React.useEffect(function()
        return function()
            if var12.current then
                task.cancel(var12.current)
                var12.current = nil
            end
        end
    end, {})

    return {
        activeItemHeight = activeItemHeight,
        highlightPosition = highlightPosition,
        highlightWidth = highlightWidth,
        isVisible = isVisible,
        updateHighlight = updateHighlight
    }
end

return usePaginationAnimatedHighlight
