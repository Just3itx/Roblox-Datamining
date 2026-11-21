-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
local React = require(GamePlayButtonParent.React)
local SignalsReact = require(GamePlayButtonParent.SignalsReact)
local Foundation = require(GamePlayButtonParent.Foundation)
local FocusNavigationUtils = require(GamePlayButtonParent.FocusNavigationUtils)
local InputHandlers = require(GamePlayButtonParent.InputHandlers)
local PopForcePickerModel = require(script.Parent.PopForcePickerModel)
local PopForcePickerStore = require(script.Parent.PopForcePickerStore)
local PopForcePickerView = require(script.Parent.PopForcePickerView)

local NavigateBack = FocusNavigationUtils.FocusNavigationEventNameEnum.NavigateBack
local eventMap = {
    [Enum.KeyCode.ButtonB] = NavigateBack,
    [Enum.KeyCode.Escape] = NavigateBack
}

return React.memo(function(tbl2) -- name: PopForcePicker
    local var1 = React.useMemo(function()
        local store = tbl2.store

        if not store then
            if tbl2.getService then
                return (PopForcePickerStore.createStore(tbl2.getService))
            end

            store = PopForcePickerStore.getStore(false)
        end

        return store
    end, { tbl2.store, tbl2.getService })
    local forcedPop = SignalsReact.useSignalState(var1.getSelection)
    local var3 = SignalsReact.useSignalState(var1.getSupported)
    local anchorRef = React.useRef(nil)
    local isOpen, var6 = React.useState(false)
    local showAll, var8 = React.useState(false)
    local var9, var10 = React.useState({})
    local errorText, var12 = React.useState(nil)
    local tokens = Foundation.Hooks.useTokens()
    local var14 = Foundation.Hooks.useOverlay()
    local var15, var16 = React.useState(Vector2.new(1024, 768))
    local var17, var18 = React.useState(0)
    local onCanvasSizeChanged = React.useCallback(function(arg1)
        var18(arg1.AbsoluteCanvasSize.Y)
    end, {})
    React.useLayoutEffect(function()
        if not (var14 and isOpen) then
            return nil
        end
        local function updateSize() -- Luacid: Inlined by compiler; 1 call site recovered
            var16(var14.AbsoluteSize)
        end

        updateSize()
        local connection = var14:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
        return function()
            connection:Disconnect()
        end
    end, { var14, isOpen })

    React.useEffect(function()
        var1.refresh()
    end, { var1 })

    local onClose = React.useCallback(function()
        var6(false)
    end, {})
    local eventHandlers = React.useMemo(function()
        return {
            [NavigateBack] = {
                phase = "Bubble",
                handler = InputHandlers.onRelease(function(arg1)
                    onClose()
                    arg1:cancel()
                end)
            }
        }
    end, { onClose })
    local focusRef = FocusNavigationUtils.useFocusRoot({
        surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = isOpen and var3,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    local onToggleMenu = React.useCallback(function()
        if isOpen then
            onClose()
            return
        end
        var1.refresh()

        var10(var1.getSnapshot() or {})
        var8(false)
        var12(nil)
        var6(true)
    end, { isOpen, onClose, var1 })

    local onSelect = React.useCallback(function(str1: string)
        if var1.select(str1) then
            onClose()
            return
        end
        var12("Could not save this location. Try again.")
    end, { var1, onClose })
    local onToggleShowAll = React.useCallback(function()
        var8(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local var26 = React.useMemo(function()
        return PopForcePickerModel.buildRoster(var9, forcedPop)
    end, { var9, forcedPop })
    local rows = PopForcePickerModel.getVisibleRoster(var26, forcedPop, showAll)

    if not var3 then
        return nil
    end
    return React.createElement(PopForcePickerView, {
        LayoutOrder = tbl2.LayoutOrder,
        compact = tbl2.compact,
        forcedPop = forcedPop,
        rows = rows,
        hasMore = #var26 > 5,
        showAll = showAll,
        isOpen = isOpen,
        errorText = errorText,
        tokens = tokens,
        anchorRef = anchorRef,
        menuSize = Vector2.new(
            math.min(tokens.Size.Size_1200 * 7, math.max(1, var15.X - tokens.Margin.Medium * 2)),
            math.min(var17, math.max(1, var15.Y - tokens.Margin.Medium * 2))
        ),
        onCanvasSizeChanged = onCanvasSizeChanged,
        focusRef = focusRef,
        onToggleMenu = onToggleMenu,
        onClose = onClose,
        onSelect = onSelect,
        onToggleShowAll = onToggleShowAll
    })
end)
