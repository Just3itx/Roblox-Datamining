-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local ReactRoblox = require(scriptParentParent.ReactRoblox)

local BehaviorKind = require(scriptParent.BehaviorKind)
local Behaviors = require(scriptParent.Behaviors)
local Geometry = require(scriptParent.Geometry)
local _Types = require(scriptParent.Types)

local uDim2 = UDim2.fromScale(0.5, 0.5)

local tbl1 = { bottom = 0, left = 0, right = 0, top = 0 }

local function Window(arg1)
    assert(
        (arg1.behavior or Behaviors.Contained).kind == BehaviorKind.Contained,
        "FloatingWindow only supports Contained behavior"
    )
    local var1 = arg1.boundsInsets or tbl1

    local var2 = React.useRef(nil)
    local var3 = React.useRef(Vector2.zero)
    local var4 = React.useRef(Vector2.zero)
    local var5 = React.useRef(false)
    local var6 = React.useRef(false)
    local var7 = React.useRef(Vector2.zero)
    local var8 = React.useRef(Vector2.zero)

    local var9 = React.useRef(Vector2.zero)
    local var10 = React.useRef(false)
    local var11, var12 = React.useState(false)
    local var13, var14 = React.useBinding(Vector2.zero)

    local var15 = React.useCallback(function()
        local current = var3.current
        local current2 = var4.current
        if not (Geometry.hasPositiveSize(current) and Geometry.hasPositiveSize(current2)) then
            return
        end

        if not var5.current then
            var5.current = true
            local var15 = Geometry.resolveCenter(arg1.initialCenter or uDim2, current)
            var9.current = var15
            local var16 = Geometry.clampCenter(var15, current, current2)
            var14(var16)
            var12(true)
        elseif not var6.current then
            local var15 = Geometry.clampCenter(var9.current, current, current2)
            var14(var15)
        end
    end, { arg1.initialCenter, var14 })

    local var16 = React.useCallback(function(arg2)
        local absoluteSize = arg2.AbsoluteSize
        if absoluteSize == var3.current then
            return
        end
        var3.current = absoluteSize
        var15()
    end, { var15 })

    local var17 = React.useCallback(function(arg2)
        local absoluteSize = arg2.AbsoluteSize
        if absoluteSize == var4.current then
            return
        end
        var4.current = absoluteSize
        var15()
    end, { var15 })

    local var18 = React.useCallback(function(vector2: Vector2)
        if not var6.current then
            return
        end

        local var18 = vector2 - var7.current
        if var18.Magnitude > (arg1.dragThreshold or 25) then
            var10.current = true
        end

        local current = var8.current + var18
        var9.current = current
        local var20 = Geometry.clampCenter(current, var3.current, var4.current)
        var14(var20)
    end, { arg1.dragThreshold, var14 })

    local var19 = React.useCallback(function(_, vector2: Vector2)
        if not var5.current then
            return
        end

        var6.current = true
        var10.current = false
        var7.current = vector2
        var8.current = var13:getValue()
    end, { var13 })

    local var20 = React.useCallback(function(_, vector2: Vector2)
        var18(vector2)
    end, { var18 })

    local var21 = React.useCallback(function(_, vector2: Vector2)
        var18(vector2)
        var6.current = false

        if not var10.current and arg1.onActivated ~= nil then
            arg1.onActivated()
        end
    end, { var13, arg1.onActivated, var18 })

    React.useLayoutEffect(function()
        if arg1.draggable ~= false then
            return
        end
        var6.current = false
        var10.current = false
        var15()
    end, { arg1.draggable, var15 })

    local var22 = var13:map(function(vector2: Vector2): UDim2
        return UDim2.fromOffset(vector2.X, vector2.Y)
    end)
    local element = React.createElement("UIDragDetector", {
        [React.Tag] = if arg1.testId == nil then nil else `data-testid={arg1.testId}-drag-detector`,
        BoundingUI = var2,
        DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
        ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset,
        [React.Event.DragContinue] = var20,
        [React.Event.DragEnd] = var21,
        [React.Event.DragStart] = var19
    })
    if arg1.draggable == false then
        element = nil
    elseif arg1.dragInputTarget ~= nil then
        element = ReactRoblox.createPortal({ DragDetector = element }, arg1.dragInputTarget)
    end

    local createElement = React.createElement
    local str1 = "ScreenGui"
    local tbl2 = {
        [React.Tag] = if arg1.testId == nil then nil else `data-testid={arg1.testId}-screen`,
        DisplayOrder = arg1.displayOrder or 0,
        Enabled = arg1.enabled ~= false,
        Name = "FloatingWindow",
        ResetOnSpawn = false,
        ScreenInsets = arg1.screenInsets or Enum.ScreenInsets.CoreUISafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl3 = { Bounds = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        [React.Change.AbsoluteSize] = var16,
        [React.Tag] = if arg1.testId == nil then nil else `data-testid={arg1.testId}-bounds`,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(var1.left, var1.top),
        ref = var2,
        Size = UDim2.new(1, -(var1.left + var1.right), 1, -(var1.top + var1.bottom))
    }
    local tbl5 = {
        Window = React.createElement("Frame", {
            [React.Change.AbsoluteSize] = var17,
            [React.Tag] = if arg1.testId == nil then nil else `data-testid={arg1.testId}`,
            Active = true,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = var22,
            Size = arg1.size,
            Visible = var11
        }, {
            DragDetector = element,
            Content = arg1.children
        })
    }
    tbl3.Bounds = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return Window
