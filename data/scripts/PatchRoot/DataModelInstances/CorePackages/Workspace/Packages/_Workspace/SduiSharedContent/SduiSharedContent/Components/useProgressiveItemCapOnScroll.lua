-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent
local React = require(SduiSharedContentParent.React)

local FFlagSduiProgressiveScrollMathFix = require(SduiSharedContent.Flags.FFlagSduiProgressiveScrollMathFix)

local function itemCountForRowCap(tbl1, num1: number) -- Luacid: Inlined by compiler; 17 call sites recovered
    if num1 <= 0 then
        return 0
    end
    local num2 = 0
    for value, value2 in tbl1 do
        num2 += if value2 > 0 then value2 else 1
        if num1 <= num2 then
            return value
        end
    end
    return #tbl1
end

local function rowCountsEqual(current, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if current == tbl1 then
        return true
    end
    if #current ~= #tbl1 then
        return false
    end
    for i = 1, #current do
        if current[i] ~= tbl1[i] then
            return false
        end
    end
    return true
end

local function useProgressiveItemCapOnScroll(current, num1: number, num2: number, tbl2, tbl3, num3: number, num4: number)
    local num5 = math.max(0, num1)
    local num6 = math.max(1, num2)

    local num7 = 0
    for _, value in current do
        local var1 = if value > 0 then value else 1
        num7 += var1
    end
    local currentLen = #current

    local var1, var2 = React.useState(num5)
    local var3 = if FFlagSduiProgressiveScrollMathFix then React.useRef(0) else nil
    local var4 = if FFlagSduiProgressiveScrollMathFix then React.useRef(false) else nil
    local var5 = if FFlagSduiProgressiveScrollMathFix then React.useRef(current) else nil
    local var6 = itemCountForRowCap(current, math.min(var1, num7))

    if FFlagSduiProgressiveScrollMathFix and currentLen > 0 then
        if currentLen < var3.current then
            var3.current = currentLen
        end
        if var6 < var3.current then
            var6 = var3.current
        else
            var3.current = var6
        end
    end
    local bool1 = var6 < currentLen

    local var7 = React.useRef(nil)

    local var8 = React.useRef(nil)

    React.useEffect(function()
        local var9 = nil

        if FFlagSduiProgressiveScrollMathFix and not rowCountsEqual(var5.current, current) then
            var5.current = current

            if var7.current ~= nil then
                var7.current = nil
                var8.current = nil
                var9 = true
            end
        end

        local current2 = if tbl2 then tbl2.current else nil

        if not bool1 or current2 == nil then
            return nil
        end

        local bool2 = false

        local function readContentHeight() -- Luacid: Inlined by compiler; 15 call sites recovered
            local current2 = if tbl3 then tbl3.current else nil
            return if current2 == nil then nil else current2.AbsoluteContentSize.Y
        end

        local absoluteCanvasSizeY = nil
        local absoluteWindowSizeY = nil
        local absoluteContentSizeY = nil
        if FFlagSduiProgressiveScrollMathFix then
            absoluteCanvasSizeY = current2.AbsoluteCanvasSize.Y
            absoluteWindowSizeY = current2.AbsoluteWindowSize.Y
            local current2 = if tbl3 then tbl3.current else nil

            if current2 ~= nil then
                absoluteContentSizeY = current2.AbsoluteContentSize.Y
            else
                absoluteContentSizeY = nil
            end
        end

        local function showNextBatch() -- Luacid: Inlined by compiler; 7 call sites recovered
            local var10 = var8
            var10.current = if FFlagSduiProgressiveScrollMathFix then absoluteContentSizeY or absoluteCanvasSizeY else readContentHeight() or current2.AbsoluteCanvasSize.Y
            local current2 = if FFlagSduiProgressiveScrollMathFix then var3.current else nil

            var2(function(num9: number): number
                if not FFlagSduiProgressiveScrollMathFix then
                    local num10 = 0

                    for i = 1, itemCountForRowCap(current, math.min(num9, num7)) do
                        local var11 = current[i]
                        num10 += if var11 > 0 then var11 else 1
                    end
                    return math.max(num9 + num6, num10 + 1)
                end

                local var11 = itemCountForRowCap(current, math.min(num9, num7))

                local num10 = math.min(#current, math.max(var11, current2))

                local num11 = if var11 < current2 then num6 else 1
                local num12 = 0
                for i = 1, num10 do
                    local var12 = current[i]
                    num12 += if var12 > 0 then var12 else 1
                end
                return math.max(num9 + num6, num12 + num11)
            end)
        end

        local function showNextBatchIfNearEnd()
            if bool2 then
                return
            end
            if FFlagSduiProgressiveScrollMathFix then
                var4.current = true
            end

            local canvasPositionY = current2.CanvasPosition.Y
            local absoluteCanvasSizeY2, absoluteWindowSizeY2, var10

            if FFlagSduiProgressiveScrollMathFix then
                absoluteCanvasSizeY2 = absoluteCanvasSizeY
                absoluteWindowSizeY2 = absoluteWindowSizeY
                var10 = absoluteContentSizeY or absoluteCanvasSizeY2

                if var10 <= 0 then
                    return
                end
            else
                absoluteCanvasSizeY2 = current2.AbsoluteCanvasSize.Y
                absoluteWindowSizeY2 = current2.AbsoluteWindowSize.Y
                var10 = readContentHeight() or absoluteCanvasSizeY2
            end

            local current2 = var8.current
            if current2 ~= nil and var10 == current2
                or absoluteCanvasSizeY2 - absoluteWindowSizeY2 - canvasPositionY > math.max(0, num3)
            then
                return
            end

            local current3 = var7.current
            if current3 ~= nil and canvasPositionY <= current3 then
                return
            end

            if FFlagSduiProgressiveScrollMathFix then
                var4.current = false
            end
            var7.current = canvasPositionY
            showNextBatch()
        end

        local function decideUnderfill() -- Luacid: unused: defined but never referenced
            if bool2 then
                return
            end

            local var10 = if FFlagSduiProgressiveScrollMathFix then absoluteContentSizeY else readContentHeight()

            if var10 == nil
                or var10 <= 0
                or (if FFlagSduiProgressiveScrollMathFix then absoluteWindowSizeY else current2.AbsoluteWindowSize.Y) <= var10
            then
                return
            end

            local current2 = var8.current
            if current2 ~= nil and var10 == current2 then
                return
            end

            var8.current = var10
            showNextBatch()
        end

        local var10 = nil
        local function scheduleUnderfillDecision() -- Luacid: Inlined by compiler; 4 call sites recovered
            if var10 then
                task.cancel(var10)
            end
            var10 = task.delay(num4 / 1000, function()
                var10 = nil
                if bool2 then
                    return
                end

                if bool2 then
                    return
                end

                local var11 = if FFlagSduiProgressiveScrollMathFix then absoluteContentSizeY else readContentHeight()

                if var11 == nil
                    or var11 <= 0
                    or (if FFlagSduiProgressiveScrollMathFix then absoluteWindowSizeY else current2.AbsoluteWindowSize.Y) <= var11
                then
                    return
                end

                local current2 = var8.current
                if current2 ~= nil and var11 == current2 then
                    return
                end

                var8.current = var11
                showNextBatch()
            end)
        end

        local tbl4

        if FFlagSduiProgressiveScrollMathFix then
            tbl4 = {
                current2:GetPropertyChangedSignal("CanvasPosition"):Connect(showNextBatchIfNearEnd),
                current2:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
                    absoluteCanvasSizeY = current2.AbsoluteCanvasSize.Y

                    if var4.current then
                        showNextBatchIfNearEnd()
                    end

                    scheduleUnderfillDecision()
                end),
                current2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
                    absoluteWindowSizeY = current2.AbsoluteWindowSize.Y
                    local current2 = var7.current

                    if current2 ~= nil and absoluteCanvasSizeY - absoluteWindowSizeY < current2 then
                        var7.current = nil
                        var8.current = nil
                        showNextBatchIfNearEnd()
                    end

                    scheduleUnderfillDecision()
                end)
            }

            local current2_2 = tbl3 and tbl3.current
            if current2_2 ~= nil then
                local tbl5 = tbl4
                local absoluteContentSizeChanged = current2_2:GetPropertyChangedSignal("AbsoluteContentSize")

                table.insert(tbl5, absoluteContentSizeChanged:Connect(function()
                    absoluteContentSizeY = current2_2.AbsoluteContentSize.Y
                    if var4.current then
                        showNextBatchIfNearEnd()
                    end

                    scheduleUnderfillDecision()
                end))
            end
        else
            tbl4 = { current2:GetPropertyChangedSignal("CanvasPosition"):Connect(showNextBatchIfNearEnd), current2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(scheduleUnderfillDecision) }

            if tbl3 ~= nil and tbl3.current ~= nil then
                local tbl5 = tbl4
                table.insert(tbl5, tbl3.current:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(scheduleUnderfillDecision))
            end
        end

        scheduleUnderfillDecision()

        if FFlagSduiProgressiveScrollMathFix and (var9 or var4.current) then
            showNextBatchIfNearEnd()
        end

        return function()
            bool2 = true
            if var10 then
                task.cancel(var10)
            end
            for _, value in tbl4 do
                value:Disconnect()
            end
        end
    end, {
        bool1,
        num6,
        num7,
        tbl2,
        tbl3,
        num3,
        current,
        num4
    })

    return var6, bool1
end

return useProgressiveItemCapOnScroll
