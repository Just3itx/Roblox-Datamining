-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)
local ReactRoblox = require(ChatUIPrimitivesParent.ReactRoblox)
local ReactUtils = require(ChatUIPrimitivesParent.ReactUtils)
local Otter = require(ChatUIPrimitivesParent.Otter)
local useDismissOnEscapeOrMenu = require(ChatUIPrimitives.Hooks.useDismissOnEscapeOrMenu)
local FFlagExpChatExpressionTrayReducedMotion = require(ChatUIPrimitives.Flags.FFlagExpChatExpressionTrayReducedMotion)

local useEventConnection = ReactUtils.useEventConnection

local tbl1 = { dampingRatio = 1, frequency = 3.5 }

local function getSafeInsets()
    local rect = GuiService:GetInsetArea(Enum.ScreenInsets.DeviceSafeInsets)
    local rect2 = GuiService:GetInsetArea(Enum.ScreenInsets.None)
    return {
        left = math.max(0, rect.Min.X - rect2.Min.X),
        right = math.max(0, rect2.Max.X - rect.Max.X),
        bottom = math.max(0, rect2.Max.Y - rect.Max.Y)
    }
end

local function insetsEqual(tbl2, tbl3): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl2.left == tbl3.left and tbl2.right == tbl3.right and tbl2.bottom == tbl3.bottom
end

return React.memo(function(tbl2) -- name: ExpressionSheetView
    local var1 = Foundation.Hooks.useOverlay()
    local reducedMotion = if FFlagExpChatExpressionTrayReducedMotion then Foundation.Hooks.usePreferences().reducedMotion else false

    local isOpen = tbl2.isOpen
    local height = tbl2.height or 240

    local var2, var3 = React.useState(false)
    local var4, var5 = React.useBinding(1)
    local var6 = React.useRef(nil)

    local var7, var8 = React.useState(getSafeInsets)
    local var9 = React.useCallback(function()
        var8(function(arg1)
            local safeInsets = getSafeInsets()
            return if insetsEqual(arg1, safeInsets) then arg1 else safeInsets
        end)
    end, {})
    useEventConnection(if var1 == nil then nil else var1:GetPropertyChangedSignal("AbsoluteSize"), var9)

    local yOffset = height + var7.bottom

    React.useEffect(function()
        if reducedMotion then
            if var6.current then
                var6.current:destroy()
                var6.current = nil
            end
            var5(if isOpen then 0 else 1)
            var3(isOpen)
            return
        end

        if isOpen then
            var3(true)
            if var6.current then
                var6.current:destroy()
            end
            local current = Otter.createSingleMotor(var4:getValue())
            var6.current = current
            current:onStep(var5)
            current:setGoal(Otter.spring(0, tbl1))
        elseif var6.current then
            var6.current:setGoal(Otter.spring(1, tbl1))
            var6.current:onComplete(function()
                var3(false)
            end)
        end
    end, { isOpen, reducedMotion })

    React.useEffect(function()
        return function()
            if var6.current then
                var6.current:destroy()
                var6.current = nil
            end
        end
    end, {})

    useDismissOnEscapeOrMenu(isOpen, tbl2.onPressedOutside)

    if not var2 or var1 == nil then
        return nil
    end

    local createPortal = ReactRoblox.createPortal
    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = { tag = "size-full" }

    local tbl4 = {
        Backdrop = if isOpen then React.createElement("TextButton", {
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 1,
            [React.Event.Activated] = tbl2.onPressedOutside
        }) else nil,
        Tray = React.createElement(Foundation.View, {
            Position = var4:map(function(num1: number)
                return UDim2.new(0.5, 0, 1, math.round(num1 * yOffset))
            end),
            Size = UDim2.new(1, 0, 0, yOffset),
            ZIndex = 2,
            tag = "anchor-bottom-center stroke-standard stroke-default clip bg-surface-200",
            padding = {
                bottom = UDim.new(0, var7.bottom),
                left = UDim.new(0, var7.left),
                right = UDim.new(0, var7.right)
            },
            onActivated = function() end,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            }
        }, {
            Container = tbl2.content
        })
    }

    return createPortal(createElement(view, tbl3, tbl4), var1)
end)
