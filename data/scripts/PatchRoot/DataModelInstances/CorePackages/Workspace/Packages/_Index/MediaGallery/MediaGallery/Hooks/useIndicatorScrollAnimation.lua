-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local Otter = require(MediaGalleryParent.Otter)
local React = require(MediaGalleryParent.React)
local _ReactOtter = require(MediaGalleryParent.ReactOtter)
local _AppCommonLib = require(MediaGalleryParent.AppCommonLib)

local MAX_VISIBLE_INDICATORS = require(MediaGallery.MediaGalleryConstants).MAX_VISIBLE_INDICATORS

local function getFirstVisibleIndex(numberOfItems: number, num1: number, str1: string): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if numberOfItems <= MAX_VISIBLE_INDICATORS then
        return 1
    elseif str1 == "Right" then
        return math.max(1, math.min(num1, numberOfItems - 2) - MAX_VISIBLE_INDICATORS + 2 + 1)
    end
    return math.min(numberOfItems - MAX_VISIBLE_INDICATORS + 1, math.max(num1, 3) - 2)
end

local function useIndicatorScrollAnimation(tbl1)
    local currentItemIndex, var2 = React.useState(tbl1.startIndex)
    local previousItemIndex, var4 = React.useState(tbl1.startIndex)
    local firstVisibleIndex, var6 = React.useState(1)

    local canvasPositionBinding, var8 = React.useBinding(Vector2.new(0, 0))
    local var9, var10 = React.useState(false)
    local animationProgressBinding, var12 = React.useBinding(0)

    local var13 = React.useCallback(function(num1: number): Vector2
        return Vector2.new((num1 - 1) * (tbl1.indicatorSize + tbl1.indicatorPadding), 0)
    end, { tbl1.indicatorSize, tbl1.indicatorPadding })

    React.useEffect(function()
        local firstVisibleIndex = getFirstVisibleIndex(tbl1.numberOfItems, tbl1.startIndex, "Right")

        var8(var13(firstVisibleIndex))
        var6(firstVisibleIndex)
        var12(1)
        var4(tbl1.startIndex)
        var2(tbl1.startIndex)
    end, { tbl1.numberOfItems, tbl1.startIndex, var13 })

    React.useEffect(function()
        local connection = tbl1.scrolledSignal:connect(function(num1: number)
            var2(function(arg1)
                local str1 = if arg1 < num1 then "Right" else "Left"
                var4(arg1)
                var6((getFirstVisibleIndex(tbl1.numberOfItems, num1, str1)))
                var10(true)
                return num1
            end)
        end)

        return function()
            if connection ~= nil then
                connection:disconnect()
                connection = nil
            end
        end
    end, { tbl1.numberOfItems, tbl1.scrolledSignal })

    React.useEffect(function()
        if not var9 then
            return
        end

        local singleMotor = Otter.createSingleMotor(0)
        local var14 = if tbl1.useSpring then Otter.spring(1, tbl1.springConfig) else Otter.instant(1)
        singleMotor:setGoal(var14)

        local value = canvasPositionBinding:getValue()
        local var15 = var13(firstVisibleIndex)

        singleMotor:onStep(function(num1: number)
            var12(num1)
            var8(value:Lerp(var15, num1))
        end)

        singleMotor:onComplete(function()
            var10(false)
        end)

        return function()
            singleMotor:destroy()
        end
    end, {
        tbl1.useSpring,
        tbl1.springConfig,
        var9,
        firstVisibleIndex,
        var13
    })

    return {
        currentItemIndex = currentItemIndex,
        previousItemIndex = previousItemIndex,
        firstVisibleIndex = firstVisibleIndex,
        animationProgressBinding = animationProgressBinding,
        canvasPositionBinding = canvasPositionBinding
    }
end

return useIndicatorScrollAnimation
