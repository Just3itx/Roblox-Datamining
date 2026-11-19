-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local uiblox = require(FoundationParent.BuilderIcons).Migration.uiblox

local Icon = require(Foundation.Components.Icon)
local Image = require(Foundation.Components.Image)
local View = require(Foundation.Components.View)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local useCumulativeBackground = require(Foundation.Utility.useCumulativeBackground)
local useTokens = require(Foundation.Providers.Style.useTokens)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon
local AvatarGroup = require(Foundation.Components.AvatarGroup)

local _AvatarGroupType = require(Foundation.Enums.AvatarGroupType)

local useBackgroundStyle = require(Foundation.Providers.Style.BackgroundStyleContext).useBackgroundStyle

local _Types = require(Foundation.Components.Types)

local Flags = require(Foundation.Utility.Flags)
local useAccessoryVariants = require(script.Parent.useAccessoryVariants)

local _ChipSize = require(Foundation.Enums.ChipSize)

local function AvatarGroupWrapper(tbl1)
    local var1 = useBackgroundStyle()
    local var2 = table.clone(tbl1.config.props)
    var2.size = tbl1.size
    var2.backplateStyle = useCumulativeBackground(var1, tbl1.chipBackgroundStyle)
    return React.createElement(AvatarGroup, var2)
end

return React.memo(function(tbl1) -- name: Accessory
    local var1 = useTokens()
    local var2 = React.useMemo(function()
        return if type(tbl1.config) == "string" then {
            iconName = tbl1.config,
            isCircular = false
        } else tbl1.config
    end, { tbl1.config })

    local var3 = useAccessoryVariants(
        var1,
        tbl1.size,
        tbl1.isLeading,
        if Flags.FoundationFixChipAccessoryLayout then var2.type == "AvatarGroup" else var2.type == "AvatarGroup" or var2.isCircular or false,
        tbl1.isIconOnly
    )
    local element

    if var2.type == "AvatarGroup" then
        element = React.createElement(AvatarGroupWrapper, tbl1)
    elseif isBuilderOrMigratedIcon(var2.iconName) then
        element = React.createElement(Icon, {
            name = if isMigrated(var2.iconName) then uiblox[var2.iconName].name else var2.iconName,
            variant = if isMigrated(var2.iconName) then uiblox[var2.iconName].variant else var2.iconVariant,
            size = var3.accessory.Size.Y.Offset,
            style = tbl1.contentStyle
        })
    else
        element = React.createElement(Image, { Image = var2.iconName, Size = var3.accessory.Size, imageStyle = tbl1.contentStyle })
    end

    return React.createElement(View, {
        tag = "auto-xy",
        padding = var3.accessory.padding,
        onActivated = var2.onActivated,
        isDisabled = tbl1.isDisabled,
        LayoutOrder = if tbl1.isLeading then 1 else 3,
        testId = tbl1.testId
    }, element)
end)
