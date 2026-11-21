-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EconomyCommonCoreScriptHooksParent = script:FindFirstAncestor("EconomyCommonCoreScriptHooks").Parent
local React = require(EconomyCommonCoreScriptHooksParent.React)
local FocusNavigableSurfaceIdentifierEnum = require(EconomyCommonCoreScriptHooksParent.FocusNavigationUtils).FocusNavigableSurfaceIdentifierEnum

local useFocusNavigationSurface = require(script.Parent.useFocusNavigationSurface)

local function FocusNavigationModalSurface(tbl1)
    local ref = useFocusNavigationSurface({
        selectionGroupName = tbl1.selectionGroupName,
        focusNavigableSurfaceIdentifier = if tbl1.surfaceIdentifier then tbl1.surfaceIdentifier else FocusNavigableSurfaceIdentifierEnum.CentralOverlay
    })

    return React.createElement("Frame", {
        ref = ref,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
        SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
        SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
        SelectionBehaviorUp = Enum.SelectionBehavior.Stop
    }, tbl1.children)
end

return FocusNavigationModalSurface
