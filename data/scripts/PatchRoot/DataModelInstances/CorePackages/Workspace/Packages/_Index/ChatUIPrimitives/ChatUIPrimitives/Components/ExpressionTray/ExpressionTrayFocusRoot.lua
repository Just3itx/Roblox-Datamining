-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local useDefaultFocusBehavior = require(ChatUIPrimitivesParent.ReactFocusNavigation).useDefaultFocusBehavior
local restoreSelectionIfStranded = require(ChatUIPrimitives.Hooks.restoreSelectionIfStranded)

local FFlagExpChatMemoizeExpressionTrayFocusRootRender = require(ChatUIPrimitives.Flags.FFlagExpChatMemoizeExpressionTrayFocusRootRender)

local FFlagExpChatExpressionTrayRestoreGatedByInputMode = require(ChatUIPrimitives.Flags.FFlagExpChatExpressionTrayRestoreGatedByInputMode)

local function ExpressionTrayFocusRoot(tbl1)
    local focusNavigationUtils = require(ChatUIPrimitivesParent.FocusNavigationUtils)
    local useFocusRoot = focusNavigationUtils.useFocusRoot
    local useLastInputMode = focusNavigationUtils.useLastInputMode
    local focusNavigableSurfaceIdentifierEnum = focusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

    local entryButtonRef = React.useRef(nil)

    local var2 = useLastInputMode()
    local var3 = React.useRef(false)
    React.useEffect(function()
        if var3.current and not tbl1.isOpen and (not FFlagExpChatExpressionTrayRestoreGatedByInputMode or var2 == "Focus") then
            restoreSelectionIfStranded(GuiService, entryButtonRef.current)
        end
        var3.current = tbl1.isOpen
        return nil
    end, { tbl1.isOpen, var2 })

    local var4 = useFocusRoot({
        surfaceIdentifier = focusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = tbl1.isOpen,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false
    })

    local defaultFocusRef, containerRef = useDefaultFocusBehavior(var4)

    if not FFlagExpChatMemoizeExpressionTrayFocusRootRender then
        return tbl1.render({ entryButtonRef = entryButtonRef, defaultFocusRef = defaultFocusRef, containerRef = containerRef })
    end

    local render = tbl1.render
    return React.useMemo(function()
        return render({ entryButtonRef = entryButtonRef, defaultFocusRef = defaultFocusRef, containerRef = containerRef })
    end, { render, defaultFocusRef, containerRef })
end

return ExpressionTrayFocusRoot
