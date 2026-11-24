-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local ReactOtter = require(GenericAbuseReportingParent.ReactOtter)

local SlideTransitionContext = require(GenericAbuseReporting.BeduiV2.Components.SlideTransitionContext)
local View = Foundation.View

local tbl1 = {
    stiffness = 400,
    damping = 40,
    mass = 1,
    restingPositionLimit = 0.5,
    restingVelocityLimit = 0.1
}

local tbl2 = { inExpChatSelection = true, inExpSceneSelection = true }

local function SlidePane(tbl3)
    local createElement = React.createElement
    local var1 = View
    local tbl4 = {
        tag = "size-full",
        Position = tbl3.position,
        testId = if tbl3.withInputSink then "SlideTransitionOutgoing" else "SlideTransitionIncoming"
    }
    local tbl5 = {
        Content = React.createElement(View, { tag = "col size-full" }, { Page = tbl3.content }),
        InputSink = if tbl3.withInputSink then React.createElement("TextButton", {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0, 0),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            Selectable = false,
            Active = true,
            ZIndex = 100,
            [React.Tag] = "data-testid=SlideTransitionInputSink"
        }) else nil
    }
    return createElement(var1, tbl4, tbl5)
end

return React.memo(function(tbl3) -- name: SlideTransition
    local var1 = tbl2[tbl3.nodeType] or false

    local var2, var3 = React.useState(false)
    local value, var5 = React.useBinding(false)

    local var6 = React.useRef({
        prevNodeId = nil,
        prevContent = nil,
        outgoing = nil,
        direction = "forward",
        needsAnimationStart = false,
        needsAnimationCancel = false,
        transitionId = 0,
        springId = 0
    })

    local var7 = React.useCallback(function()
        local current = var6.current
        if current.springId ~= current.transitionId then
            return
        end
        current.outgoing = nil
        var3(false)
        var5(false)
    end, {})

    local var8, var9 = ReactOtter.useAnimatedBinding(1, var7)

    local current = var6.current

    if current.prevNodeId ~= nil and current.prevNodeId ~= tbl3.nodeId then
        local bool1 = tbl3.direction ~= nil
        if not var1 and current.prevContent and bool1 then
            current.outgoing = {
                nodeId = current.prevNodeId,
                content = current.prevContent
            }
            current.direction = tbl3.direction or "forward"
            current.needsAnimationStart = true
            current.needsAnimationCancel = false

            current.transitionId += 1
            current.springId = -1
        elseif not bool1 then
            current.outgoing = nil
            current.needsAnimationStart = false
            current.transitionId += 1
            current.springId = -1
            if var2 then
                current.needsAnimationCancel = true
            end
        end
    end

    if not var1 then
        current.prevNodeId = tbl3.nodeId
        current.prevContent = tbl3.nodeContent
    end

    React.useLayoutEffect(function()
        local current2 = var6.current
        if current2.needsAnimationCancel then
            current2.needsAnimationCancel = false
            var3(false)
            var5(false)
        end
        if not current2.needsAnimationStart then
            return
        end

        current2.needsAnimationStart = false
        current2.springId = current2.transitionId
        var3(true)
        var5(true)
        local var10 = table.clone(tbl1)
        var10.startingValue = 0
        var9(ReactOtter.spring(1, var10))
    end, { tbl3.nodeId })

    local tbl4 = {}

    local bool1 = current.outgoing ~= nil
    local var10 = bool1 and (current.needsAnimationStart or not var2)

    if current.outgoing then
        local position = if var10 then UDim2.new(0, 0, 0, 0) else var8:map(function(num1: number): UDim2
            local num2 = if var6.current.direction == "forward" then -1 else 1
            return UDim2.new(num1 * num2, 0, 0, 0)
        end)

        tbl4[current.outgoing.nodeId] = React.createElement(SlidePane, { content = current.outgoing.content, position = position, withInputSink = true })
    end

    local var11

    if var10 then
        local xScale = if current.direction == "forward" then 1 else -1
        var11 = UDim2.new(xScale, 0, 0, 0)
    elseif bool1 then
        var11 = var8:map(function(num1: number): UDim2
            local num2 = if var6.current.direction == "forward" then 1 else -1
            return UDim2.new((1 - num1) * num2, 0, 0, 0)
        end)
    else
        var11 = nil
    end

    tbl4[tbl3.nodeId] = React.createElement(SlidePane, { content = tbl3.nodeContent, position = var11, withInputSink = false })

    return React.createElement(
        SlideTransitionContext.Provider,
        { value = value },
        React.createElement(View, { tag = "fill size-full-0", ClipsDescendants = true }, tbl4)
    )
end)
