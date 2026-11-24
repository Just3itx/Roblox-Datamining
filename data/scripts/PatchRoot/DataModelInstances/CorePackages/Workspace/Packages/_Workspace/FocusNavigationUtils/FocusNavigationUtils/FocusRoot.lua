-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent

local GuiService = game:GetService("GuiService")

local React = require(FocusNavigationUtilsParent.React)
local Cryo = require(FocusNavigationUtilsParent.Cryo)

local useFocusRoot = require(script.Parent.useFocusRoot)
local BaseFocusRoot = require(FocusNavigationUtils.BaseFocusRoot)
local FFlagFocusRootUseHooks = require(script.Parent.FFlagFocusRootUseHooks)

local ReactFocusNavigation = require(FocusNavigationUtilsParent.ReactFocusNavigation)
local _FocusNavigableSurfaceIdentifierEnum = require(FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum)

local useFocusNavigableSurfaceRegistryConnection = require(FocusNavigationUtils.useFocusNavigableSurfaceRegistryConnection)
local useAutoFocus = require(FocusNavigationUtils.useAutoFocus)
local useDescendantHasFocus = require(FocusNavigationUtils.useDescendantHasFocus)
local useLastInputMode = require(FocusNavigationUtils.useLastInputMode)

local tbl1 = {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    SelectionGroup = true
}

local tbl2 = {}

local tbl3 = {
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop
}

local function useWrappedFrameProps(isIsolated: boolean?, frameProps: boolean?, ref: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useMemo(function()
        local var1 = frameProps or tbl2

        if isIsolated then
            var1 = Cryo.Dictionary.join(tbl3, var1)
        end
        return Cryo.Dictionary.join(tbl1, var1, { ref = ref })
    end, { isIsolated, frameProps, ref })
end

local function FocusRoot(arg1)
    if FFlagFocusRootUseHooks then
        local ref = useFocusRoot(arg1)

        return React.createElement(
            BaseFocusRoot,
            {
                ref = ref,
                isIsolated = arg1.isIsolated,
                frameProps = arg1.frameProps
            },
            arg1.children
        )
    end

    local current = if arg1.frameProps and arg1.frameProps.ref then arg1.frameProps.ref.current else nil
    local var1, var2 = React.useState(current)
    local var3 = var1

    local var4 = arg1.eventMap or tbl2
    local var5 = ReactFocusNavigation.useEventMap(var4, var2)
    local var6 = arg1.eventHandlers or tbl2
    local var7 = ReactFocusNavigation.useEventHandlerMap(var6, var5)

    local var8 = arg1.isFocusable == nil or arg1.isFocusable
    local var9 = arg1.shouldRestoreFocus == nil or arg1.shouldRestoreFocus
    local var10 = ReactFocusNavigation.useMostRecentFocusBehavior(var7)
    if not var9 then
        var10 = var7
    end
    useFocusNavigableSurfaceRegistryConnection(var3, arg1.surfaceIdentifier, var8)

    local var11 = useDescendantHasFocus(var3)
    local var12 = useAutoFocus({ var3 }, 0.1)
    local bool1 = useLastInputMode() == "Focus"
    local var13 = arg1.isAutoFocusRoot and var8 and bool1 and var3 and not var11

    React.useEffect(function()
        local var14 = if var13 then var12() else nil

        return function()
            if var14 then
                var14.cancel()
            end
        end
    end, { var13, var12 })

    local var14 = React.useRef(var3)
    React.useEffect(function()
        if var3 then
            var14.current = var3
        end
    end, { var3 })

    React.useEffect(function()
        return function()
            if not var14.current then
                return
            end

            local selectedCoreObject = GuiService.SelectedCoreObject
            if not selectedCoreObject then
                return
            end

            if selectedCoreObject:IsDescendantOf(var14.current) or not selectedCoreObject:IsDescendantOf(game) then
                GuiService.SelectedCoreObject = nil
            end
        end
    end, {})

    local var15 = useWrappedFrameProps(arg1.isIsolated, arg1.frameProps, var10)
    return React.createElement("Frame", var15, arg1.children)
end

return FocusRoot
