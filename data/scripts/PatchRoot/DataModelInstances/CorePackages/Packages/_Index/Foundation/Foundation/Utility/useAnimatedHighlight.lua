-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local Flags = require(Foundation.Utility.Flags)
local useTokens = require(Foundation.Providers.Style.useTokens)

local Wrappers = require(Foundation.Utility.Wrappers)
local Connection = Wrappers.Connection
local Instance = Wrappers.Instance
local Signal = Wrappers.Signal

local function useAnimatedHighlight(current, arg1, tbl1, ...)
    local var1 = useTokens()
    local var2 = React.useMemo(function()
        return {
            easingStyle = var1.Ease.StandardOut,
            duration = var1.Time.Time_200
        }
    end, { var1 })

    local var3 = React.useRef(current)
    local var4 = if Flags.FoundationAnimatedHighlightSettling then React.useRef(current) else nil

    local var5 = if Flags.FoundationAnimatedHighlightSettling then React.useCallback(function()
        var4.current = var3.current
    end, {}) else nil

    local useAnimatedBinding = ReactOtter.useAnimatedBinding
    local num1 = 0

    if not Flags.FoundationAnimatedHighlightSettling then
        var5 = nil
    end

    local highlightPosition, var7 = useAnimatedBinding(num1, var5)
    local highlightWidth, var9 = ReactOtter.useAnimatedBinding(0)
    local activeItemHeight, var11 = React.useBinding(0)

    local var12 = React.useCallback(function(arg2, bool1: boolean?)
        if not arg2.current or not arg1.current then
            return
        end

        local var12 = arg2.current.AbsolutePosition.X - arg1.current.AbsolutePosition.X
        local absoluteSizeX = arg2.current.AbsoluteSize.X

        if Flags.FoundationAnimatedHighlightSettling then
            bool1 = current == var4.current
        end
        if bool1 then
            var9((ReactOtter.instant(absoluteSizeX)))
            var7((ReactOtter.instant(var12)))
        else
            var7(ReactOtter.ease(var12, var2))
            var9(ReactOtter.ease(absoluteSizeX, var2))
        end

        var11(arg2.current.AbsoluteSize.Y)
    end, { var2, current })

    React.useEffect(function()
        if current then
            local var13 = tbl1[current]
            local bool1 = current == var3.current
            local function animateHighlight()
                if var13 then
                    var12(var13, bool1)
                end
            end

            if var13 and var13.current and arg1.current then
                local var14 = Signal.Connect(Instance.GetPropertyChangedSignal(var13.current, "AbsoluteSize"), animateHighlight)

                local var15 = Signal.Connect(Instance.GetPropertyChangedSignal(var13.current, "AbsolutePosition"), animateHighlight)

                local var16 = Signal.Connect(Instance.GetPropertyChangedSignal(arg1.current, "AbsoluteSize"), animateHighlight)

                return function()
                    Connection.Disconnect(var14)
                    Connection.Disconnect(var15)
                    Connection.Disconnect(var16)
                end
            end
        end

        return function() end
    end, { current })

    React.useEffect(function()
        if not current then
            return
        end

        local var13 = tbl1[current]
        if var13 and var13.current and arg1.current then
            var12(var13, current == var3.current)
        end
        var3.current = current
    end, { current, ... })

    return {
        activeItemHeight = activeItemHeight,
        highlightPosition = highlightPosition,
        highlightWidth = highlightWidth
    }
end

return useAnimatedHighlight
