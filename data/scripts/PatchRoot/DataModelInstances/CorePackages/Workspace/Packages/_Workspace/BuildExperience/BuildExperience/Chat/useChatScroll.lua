-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local chatScroll = require(script.Parent.chatScroll)

local FFlagBuildExperienceChatAccordionScrollAnchor = require(BuildExperience.Flags.FFlagBuildExperienceChatAccordionScrollAnchor)

local function useChatScroll(bool1: boolean?)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)
    local isAtBottomRef = React.useRef(true)
    local isAtTopRef = React.useRef(true)
    local isNearTopRef = React.useRef(false)
    local var6 = React.useRef(0)
    local var7 = React.useRef(false)
    local var8 = React.useRef(nil)
    local var9 = React.useRef(false)
    local var10 = React.useRef(Vector2.zero)
    local var11 = React.useRef(Vector2.zero)
    local var12 = React.useRef(nil)
    local tbl1 = { current = nil }
    if FFlagBuildExperienceChatAccordionScrollAnchor then
        tbl1 = React.useRef(nil)
    end

    local var13 = React.useRef(nil)

    local var14 = React.useCallback(function()
        local current = isNearTopRef.current
        if current and not var9.current and var8.current ~= nil then
            var8.current()
        end
        var9.current = current
    end, {})

    local var15 = React.useCallback(function()
        local current = var2.current
        if current then
            current.canvasPosition:Disconnect()
            current.canvasSize:Disconnect()
            current.windowSize:Disconnect()
            var2.current = nil
        end
        tbl1.current = nil
        var13.current = nil
        isNearTopRef.current = false
        var9.current = false
    end, {})

    local var16 = React.useCallback(function()
        local current = var1.current
        if not current then
            return
        end

        if bool1 then
            var10.current = current.AbsoluteCanvasSize
            var11.current = current.AbsoluteWindowSize
        end
        var6.current = chatScroll.getDistanceFromBottom(current)
        var13.current = Vector2.new(current.AbsoluteCanvasSize.Y, current.AbsoluteWindowSize.Y)
        isAtBottomRef.current = chatScroll.isScrolledToBottom(current)
        isAtTopRef.current = chatScroll.isScrolledToTop(current)
        isNearTopRef.current = chatScroll.isScrolledNearTop(current)
    end, { bool1 })

    local var17 = React.useCallback(function()
        local current = var1.current
        if current ~= nil then
            local current2 = var13.current
            if current2 ~= nil and (current2.X ~= current.AbsoluteCanvasSize.Y or current2.Y ~= current.AbsoluteWindowSize.Y) then
                return
            end
        end
        local bool2 = bool1

        if bool2 then
            if current == nil then
                bool2 = false
            else
                bool2 = current.AbsoluteCanvasSize ~= var10.current or current.AbsoluteWindowSize ~= var11.current
            end
        end
        local bool3 = bool1

        if bool3 then
            if current == nil then
                bool3 = false
            else
                bool3 = current.CanvasPosition == var12.current
            end
        end

        local current2 = tbl1.current

        if FFlagBuildExperienceChatAccordionScrollAnchor
            and current2 ~= nil
            and current ~= nil
            and math.abs(current.CanvasPosition.Y - current2.canvasPositionY) > 0.5
        then
            tbl1.current = nil
        end
        var16()
        if var7.current and not (isAtBottomRef.current or bool2 or bool3) then
            var7.current = false
        end
        var14()
    end, { var14, var16, bool1 })

    local isViewportUnderfilled = React.useCallback(function(): boolean
        local current = var1.current
        return not (current == nil) and current.AbsoluteCanvasSize.Y <= current.AbsoluteWindowSize.Y
    end, {})

    local var19 = React.useCallback(function(arg1): boolean
        local current = tbl1.current
        if current == nil then
            return false
        elseif not current.instance:IsDescendantOf(arg1) then
            tbl1.current = nil
            return false
        else
            local var19 = chatScroll.getOffsetInViewport(arg1, current.instance) - current.offsetY
            if var19 == 0 then
                return true
            end
            local y = arg1.CanvasPosition.Y + var19
            local bottomCanvasPosition = chatScroll.getBottomCanvasPosition(arg1)
            if y < 0 or bottomCanvasPosition < y then
                tbl1.current = nil
                arg1.CanvasPosition = Vector2.new(0, math.clamp(y, 0, bottomCanvasPosition))
                return true
            end

            current.canvasPositionY = y
            arg1.CanvasPosition = Vector2.new(0, y)
            return true
        end
    end, {})

    local var20 = React.useCallback(function()
        local current = var1.current
        if not current then
            return
        end

        if not (FFlagBuildExperienceChatAccordionScrollAnchor and var19(current)) then
            chatScroll.syncScrollFromBottom(current, var6.current)
        end
        var16()
    end, { var19, var16 })

    local var21 = React.useCallback(function()
        local current = var1.current
        if not current then
            return
        end

        current.CanvasPosition = Vector2.new(0, 2 ^ 53)
        if bool1 then
            var12.current = current.CanvasPosition
            var16()
        end
    end, { bool1, var16 })

    local scrollToBottomIfNeeded = React.useCallback(function()
        if isAtBottomRef.current then
            var20()
        end
    end, { var20 })

    local captureDistanceFromBottom = React.useCallback(function()
        var16()
    end, { var16 })

    local setScrollingFrame = React.useCallback(function(current)
        if var1.current == current then
            return
        end

        var15()
        var1.current = current

        if not current then
            return
        end

        if var7.current then
            var21()
        else
            var16()
            var20()
            task.defer(var20)
        end

        local function onScrollViewportChanged() -- Luacid: Inlined by compiler; 1 call site recovered
            if var7.current then
                var21()
            else
                var20()
                task.defer(var20)
            end
            var16()
            var14()
        end

        local func1 = FFlagBuildExperienceChatAccordionScrollAnchor and function()
            tbl1.current = nil
            onScrollViewportChanged()
        end or onScrollViewportChanged

        var2.current = {
            canvasPosition = current:GetPropertyChangedSignal("CanvasPosition"):Connect(var17),
            canvasSize = current:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(onScrollViewportChanged),
            windowSize = current:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(func1)
        }
        var14()
    end, {
        var15,
        var21,
        var20,
        var14,
        var16,
        var17
    })

    local anchorToInstance = React.useCallback(function(instance)
        local current = var1.current
        if current == nil or instance == nil or not instance:IsDescendantOf(current) then
            return
        end
        var7.current = false
        local tbl2 = {
            instance = instance,
            offsetY = chatScroll.getOffsetInViewport(current, instance),
            canvasPositionY = current.CanvasPosition.Y
        }
        tbl1.current = tbl2
        task.delay(0.25, function()
            if tbl1.current == tbl2 then
                tbl1.current = nil
            end
        end)
    end, {})

    local lockToBottom = React.useCallback(function()
        tbl1.current = nil
        var6.current = 0
        isAtBottomRef.current = true
        var7.current = true
        var21()
    end, { var21 })

    local captureStickToBottomForSend = React.useCallback(function()
        var16()
    end, { var16 })

    local scrollToBottomAfterSend = React.useCallback(function()
        if isAtBottomRef.current then
            tbl1.current = nil
            var6.current = 0
            var20()
        end
    end, { var20 })

    local scrollToBottomUnconditionally = React.useCallback(function()
        tbl1.current = nil
        var6.current = 0
        isAtBottomRef.current = true
        var20()
        task.defer(var20)
    end, { var20 })

    local setOnScrolledToTop = React.useCallback(function(current: ((...any) -> (...any))?)
        var8.current = current
        var9.current = false
        task.defer(var14)
    end, { var14 })

    React.useEffect(function()
        return var15
    end, { var15 })

    return React.useMemo(function()
        return {
            setScrollingFrame = setScrollingFrame,
            anchorToInstance = anchorToInstance,
            lockToBottom = lockToBottom,
            scrollToBottomIfNeeded = scrollToBottomIfNeeded,
            captureDistanceFromBottom = captureDistanceFromBottom,
            captureStickToBottomForSend = captureStickToBottomForSend,
            scrollToBottomAfterSend = scrollToBottomAfterSend,
            scrollToBottomUnconditionally = scrollToBottomUnconditionally,
            isViewportUnderfilled = isViewportUnderfilled,
            isAtBottomRef = isAtBottomRef,
            isAtTopRef = isAtTopRef,
            isNearTopRef = isNearTopRef,
            setOnScrolledToTop = setOnScrolledToTop
        }
    end, {
        setScrollingFrame,
        anchorToInstance,
        lockToBottom,
        scrollToBottomIfNeeded,
        captureDistanceFromBottom,
        captureStickToBottomForSend,
        scrollToBottomAfterSend,
        scrollToBottomUnconditionally,
        isViewportUnderfilled,
        setOnScrolledToTop
    })
end

return useChatScroll
