-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local React = require(CollectionViewsParent.React)

local function useHorizontalScrolledToEndThreshold(tbl1, num1: number?, callback: ((...any) -> (...any))?, bool1: boolean)
    local var1 = React.useRef(false)

    React.useEffect(function()
        if not bool1 then
            return nil
        end

        local tbl2 = {}

        if tbl1.current ~= nil and callback ~= nil and num1 ~= nil then
            local current = tbl1.current

            local function checkThreshold() -- Luacid: Inlined by compiler; 4 call sites recovered
                local var2 = current.AbsoluteCanvasSize.X - current.AbsoluteWindowSize.X - num1
                local canvasPositionX = current.CanvasPosition.X
                if canvasPositionX < var2 and var1.current then
                    var1.current = false
                elseif var2 < canvasPositionX and not var1.current then
                    var1.current = true
                    callback()
                end
            end

            local absoluteWindowSizeChanged = current:GetPropertyChangedSignal("AbsoluteWindowSize")

            table.insert(tbl2, absoluteWindowSizeChanged:Connect(function()
                checkThreshold()
            end))

            local absoluteCanvasSizeChanged = current:GetPropertyChangedSignal("AbsoluteCanvasSize")

            table.insert(tbl2, absoluteCanvasSizeChanged:Connect(function()
                checkThreshold()
            end))

            local canvasPositionChanged = current:GetPropertyChangedSignal("CanvasPosition")

            table.insert(tbl2, canvasPositionChanged:Connect(function()
                checkThreshold()
            end))

            checkThreshold()
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, {
        tbl1,
        bool1,
        num1,
        callback
    })
end

return useHorizontalScrolledToEndThreshold
