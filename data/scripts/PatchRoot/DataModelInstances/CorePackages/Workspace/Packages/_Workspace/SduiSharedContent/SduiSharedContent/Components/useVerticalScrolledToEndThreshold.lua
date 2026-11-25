-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local React = require(SduiSharedContentParent.React)

local bool1 = game:DefineFastFlag("SduiFeedCacheScrollExtents", false)

local function useVerticalScrolledToEndThreshold(tbl1, num1: number?, current: ((...any) -> (...any))?)
    local var1 = React.useRef(false)
    local var2 = React.useRef(current)
    var2.current = current
    if current == nil then
        num1 = nil
    end

    React.useEffect(function()
        if num1 == nil or tbl1.current == nil then
            return nil
        end

        local tbl2 = {}
        local current2 = tbl1.current
        local func1

        if bool1 then
            local absoluteCanvasSizeY = current2.AbsoluteCanvasSize.Y
            local absoluteWindowSizeY = current2.AbsoluteWindowSize.Y

            local function refreshSizes() -- Luacid: Inlined by compiler; 1 call site recovered
                absoluteCanvasSizeY = current2.AbsoluteCanvasSize.Y
                absoluteWindowSizeY = current2.AbsoluteWindowSize.Y
            end

            local function evaluateThreshold() -- Luacid: Inlined by compiler; 1 call site recovered
                local var3 = absoluteCanvasSizeY - absoluteWindowSizeY - num1
                local canvasPositionY = current2.CanvasPosition.Y
                if canvasPositionY < var3 and var1.current then
                    var1.current = false
                elseif var3 < canvasPositionY and not var1.current then
                    var1.current = true
                    if var2.current then
                        var2.current()
                    end
                end
            end

            local function refreshSizesAndEvaluate()
                refreshSizes()
                evaluateThreshold()
            end

            local absoluteWindowSizeChanged = current2:GetPropertyChangedSignal("AbsoluteWindowSize")
            table.insert(tbl2, absoluteWindowSizeChanged:Connect(refreshSizesAndEvaluate))

            local absoluteCanvasSizeChanged = current2:GetPropertyChangedSignal("AbsoluteCanvasSize")
            table.insert(tbl2, absoluteCanvasSizeChanged:Connect(refreshSizesAndEvaluate))

            local canvasPositionChanged = current2:GetPropertyChangedSignal("CanvasPosition")
            table.insert(tbl2, canvasPositionChanged:Connect(evaluateThreshold))

            func1 = refreshSizesAndEvaluate
        else
            local function checkThreshold()
                local var3 = current2.AbsoluteCanvasSize.Y - current2.AbsoluteWindowSize.Y - num1
                local canvasPositionY = current2.CanvasPosition.Y
                if canvasPositionY < var3 and var1.current then
                    var1.current = false
                elseif var3 < canvasPositionY and not var1.current then
                    var1.current = true
                    if var2.current then
                        var2.current()
                    end
                end
            end

            local absoluteWindowSizeChanged = current2:GetPropertyChangedSignal("AbsoluteWindowSize")
            table.insert(tbl2, absoluteWindowSizeChanged:Connect(checkThreshold))

            local absoluteCanvasSizeChanged = current2:GetPropertyChangedSignal("AbsoluteCanvasSize")
            table.insert(tbl2, absoluteCanvasSizeChanged:Connect(checkThreshold))

            local canvasPositionChanged = current2:GetPropertyChangedSignal("CanvasPosition")
            table.insert(tbl2, canvasPositionChanged:Connect(checkThreshold))

            func1 = checkThreshold
        end

        local bool2 = false
        task.defer(function()
            if not bool2 then
                func1()
            end
        end)

        return function()
            bool2 = true
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { tbl1, num1 })
end

return useVerticalScrolledToEndThreshold
