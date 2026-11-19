-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Constants = require(AbuseReportMenu.Components.Constants)

local useStyle = require(CorePackages.Packages.UIBlox).Core.Style.useStyle

function getMenuItemSizings()
    local var1 = useStyle()

    return {
        ItemPadding = var1.Tokens.Size.Size_250,
        DropdownTextSize = var1.Tokens.FontSize.FontSize_400,
        FontStyle = Constants.ReportMenuFontStyle,
        ButtonSize = Constants.ReportMenuButtonSizeConsole,
        ButtonInsideVerticalPadding = var1.Tokens.Size.Size_100
    }
end

return getMenuItemSizings
