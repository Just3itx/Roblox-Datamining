-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)

local function useUniformItemHeight(bool1: boolean)
    local var1 = React.useRef({})
    local var2 = React.useRef(false)
    local var3 = React.useRef(0)

    local var4, var5 = React.useState(nil)
    local var6, var7 = React.useBinding(nil)

    local var8 = React.useCallback(function(num1: number, arg1)
        if not bool1 then
            return
        end

        local absoluteSizeX = arg1.AbsoluteSize.X
        local absoluteSizeY = arg1.AbsoluteSize.Y

        if var3.current > 0 and math.abs(absoluteSizeX - var3.current) > 1 then
            var3.current = absoluteSizeX
            var1.current = {}
            var5(nil)
            var7(nil)
            return
        end
        var3.current = absoluteSizeX

        if absoluteSizeY <= 0 or var1.current[num1] == absoluteSizeY then
            return
        end
        var1.current[num1] = absoluteSizeY

        if var2.current then
            return
        end

        var2.current = true
        task.defer(function()
            var2.current = false
            local num2 = 0
            for _, value in var1.current do
                num2 = math.max(num2, value)
            end
            if num2 > 0 then
                var7(num2)
                var5(num2)
            end
        end)
    end, { bool1 })

    local tbl1 = { measuredMaxHeight = 0, measuredMaxHeightBinding = 0, onItemSizeChanged = 0 }
    if not bool1 then
        var4 = nil
    end

    tbl1.measuredMaxHeight = var4
    if not bool1 then
        var6 = nil
    end

    tbl1.measuredMaxHeightBinding = var6
    if not bool1 then
        var8 = nil
    end

    tbl1.onItemSizeChanged = var8
    return tbl1
end

return useUniformItemHeight
