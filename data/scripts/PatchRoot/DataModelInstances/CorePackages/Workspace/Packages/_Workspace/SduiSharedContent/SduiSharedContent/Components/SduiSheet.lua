-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local FocusNavigationUtils = require(SduiSharedContentParent.FocusNavigationUtils)
local InputHandlers = require(SduiSharedContentParent.InputHandlers)
local _ReactFocusNavigation = require(SduiSharedContentParent.ReactFocusNavigation)

local Sheet = Foundation.Sheet
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

return React.memo(function(tbl2) -- name: SduiSheet
    local var1, var2 = React.useState(false)

    local var3 = React.useRef(false)
    React.useEffect(function()
        if tbl2.isOpen ~= false then
            var3.current = false
        end
        var2(false)
    end, { tbl2.isOpen })

    local onClose = React.useCallback(function()
        if var3.current then
            return
        end
        var3.current = true
        var2(true)
        if tbl2.onClose then
            tbl2.onClose()
        end
    end, { tbl2.onClose })

    local bool1 = not (tbl2.isOpen == false) and not var1

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onClose()
                    arg1:cancel()
                end)
            }
        }
    end, { onClose })
    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        isFocusable = bool1,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    local onSnapPointChanged = tbl2.onSnapPointChanged and function(snapPoint: number, snapPointIndex: number)
        tbl2.onSnapPointChanged(nil, nil, { snapPoint = snapPoint, snapPointIndex = snapPointIndex })
    end or nil

    return React.createElement(Sheet.Root, {
        ref = ref,
        isOpen = bool1,
        preferCenterSheet = tbl2.preferCenterSheet,
        size = tbl2.size,
        onClose = onClose,
        centerSheetHeight = tbl2.centerSheetHeight,
        snapPoints = tbl2.snapPoints,
        defaultSnapPointIndex = tbl2.defaultSnapPointIndex,
        onSnapPointChanged = onSnapPointChanged,
        testId = tbl2.testId
    }, {
        Header = if tbl2.headerComponent then React.createElement(
            Sheet.Header,
            {
                hasCloseAffordance = tbl2.headerHasCloseAffordance == true
            },
            {
                Content = tbl2.headerComponent
            }
        ) else nil,
        FullBleed = if tbl2.fullBleedComponent then React.createElement(Sheet.FullBleed, nil, { Content = tbl2.fullBleedComponent }) else nil,
        Content = if tbl2.contentComponents then React.createElement(
            Sheet.Content,
            {
                isContentFullBleed = tbl2.contentIsFullBleed,
                isReversed = tbl2.contentIsReversed
            },
            tbl2.contentComponents
        ) else nil,
        Actions = if tbl2.actionComponents then React.createElement(Sheet.Actions, nil, tbl2.actionComponents) else nil
    })
end)
