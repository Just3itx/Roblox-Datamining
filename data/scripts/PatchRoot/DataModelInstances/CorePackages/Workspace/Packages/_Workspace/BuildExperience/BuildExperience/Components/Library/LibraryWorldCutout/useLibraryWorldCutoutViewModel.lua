-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Motion = require(BuildExperienceParent.Motion)
local React = require(BuildExperienceParent.React)

local WorldCutoutTransition = require(script.Parent.WorldCutoutTransition)
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local function toRect(current) -- Luacid: Inlined by compiler; 2 call sites recovered
    if current == nil or current.AbsoluteSize.X <= 1 or current.AbsoluteSize.Y <= 1 then
        return nil
    end
    return Rect.new(current.AbsolutePosition, current.AbsolutePosition + current.AbsoluteSize)
end

local function toUnscrolledRect(current, rect: Rect): Rect | Rect -- Luacid: Inlined by compiler; 1 call site recovered
    local scrollingFrame = current:FindFirstAncestorWhichIsA("ScrollingFrame")
    if scrollingFrame == nil then
        return rect
    end
    return Rect.new(rect.Min + scrollingFrame.CanvasPosition, rect.Max + scrollingFrame.CanvasPosition)
end

local function useLibraryWorldCutoutViewModel(current)
    local var1 = Foundation.Hooks.usePreferences().reducedMotion or UserGameSettings.ReducedMotion
    local var2 = React.useRef(WorldCutoutTransition.initialState)
    local phase, var4 = React.useState(var2.current.phase)
    local isMeasured, var6 = React.useState(false)
    local cell, var8 = React.useBinding(nil)
    local content, var10 = React.useBinding(nil)
    local var11, var3 = Motion.useMotion({ progress = 0 })
    local progress = var11.progress
    local var13 = React.useRef(var3)
    var13.current = var3
    local var14 = React.useRef(current)
    var14.current = current
    local var5 = current.isAvailable and current.isHome and current.isOpen and phase == "Home"
    local var16 = React.useRef(var5)
    var16.current = var5

    local var17 = React.useCallback(function(arg1)
        local current2 = var2.current
        var2.current = WorldCutoutTransition.reduce(current2, arg1)
        if var2.current.phase ~= current2.phase then
            var4(var2.current.phase)
        end
        return var2.current
    end, {})

    local var18 = React.useRef(nil)
    local var19 = React.useRef(nil)
    local var20 = React.useRef(nil)
    local var21 = React.useRef(nil)
    local var22 = React.useCallback(function()
        local var22 = toRect(var20.current)
        if var22 ~= nil then
            var10(var22)
        end
        local current2 = var18.current
        local var23 = toRect(current2)

        if current2 == nil or var23 == nil then
            return
        end
        var8(var23)
        var6(true)
        var19.current = toUnscrolledRect(current2, var23)
        if var16.current then
            var14.current.onViewportRectChanged(var19.current)
        end
    end, { var8, var10 })
    local var23 = React.useCallback(function()
        var22()
        if var21.current == nil then
            var21.current = task.defer(function()
                var21.current = nil
                var22()
            end)
        end
    end, { var22 })
    React.useEffect(function()
        return function()
            if var21.current ~= nil then
                task.cancel(var21.current)
                var21.current = nil
            end
        end
    end, {})

    local onCellRectChanged = React.useCallback(function(current2)
        var18.current = current2
        var23()
    end, { var23 })

    local onContentRectChanged = React.useCallback(function(current2)
        var20.current = current2
        var23()
    end, { var23 })

    local enter = React.useCallback(function(): boolean
        local current2 = var14.current
        local phase = var2.current.phase

        if not current2.isAvailable or not current2.isHome or not current2.isOpen or phase ~= "Home" and phase ~= "Collapsing" then
            return false
        end
        var17({ type = "Expand" })
        return true
    end, { var17 })

    local exit = React.useCallback(function(): boolean
        local phase = var2.current.phase
        if phase ~= "World" and phase ~= "Expanding" then
            return false
        end
        var17({ type = "Collapse" })
        return true
    end, { var17 })

    React.useEffect(function()
        if var5 then
            local current2 = var19.current
            if current2 ~= nil then
                current.onViewportRectChanged(current2)
            end
        elseif current.isAvailable and current.isOpen and phase == "Home" then
            current.onViewportRectChanged(nil)
        end
    end, {
        var5,
        phase,
        current.isAvailable,
        current.isOpen,
        current.onViewportRectChanged,
        cell
    })

    React.useEffect(function()
        if phase ~= "Home" and (not current.isAvailable or not current.isHome or phase == "World" and current.isOpen) then
            var17({ type = "Reset" })
        end
    end, {
        phase,
        current.isAvailable,
        current.isHome,
        current.isOpen,
        var17
    })
    React.useEffect(function()
        local var28 = WorldCutoutTransition.isTransitioning(phase)
        local bool1 = false
        local connection = if var28 then RunService.Heartbeat:Connect(function()
            local var29 = var17({ type = "Progress", progress = progress:getValue() })
            local value = cell:getValue()
            local value2 = content:getValue()
            if WorldCutoutTransition.isTransitioning(var29.phase) and value ~= nil and value2 ~= nil then
                var14.current.onViewportRectChanged(WorldCutoutTransition.interpolateRect(value, value2, var29.progress))
            end
        end) else nil

        var13.current(
            Motion.createState({
                progress = WorldCutoutTransition.getTarget(phase)
            }, {
                default = Motion.transition({ duration = if var1 or not var28 then 0 else 0.3, easingStyle = Enum.EasingStyle.Quad })
            }),
            {
                onAnimationComplete = function(arg1)
                    if arg1 == true and not bool1 and var2.current.phase == phase then
                        var17({ type = "Settle" })
                    end
                end
            }
        )
        return function()
            bool1 = true
            if connection ~= nil then
                connection:Disconnect()
            end
        end
    end, {
        phase,
        var1,
        progress,
        cell,
        content,
        var17
    })
    local hole = React.useMemo(function()
        return React.joinBindings({ progress = progress, cell = cell, content = content }):map(function(tbl1)
            if tbl1.cell == nil or tbl1.content == nil then
                return nil
            end
            local var28 = WorldCutoutTransition.interpolateRect(tbl1.cell, tbl1.content, tbl1.progress)
            local min = tbl1.content.Min
            return Rect.new(var28.Min - min, var28.Max - min)
        end)
    end, { progress, cell, content })

    local var29 = WorldCutoutTransition.isTransitioning(phase)
    return {
        phase = phase,
        isMeasured = isMeasured,
        enter = enter,
        exit = exit,
        onCellRectChanged = onCellRectChanged,
        view = current.isAvailable
            and {
                isTransitioning = var29,
                showHole = var29 or current.isHome and phase == "Home",
                progress = progress,
                hole = hole,
                onContentRectChanged = onContentRectChanged
            }
            or nil
    }
end

return useLibraryWorldCutoutViewModel
