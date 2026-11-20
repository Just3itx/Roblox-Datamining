-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local InGameMenu = script.Parent.Parent.InGameMenu

local bool1 = game:DefineFastFlag("SwitchTnSTranslationsPackage", false)

return {
    BarOnTopScrollingFrame = InGameMenu.Components.BarOnTopScrollingFrame,
    Divider = InGameMenu.Components.Divider,
    FocusHandler = InGameMenu.Components.Connection.FocusHandler,
    ThemedTextLabel = InGameMenu.Components.ThemedTextLabel,
    PlayerCell = InGameMenu.Components.PlayerCell,
    GameIcon = InGameMenu.Components.GameIcon,
    PlayerSearchPredicate = InGameMenu.Utility.PlayerSearchPredicate,
    SearchBar = InGameMenu.Components.SearchBar,
    Localization = if bool1 then require(CorePackages.Workspace.Packages.InExperienceLocales).Localization else require(InGameMenu.Localization.Localization),
    LocalizationProvider = InGameMenu.Localization.LocalizationProvider,
    withLocalization = InGameMenu.Localization.withLocalization,
    playerInterface = script.Parent.Parent.Interfaces.playerInterface
}
