-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)

local FIntScanFrequencyInExperienceShop = require(InExperienceShop.Flags.FIntScanFrequencyInExperienceShop)
local isShopInstanceVisible = require(script.Parent.isShopInstanceVisible)

local function ShopImpressionsDetector(tbl1)
    local var1 = React.useRef(true)
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)

    local var4 = tbl1.scanDebounceSeconds or FIntScanFrequencyInExperienceShop

    local var5 = React.useCallback(function()
        if tbl1.getViewPortBounds then
            return tbl1.getViewPortBounds()
        end
        return tbl1.viewPortBounds
    end, { tbl1.getViewPortBounds, tbl1.viewPortBounds })

    local var6 = React.useCallback(function()
        if not var1.current or tbl1.pageFilter and not tbl1.pageFilter(nil) then
            return
        end

        local var6 = var5()
        if var6 == nil then
            return
        end

        local current = tbl1.parentRef and tbl1.parentRef.current
        if not (current and isShopInstanceVisible(current, var6)) then
            return
        end

        var2.current = tick()
        local tbl2 = {}
        local collectObjectsFunc = tbl1.collectObjectsFunc

        for _, value in if collectObjectsFunc then collectObjectsFunc(current) else current:GetChildren() do
            if value:IsA("GuiObject")
                and isShopInstanceVisible(value, var6)
                and (tbl1.filterImpressionFunc == nil or tbl1.filterImpressionFunc(value))
            then
                table.insert(tbl2, value)
            end
        end

        if #tbl2 > 0 then
            tbl1.onImpressionsDetected(tbl2)
        end
    end, {
        tbl1.parentRef,
        tbl1.pageFilter,
        tbl1.collectObjectsFunc,
        tbl1.filterImpressionFunc,
        tbl1.onImpressionsDetected,
        var5
    })

    local var7 = React.useCallback(function()
        if not var1.current or var3.current ~= nil or not tbl1.parentRef or not tbl1.parentRef.current then
            return
        end

        local current = var2.current
        local var7

        if current == nil then
            var7 = 0
        else
            local var8 = current + var4
            var3.current = var8
            var7 = var8 - tick()
        end

        if not (var7 > 0) then
            var3.current = nil
            var6()
            return
        end

        task.delay(var7, function()
            if not var1.current then
                return
            end
            if var3.current ~= nil and tick() > var3.current then
                var3.current = nil
                var6()
            end
        end)
    end, { tbl1.parentRef, var4, var6 })

    React.useEffect(function()
        var1.current = true
        var7()

        local connection = tbl1.onRequestImpressionsSignal:connect(function()
            var7()
        end)

        return function()
            var1.current = false
            connection:disconnect()
        end
    end, { tbl1.onRequestImpressionsSignal, var7 })

    React.useEffect(function()
        var7()
    end, { var5, var7 })

    return nil
end

return ShopImpressionsDetector
