-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
local Settings = script:FindFirstAncestor("Settings")

return {
    GAMESETTINGS = {
        PAGE_ID = "gamesettings",
        TAB_HEADER = { NAME = "GameSettingsTab", TEXT = "Settings", ICON = "icons/common/settings" },
        LAYOUT_ORDER = require(Settings.Resources.GameSettingsConstants).SETTINGS_MENU_LAYOUT_ORDER
    },
    TRAVERSAL_HISTORY = {
        TAB_HEADER = {
            NAME = "TraversalHistoryWrapper",
            TEXT_KEY = "CoreScripts.TopBar.Traversal.History"
        }
    }
}
