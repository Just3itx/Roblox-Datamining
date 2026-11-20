-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local SlidingDirection = require(scriptParentParentParentParent.Core.Animation.Enum.SlidingDirection)
local SlidingContainer = require(scriptParentParentParentParent.Core.Animation.SlidingContainer)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local StateTable = require(scriptParentParentParentParent.StateTable.StateTable)
local ButtonType = require(scriptParentParentParent.Button.Enum.ButtonType)

local AnimationState = require(scriptParent.Enum.AnimationState)
local InformativeToast = require(scriptParent.InformativeToast)
local InteractiveToast = require(scriptParent.InteractiveToast)
local ToastContainer = require(scriptParent.ToastContainer)

local var1 = Roact.PureComponent:extend("Toast")

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    duration = t.optional(t.number),
    layoutOrder = t.optional(t.integer),
    position = t.optional(t.UDim2),
    show = t.optional(t.boolean),
    size = t.optional(t.UDim2),
    springOptions = t.optional(t.table),
    toastContent = t.strictInterface({
        buttonText = t.optional(t.string),
        iconColorStyle = t.optional(validateColorInfo),
        iconImage = t.optional(t.union(t.table, t.string, t.callback)),
        iconSize = t.optional(t.Vector2),
        iconChildren = t.optional(t.table),
        onActivated = t.optional(t.callback),
        onAppeared = t.optional(t.callback),
        onDismissed = t.optional(t.callback),
        swipeUpDismiss = t.optional(t.boolean),
        toastSubtitle = t.optional(t.string),
        sequenceNumber = t.optional(t.integer),
        toastTitle = t.string,
        buttonType = t.optional(ButtonType.isEnumValue),
        onTouchSwipeUp = t.optional(t.callback)
    })
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0),
    position = UDim2.new(0.5, 0, 0, 20),
    show = true
}

local function toastContentEqual(toastContent, toastContent2): boolean
    return toastContent.iconColorStyle == toastContent2.iconColorStyle
        and toastContent.iconImage == toastContent2.iconImage
        and toastContent.iconSize == toastContent2.iconSize
        and toastContent.iconChildren == toastContent2.iconChildren
        and toastContent.onActivated == toastContent2.onActivated
        and toastContent.onDismissed == toastContent2.onDismissed
        and toastContent.sequenceNumber == toastContent2.sequenceNumber
        and toastContent.swipeUpDismiss == toastContent2.swipeUpDismiss
        and toastContent.toastSubtitle == toastContent2.toastSubtitle
        and toastContent.toastTitle == toastContent2.toastTitle
end

function var1.init(arg1)
    arg1.isMounted = false

    arg1.currentToastContent = arg1.props.toastContent

    function arg1.onActivated()
        arg1.stateTable.events.Activated({ activated = true })
    end

    function arg1.onAppeared()
        if arg1.currentToastContent.onAppeared then
            arg1.currentToastContent.onAppeared()
        end
        local duration = arg1.props.duration
        if not duration or not (duration > 0) then
            return
        end

        local currentToastContent = arg1.currentToastContent
        delay(duration, function()
            if currentToastContent == arg1.currentToastContent then
                arg1.stateTable.events.AutoDismiss()
            end
        end)
    end

    function arg1.onComplete()
        local duration = arg1.props.duration

        if arg1.state.currentState == AnimationState.Appearing and duration and duration <= 0 then
            arg1.stateTable.events.AutoDismiss()
            return
        end
        arg1.stateTable.events.AnimationComplete()
    end

    function arg1.onDisappeared()
        if arg1.state.context.activated then
            if arg1.currentToastContent.onActivated then
                arg1.currentToastContent.onActivated()
            end
        elseif arg1.currentToastContent.onDismissed then
            arg1.currentToastContent.onDismissed()
        end
    end

    function arg1.onTouchSwipe(_, swipeDirection)
        if swipeDirection ~= Enum.SwipeDirection.Up then
            return
        end

        arg1.stateTable.events.ForceDismiss()
        if arg1.currentToastContent.onTouchSwipeUp then
            arg1.currentToastContent.onTouchSwipeUp()
        end
    end

    function arg1.renderInteractiveToast(arg2)
        return Roact.createElement(InteractiveToast, arg2)
    end

    function arg1.renderInformativeToast(arg2)
        return Roact.createElement(InformativeToast, arg2)
    end

    function arg1.setContext<T>(_, _, arg2: T): T
        return arg2
    end

    function arg1.updateToastContent()
        if arg1.currentToastContent == arg1.props.toastContent then
            return
        end

        arg1.currentToastContent = arg1.props.toastContent
        if arg1.props.show then
            arg1.stateTable.events.ForceAppear({ activated = false })
        end
    end

    local disappeared = AnimationState.Disappeared
    arg1.state = {
        currentState = disappeared,
        context = { activated = false }
    }

    local str1 = string.format("Animated(%s)", tostring(arg1))
    local new = StateTable.new
    local tbl1 = {
        [AnimationState.Appearing] = {
            AnimationComplete = {
                nextState = AnimationState.Appeared,
                action = arg1.onAppeared
            },
            AutoDismiss = {
                nextState = AnimationState.Disappearing,
                action = arg1.onAppeared
            },
            ContentChanged = {
                nextState = AnimationState.Disappearing
            },
            ForceDismiss = {
                nextState = AnimationState.Disappearing
            }
        },
        [AnimationState.Appeared] = {
            Activated = {
                nextState = AnimationState.Disappearing,
                action = arg1.setContext
            },
            AutoDismiss = {
                nextState = AnimationState.Disappearing
            },
            ContentChanged = {
                nextState = AnimationState.Disappearing
            },
            ForceDismiss = {
                nextState = AnimationState.Disappearing
            }
        },
        [AnimationState.Disappearing] = {
            AnimationComplete = {
                nextState = AnimationState.Disappeared,
                action = arg1.onDisappeared
            }
        },
        [AnimationState.Disappeared] = {
            ContentChanged = {
                nextState = AnimationState.Appearing,
                action = arg1.updateToastContent
            },
            ForceAppear = {
                nextState = AnimationState.Appearing,
                action = arg1.setContext
            }
        }
    }
    arg1.stateTable = new(str1, disappeared, {}, tbl1)

    arg1.stateTable:onStateChange(function(arg2, currentState, context)
        if arg1.isMounted and arg2 ~= currentState then
            arg1:setState({ currentState = currentState, context = context })
        end
    end)
end

function var1.isShowing(arg1): boolean
    return arg1.state.currentState == AnimationState.Appearing or arg1.state.currentState == AnimationState.Appeared
end

function var1.render(arg1)
    local onActivated = arg1.currentToastContent.onActivated
    local swipeUpDismiss = arg1.currentToastContent.swipeUpDismiss
    if swipeUpDismiss == nil then
        swipeUpDismiss = true
    end

    return Roact.createElement(SlidingContainer, {
        show = arg1:isShowing(),
        layoutOrder = arg1.props.layoutOrder,
        onComplete = arg1.onComplete,
        slidingDirection = SlidingDirection.Down,
        springOptions = arg1.props.springOptions
    }, {
        ToastContainer = Roact.createElement(ToastContainer, {
            anchorPoint = arg1.props.anchorPoint,
            buttonText = arg1.currentToastContent.buttonText,
            position = arg1.props.position,
            size = arg1.props.size,
            iconColorStyle = arg1.currentToastContent.iconColorStyle,
            iconImage = arg1.currentToastContent.iconImage,
            iconSize = arg1.currentToastContent.iconSize,
            iconChildren = arg1.currentToastContent.iconChildren,
            onActivated = onActivated and arg1.onActivated,
            onTouchSwipe = swipeUpDismiss and arg1.onTouchSwipe,
            renderToast = onActivated and arg1.renderInteractiveToast or arg1.renderInformativeToast,
            toastSubtitle = arg1.currentToastContent.toastSubtitle,
            toastTitle = arg1.currentToastContent.toastTitle,
            buttonType = arg1.currentToastContent.buttonType
        })
    })
end

function var1.didMount(arg1)
    arg1.isMounted = true
    if arg1.props.show then
        arg1.stateTable.events.ForceAppear({ activated = false })
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg2.show ~= arg1.props.show then
        if arg1.props.show then
            arg1.stateTable.events.ForceAppear({ activated = false })
        else
            arg1.stateTable.events.ForceDismiss()
        end
    end
    if not toastContentEqual(arg2.toastContent, arg1.props.toastContent) then
        arg1.stateTable.events.ContentChanged({ activated = false })
    end

    if arg3.currentState ~= arg1.state.currentState and arg1.state.currentState == AnimationState.Disappeared then
        arg1.updateToastContent()
    end
end

return var1
