-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppCompositionParent = script:FindFirstAncestor("AppComposition").Parent
local FFlagEnableSplitPane = require(AppCompositionParent.SharedFlags).FFlagEnableSplitPane

return {
    NavigationRegion = FFlagEnableSplitPane and { Root = "composition-navigation-root" } or nil,
    ContentRegion = {
        Root = "composition-content-root",
        Header = "composition-content-header",
        Body = "composition-content-body"
    },
    SupportRegion = FFlagEnableSplitPane and {
        Root = "composition-support-root",
        Collapsed = "composition-support-collapsed"
    } or nil,
    Layout = { Discovery = "composition-layout-discovery", Detail = "composition-layout-detail" },
    Utility = { ClipAtMaxWidth = "composition-clip-at-max-width" }
}
