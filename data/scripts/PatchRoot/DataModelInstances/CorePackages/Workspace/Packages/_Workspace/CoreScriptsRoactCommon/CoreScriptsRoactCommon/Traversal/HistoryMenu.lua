-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local Cryo = require(CoreScriptsRoactCommonParent.Cryo)
local Foundation = require(CoreScriptsRoactCommonParent.Foundation)
local Localization = require(CoreScriptsRoactCommonParent.Localization)
local React = require(CoreScriptsRoactCommonParent.React)

local Constants = require(script.Parent.Constants)
local TraversalTelemetry = require(script.Parent.TraversalTelemetry)

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local Menu = Foundation.Menu
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local View = Foundation.View
local useLocalization = Localization.Hooks.useLocalization

local function formatTags(historyButtonTags) -- Luacid: Inlined by compiler; 1 call site recovered
    return if typeof(historyButtonTags) == "table" then historyButtonTags else {
        [historyButtonTags] = true
    }
end

local function setMenuSelection(arg1, arg2, menuSide) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1 and arg1.current) then
        return
    end

    if menuSide == PopoverSide.Top then
        arg1.current.NextSelectionUp = arg2
    elseif menuSide == PopoverSide.Bottom then
        arg1.current.NextSelectionDown = arg2
    end
end

return React.memo(React.forwardRef(function(tbl1, anchorRef) -- name: HistoryMenu
    local var1 = if tbl1.idleButtonStateIsDown ~= nil then tbl1.idleButtonStateIsDown else Constants.DEFAULT_CHEVRON_BUTTON_STATE
    local isOpen, var3 = React.useState(false)
    local var4 = if isOpen then not var1 or not isOpen and var1 else not isOpen and var1
    local var5 = useLocalization({ history = "CoreScripts.TopBar.Traversal.History" })

    local ref = React.useRef(nil)

    local var2 = React.useCallback(function(arg1)
        setMenuSelection(ref, arg1, tbl1.menuSide)
    end, { tbl1.menuSide })

    local tag = React.useMemo(function()
        local tbl2 = not tbl1.historyButtonTags and {} or formatTags(tbl1.historyButtonTags)
        return Cryo.Dictionary.join({ ["row auto-xy align-y-center align-x-center radius-medium"] = true }, tbl2)
    end, { tbl1.historyButtonTags })

    local var9 = React.useCallback(function()
        if tbl1.onMenuToggled then
            tbl1.onMenuToggled(not isOpen)
        end

        var3(not isOpen)
    end, { isOpen, tbl1.onMenuToggled })

    local onPressedOutside = React.useCallback(function()
        var3(false)
        if tbl1.onMenuToggled then
            tbl1.onMenuToggled(false)
        end
    end, {})
    React.useEffect(function()
        if not tbl1.closeMenuConn then
            return
        end

        local var11 = tbl1.closeMenuConn(onPressedOutside)
        return function()
            for _, value in var11 do
                value:Disconnect()
            end
        end
    end, { tbl1.closeMenuConn, onPressedOutside })

    local onActivated = React.useCallback(function(num1: number)
        TraversalTelemetry.sendHistoryMenuItemClick(
            {
                integration_id = "history_dropdown",
                event_type = "click",
                destination_universe_id = tostring(num1)
            }
        )
        onPressedOutside()
        if not tbl1.onMenuItemSelected then
            return
        end
        tbl1.onMenuItemSelected(num1)
    end, { onPressedOutside, tbl1.onMenuItemSelected })

    local var6 = React.useCallback(function()
        TraversalTelemetry.sendHistoryMenuHistoryClick({ integration_id = "history_landing", event_type = "click" })

        onPressedOutside()
        tbl1.onHistorySelected()
    end, { onPressedOutside, tbl1.onHistorySelected })

    local items = React.useMemo(function()
        local var13 = Cryo.List.map(tbl1.historyItems, function(arg1)
            return {
                id = arg1.universeId,
                text = arg1.text,
                icon = arg1.icon
            }
        end)
        local tbl2 = {
            id = "history",
            text = var5.history,
            icon = IconName.ClockSpinReverse,
            onActivated = var6
        }

        return (Cryo.List.join(var13, { tbl2 }))
    end, { tbl1.historyItems })

    local createElement = React.createElement
    local var14 = View
    local tbl2 = { tag = "auto-xy" }

    local tbl3 = { ChevronButton = 0, Menu = 0 }
    local createElement2 = React.createElement
    local var15 = View

    local tbl4 = {
        tag = tag,
        onActivated = function()
            TraversalTelemetry.sendHistoryMenuButtonActionEvent(
                {
                    integration_id = "history_chevron",
                    event_type = if isOpen then "close" else "open"
                }
            )
            var9()
        end,
        ref = ref,
        testId = "--chevron-button"
    }
    local tbl5 = {
        Chevron = React.createElement(Icon, { name = if var4 then IconName.ChevronLargeDown else IconName.ChevronLargeUp })
    }
    tbl3.ChevronButton = createElement2(var15, tbl4, tbl5)

    tbl3.Menu = React.createElement(Menu, {
        align = PopoverAlign.Start,
        anchorRef = anchorRef or ref,
        isOpen = isOpen,
        items = items,
        onActivated = onActivated,
        onPressedOutside = onPressedOutside,
        side = tbl1.menuSide,
        size = tbl1.menuSize,
        width = if anchorRef and anchorRef.current then UDim.new(0, anchorRef.current.AbsoluteSize.X) else nil,
        ref = var2
    })
    return createElement(var14, tbl2, tbl3)
end))
