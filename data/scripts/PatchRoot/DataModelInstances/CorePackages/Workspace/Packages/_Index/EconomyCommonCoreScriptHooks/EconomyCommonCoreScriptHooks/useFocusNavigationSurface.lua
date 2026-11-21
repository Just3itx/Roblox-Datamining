-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local EconomyCommonCoreScriptHooksParent = script:FindFirstAncestor("EconomyCommonCoreScriptHooks").Parent
local React = require(EconomyCommonCoreScriptHooksParent.React)
local FocusNavigationUtils = require(EconomyCommonCoreScriptHooksParent.FocusNavigationUtils)
local FocusNavigableSurfaceRegistry = FocusNavigationUtils.FocusNavigableSurfaceRegistry
local useRegisterFocusNavigableSurface = FocusNavigableSurfaceRegistry.useRegisterFocusNavigableSurface
local useDeRegisterFocusNavigableSurface = FocusNavigableSurfaceRegistry.useDeRegisterFocusNavigableSurface
local useLastInputMethod = FocusNavigationUtils.useLastInputMethod
local useAutoFocus = FocusNavigationUtils.useAutoFocus
local useDescendantHasFocus = FocusNavigationUtils.useDescendantHasFocus

local function useFocusNavigationSurface(tbl1)
    local selectionParent, var1 = React.useState(nil)
    local var2 = useRegisterFocusNavigableSurface()
    local var3 = useDeRegisterFocusNavigableSurface()
    local var4 = useAutoFocus({ selectionParent }, 0.1)
    local var5 = useDescendantHasFocus(selectionParent)
    local var6 = useLastInputMethod()

    React.useEffect(function()
        if selectionParent then
            var2(tbl1.focusNavigableSurfaceIdentifier, selectionParent)
            GuiService:AddSelectionParent(tbl1.selectionGroupName, selectionParent)
        else
            var3(tbl1.focusNavigableSurfaceIdentifier, selectionParent)

            GuiService:RemoveSelectionGroup(tbl1.selectionGroupName)
            GuiService.SelectedCoreObject = nil
        end

        return function()
            var3(tbl1.focusNavigableSurfaceIdentifier, selectionParent)

            GuiService:RemoveSelectionGroup(tbl1.selectionGroupName)
            GuiService.SelectedCoreObject = nil
        end
    end, { selectionParent, tbl1.focusNavigableSurfaceIdentifier, tbl1.selectionGroupName })

    local var7 = (var6 == "Gamepad" or var6 == "Keyboard") and selectionParent and not var5

    React.useEffect(function()
        local var8 = if var7 then var4() else nil

        return function()
            if var8 then
                var8.cancel()
            end
        end
    end, { var7, var4 })

    return var1
end

return useFocusNavigationSurface
