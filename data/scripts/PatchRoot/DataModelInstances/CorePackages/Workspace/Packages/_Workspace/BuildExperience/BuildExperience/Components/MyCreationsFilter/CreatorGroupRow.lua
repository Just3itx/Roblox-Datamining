-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useAssetFetchStatus = require(BuildExperienceParent.RoactUtils).Hooks.useAssetFetchStatus

local Icon = Foundation.Icon
local List = Foundation.List

local useTokens = Foundation.Hooks.useTokens

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local ListItemInputType = Foundation.Enums.ListItemInputType

local function CreatorGroupRow(tbl1)
    local var1 = useTokens()
    local var2 = useAssetFetchStatus(tbl1.icon)
    local trailing = if tbl1.isSelected then React.createElement(Icon, { name = IconName.CheckLarge, size = IconSize.Medium, style = var1.Color.Content.Emphasis }) else nil
    local iconName = if var2 == Enum.AssetFetchStatus.Loading then IconName.Clock elseif var2 == Enum.AssetFetchStatus.Failure or var2 == Enum.AssetFetchStatus.TimedOut then IconName.ImageCircleSlash else tbl1.icon
    return React.createElement(List.Item, {
        LayoutOrder = tbl1.LayoutOrder,
        leading = { iconName = iconName },
        title = tbl1.name,
        trailing = trailing,
        onActivated = tbl1.onActivated,
        input = ListItemInputType.None,
        testId = tbl1.testId
    })
end

return CreatorGroupRow
