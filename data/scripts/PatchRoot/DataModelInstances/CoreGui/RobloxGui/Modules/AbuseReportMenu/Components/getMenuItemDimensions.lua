-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Constants = require(AbuseReportMenu.Components.Constants)

local useStyle = require(CorePackages.Packages.UIBlox).Core.Style.useStyle

function getMenuItemDimensions(smallLayoutThreshold)
    local var1 = useStyle()

    if smallLayoutThreshold < Constants.SmallLayoutThreshold then
        return {
            LeftWidth = Constants.LeftContainerWidthSmall,
            RightWidth = Constants.RightContainerWidthSmall,
            TextSize = Constants.FieldLabelSizeSmall
        }
    end

    return {
        LeftWidth = var1.Tokens.Size.Size_2000 * 3,
        RightWidth = var1.Tokens.Size.Size_2000 * 4,
        TextSize = var1.Tokens.FontSize.FontSize_400
    }
end

return getMenuItemDimensions
