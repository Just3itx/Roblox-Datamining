-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local restoreSelectionIfStranded = require(scriptParentParent.ChatUIPrimitives).Hooks.restoreSelectionIfStranded

local function ReportMenuFocusRoot(tbl1)
    local focusNavigationUtils = require(scriptParentParent.FocusNavigationUtils)
    local useFocusRoot = focusNavigationUtils.useFocusRoot
    local focusNavigableSurfaceIdentifierEnum = focusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

    local triggerRef = React.useRef(nil)

    local var2 = React.useRef(tbl1.isOpen)
    React.useEffect(function()
        if var2.current and not tbl1.isOpen then
            restoreSelectionIfStranded(GuiService, triggerRef.current)
        end
        var2.current = tbl1.isOpen
        return nil
    end, { tbl1.isOpen })

    local containerRef = useFocusRoot({
        surfaceIdentifier = focusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = tbl1.isOpen,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false
    })

    return tbl1.render({ triggerRef = triggerRef, containerRef = containerRef })
end

return ReportMenuFocusRoot
