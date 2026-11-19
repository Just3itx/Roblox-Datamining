-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Dropdown = require(Foundation.Components.Dropdown)

local function useScrollToSelectedRef(tbl1, id: number)
    local var1 = React.useRef(nil)
    local var2 = React.useCallback(function()
        if not var1.current then
            return
        end

        for _, value in var1.current do
            value:Disconnect()
        end
        var1.current = nil
    end, {})

    local var3 = React.useCallback(function(arg1)
        var2()
        if not arg1 then
            return
        end

        local function scrollToSelected(): boolean
            local num1 = #tbl1
            local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
            local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
            if num1 == 0 or absoluteWindowSizeY <= 0 or absoluteCanvasSizeY <= absoluteWindowSizeY then
                return false
            end
            local var3 = absoluteCanvasSizeY / num1
            local num2 = 0
            for value, value2 in tbl1 do
                if value2.id == id then
                    num2 = value - 1
                    break
                end
            end

            local var4 = num2 * var3 - absoluteWindowSizeY / 2 + var3 / 2
            local var5 = arg1
            var5.CanvasPosition = Vector2.new(0, math.clamp(var4, 0, absoluteCanvasSizeY - absoluteWindowSizeY))
            return true
        end

        if scrollToSelected() then
            return
        end

        local function onSizeChanged()
            if scrollToSelected() then
                var2()
            end
        end
        var1.current = { arg1:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(onSizeChanged), arg1:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(onSizeChanged) }
    end, { tbl1, id, var2 })

    React.useEffect(function()
        return var2
    end, { var2 })

    return var3
end

return useScrollToSelectedRef
