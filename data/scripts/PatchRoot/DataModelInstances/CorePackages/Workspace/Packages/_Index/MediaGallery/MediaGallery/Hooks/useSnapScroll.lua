-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local Otter = require(MediaGalleryParent.Otter)
local React = require(MediaGalleryParent.React)
local _ReactOtter = require(MediaGalleryParent.ReactOtter)
local Signal = require(MediaGalleryParent.AppCommonLib).Signal

local _MediaGalleryTypes = require(MediaGallery.MediaGalleryTypes)

local function useSnapScroll(tbl1)
    local var1, var2 = React.useState(tbl1.targetIndex or 1)

    local var3 = React.useRef(var1)
    var3.current = var1

    local absoluteSizeBinding, var5 = React.useBinding(Vector2.new(0, 0))
    local scrollingFrameRef = React.useRef(nil)
    local var7 = React.useRef(false)
    local var8 = React.useRef(nil)

    local var9 = React.useCallback(function(num1: number): Vector2
        if num1 == 1 then
            return Vector2.new(0, 0)
        end
        local x = absoluteSizeBinding:getValue().X + tbl1.itemPadding
        return Vector2.new(x, 0)
    end, { tbl1.itemPadding })

    local canvasPosition, var11 = React.useBinding(var9(var1))

    React.useEffect(function()
        if absoluteSizeBinding:getValue().X > 0 then
            var11(var9(var1))
        end
    end, { var9, var1 })

    local var12 = React.useRef(Signal.new())

    local scrollInDirection = React.useCallback(function(arg1, bool1: boolean?)
        if var7.current then
            return
        end

        local value = canvasPosition:getValue()
        local x = absoluteSizeBinding:getValue().X + tbl1.itemPadding
        local current = var3.current
        local var13, var14

        if arg1 == "Right" then
            var13 = current + 1
            var14 = value + Vector2.new(x, 0)
        else
            var13 = current - 1
            var14 = value - Vector2.new(x, 0)
        end

        if var13 < 1 or tbl1.itemCount < var13 then
            return
        end

        var7.current = true
        var12.current:fire(var13)

        if var8.current then
            var8.current:destroy()
        end

        local singleMotor = Otter.createSingleMotor(0)
        var8.current = singleMotor

        singleMotor:onStep(function(num1: number)
            var11(value:Lerp(var14, num1))
        end)

        singleMotor:onComplete(function()
            var7.current = false
            var8.current = nil
            var3.current = var13
            var2(var13)

            if tbl1.onScrollComplete then
                tbl1.onScrollComplete(var13, bool1)
            end
        end)

        if tbl1.springConfig then
            singleMotor:setGoal(Otter.spring(1, tbl1.springConfig))
        else
            singleMotor:setGoal(Otter.instant(1))
        end
    end, {
        tbl1.itemCount,
        tbl1.itemPadding,
        tbl1.springConfig,
        tbl1.onScrollComplete,
        canvasPosition
    })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var5(arg1.AbsoluteSize)
        if not var7.current then
            var11(var9(var3.current))
        end
    end, { var9 })

    React.useEffect(function()
        var2(tbl1.targetIndex or 1)
    end, { tbl1.targetIndex })

    React.useEffect(function()
        return function()
            if var8.current then
                var8.current:destroy()
                var8.current = nil
            end
        end
    end, {})

    return {
        currentIndex = var1,
        canvasPosition = canvasPosition,
        scrolledSignal = var12.current,
        scrollingFrameRef = scrollingFrameRef,
        absoluteSizeBinding = absoluteSizeBinding,
        scrollInDirection = scrollInDirection,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
end

return useSnapScroll
