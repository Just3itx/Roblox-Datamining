-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGuiCommon = script:FindFirstAncestor("CoreGuiCommon")
local CoreGuiCommonParent = CoreGuiCommon.Parent

local FFlagAddUILessMode = require(CoreGuiCommonParent.SharedFlags).FFlagAddUILessMode
local FFlagTopBarSignalizeMenuOpen = require(CoreGuiCommon.Flags).FFlagTopBarSignalizeMenuOpen
local FFlagTopBarSignalizeKeepOutAreas = require(CoreGuiCommon.Flags).FFlagTopBarSignalizeKeepOutAreas
local FFlagTopBarSignalizeHealthBar = require(CoreGuiCommon.Flags).FFlagTopBarSignalizeHealthBar
local FFlagEnableUISelector = require(CoreGuiCommon.Flags).FFlagEnableUISelector

return {
    GetUILessStore = if FFlagAddUILessMode then require(script.GetUILessStore) else nil,
    GetInspectAndBuyStore = if FFlagTopBarSignalizeMenuOpen then require(script.GetInspectAndBuyStore) else nil,
    GetKeepOutAreasStore = if FFlagTopBarSignalizeKeepOutAreas then require(script.GetKeepOutAreasStore) else nil,
    GetLocalHumanoidStore = if FFlagTopBarSignalizeHealthBar then require(script.GetLocalHumanoidStore) else nil,
    GetUiSelectorSignalStore = if FFlagEnableUISelector then require(script.GetUiSelectorSignalStore) else nil
}
