-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local AppSplitView = require(SplitPaneParent.AppSplitView)
local Responsive = require(SplitPaneParent.Responsive)
local SharedFlags = require(SplitPaneParent.SharedFlags)

local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)

local SupportPaneMode = AppSplitView.Enums.SupportPaneMode

local FFlagLuaAppSduiEdpEnabled = SharedFlags.FFlagLuaAppSduiEdpEnabled

local function resolveOpenedMode(directional) -- Luacid: Inlined by compiler; 1 call site recovered
    return if directional == Responsive.Input.Directional or not FFlagLuaAppSduiEdpEnabled then SupportPaneMode.Expanded else SupportPaneMode.Normal
end

return {
    resolveOpenedMode = resolveOpenedMode,
    resolveInputChangedMode = function(directional)
        if directional == Responsive.Input.Directional then
            return SupportPaneMode.Expanded
        end

        return SplitPaneStore.getStore().getSupportPaneMode()
    end,
    expandSupportPaneIfCollapsed = function()
        local store = SplitPaneStore.getStore()
        if store.getSupportPaneModeIfActive(false) == SupportPaneMode.Collapsed then
            local var1 = Responsive.GetInputModeStore(false).getPreferredInputType(false)
            store.setTemporarySupportPaneMode((resolveOpenedMode(var1)))
        end
    end
}
