-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local uiblox = require(FoundationParent.BuilderIcons).Migration.uiblox

local AvatarIcon = require(Foundation.Components.AvatarIcon)
local Icon = require(Foundation.Components.Icon)
local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)

local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon

local AccessoryType = require(Foundation.Enums.AccessoryType)

local _AvatarIconSize = require(Foundation.Enums.AvatarIconSize)

local _IconSize = require(Foundation.Enums.IconSize)

return React.memo(function(tbl1) -- name: BreadcrumbAccessory
    local variant = tbl1.variant
    local var1 = type(tbl1.config) == "string" and {
        iconName = tbl1.config
    } or tbl1.config

    if var1.type == AccessoryType.Avatar then
        return React.createElement(
            AvatarIcon,
            {
                userId = var1.userId,
                size = variant.avatarSize,
                LayoutOrder = tbl1.LayoutOrder,
                testId = tbl1.testId
            }
        )
    end
    local iconName = var1.iconName
    if not isBuilderOrMigratedIcon(iconName) then
        return React.createElement(
            Image,
            {
                Image = iconName,
                tag = variant.tag,
                LayoutOrder = tbl1.LayoutOrder,
                testId = tbl1.testId
            }
        )
    end

    return React.createElement(Icon, {
        name = if isMigrated(iconName) then uiblox[iconName].name else iconName,
        variant = if isMigrated(iconName) then uiblox[iconName].variant else var1.iconVariant,
        size = variant.iconSize,
        style = variant.style,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    })
end)
