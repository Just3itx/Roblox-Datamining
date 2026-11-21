-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local React = require(CollectionViewsParent.React)

local function useHorizontalWindowStartIndex(tbl1, arg1, num1: number, bool1: boolean)
    local var1, var2 = React.useState(1)

    local var3 = React.useCallback(function()
        if not bool1 then
            var2(1)
            return
        end

        if tbl1.current == nil then
            return
        end

        local canvasPositionX = tbl1.current.CanvasPosition.X
        local var3 = arg1:getValue().X + num1
        if var3 > 0 then
            var2(math.max(1, math.floor(canvasPositionX / var3)))
            return
        end
        var2(1)
    end, {
        bool1,
        tbl1,
        arg1,
        num1
    })

    React.useEffect(function()
        var3()
    end, { var3 })

    React.useEffect(function()
        if not bool1 then
            return nil
        end
        local tbl2 = {}
        if tbl1.current ~= nil then
            var3()

            local canvasPositionChanged = tbl1.current:GetPropertyChangedSignal("CanvasPosition")
            table.insert(tbl2, canvasPositionChanged:Connect(var3))

            local absoluteCanvasSizeChanged = tbl1.current:GetPropertyChangedSignal("AbsoluteCanvasSize")
            table.insert(tbl2, absoluteCanvasSizeChanged:Connect(var3))
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { tbl1, var3, bool1 })

    return var1
end

return useHorizontalWindowStartIndex
