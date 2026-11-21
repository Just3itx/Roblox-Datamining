-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)

local useSemanticTokens = require(AvatarExperienceControlBar.Hooks.useSemanticTokens)

local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)
local IconItem = require(AvatarExperienceControlBar.Components.Items.IconItem)
local ImageItem = require(AvatarExperienceControlBar.Components.Items.ImageItem)
local ImageItemWithTooltip = require(AvatarExperienceControlBar.Components.Items.ImageItemWithTooltip)
local ColorItem = require(AvatarExperienceControlBar.Components.Items.ColorItem)
local FFlagAXAddToolTipToIconItemMenu = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXAddToolTipToIconItemMenu
local FFlagAXMigrateBuilderIcons = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXMigrateBuilderIcons
local FFlagAXResetAvatarButton = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXResetAvatarButton
local FFlagMeProfileEntryTooltipEnabled = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagMeProfileEntryTooltipEnabled

return React.memo(React.forwardRef(function(tbl1, ref) -- name: IconOnlyMenu
    local var1 = useSemanticTokens()

    local var2 = React.useCallback(function(tbl2)
        local item = tbl2.item
        local isActive = tbl2.isActive
        local onItemActivated = tbl2.onItemActivated

        local onActivated = (not FFlagAXResetAvatarButton or item.type ~= "divider") and function()
            if onItemActivated then
                onItemActivated(item.id)
            end
            if item.onActivated then
                item.onActivated()
            end
        end or nil

        if item.type == "image" then
            return React.createElement(
                if FFlagMeProfileEntryTooltipEnabled and item.toolTipConfig then ImageItemWithTooltip else ImageItem,
                {
                    thumbnailUrl = item.thumbnailUrl,
                    isActive = isActive,
                    onActivated = onActivated,
                    disabled = item.disabled,
                    ref = item.ref,
                    enableFocusAnimation = item.enableFocusAnimation,
                    Visible = item.visible,
                    LayoutOrder = tbl2.index,
                    hideIndicator = item.hideIndicator,
                    toolTipConfig = if FFlagMeProfileEntryTooltipEnabled then item.toolTipConfig else nil
                }
            )
        elseif item.type == "icon" then
            return React.createElement(IconItem, {
                icon = item.icon,
                activeIcon = item.activeIcon,
                iconSize = item.iconSize,
                iconVariant = if FFlagAXMigrateBuilderIcons then item.iconVariant else nil,
                activeIconVariant = if FFlagAXMigrateBuilderIcons then item.activeIconVariant else nil,
                isActive = isActive,
                animate = not item.disableAnimation,
                onActivated = onActivated,
                disabled = item.disabled,
                toolTipConfig = if FFlagAXAddToolTipToIconItemMenu and tbl1.activeItemId ~= "" and item.toolTipConfig then nil else item.toolTipConfig,
                ref = item.ref,
                Visible = item.visible,
                LayoutOrder = tbl2.index
            })
        elseif item.type == "color" then
            return React.createElement(ColorItem, {
                colors = item.colors,
                colorSize = item.colorSize,
                isActive = item.isActive,
                size = item.size,
                onActivated = onActivated,
                disabled = item.disabled,
                ref = item.ref,
                Visible = item.visible,
                LayoutOrder = tbl2.index,
                Selectable = item.Selectable
            })
        elseif FFlagAXResetAvatarButton and item.type == "divider" then
            return React.createElement(
                Foundation.Divider,
                {
                    variant = item.variant,
                    ref = item.ref,
                    Visible = item.visible,
                    LayoutOrder = tbl2.index
                }
            )
        end
        return nil
    end, { if FFlagAXAddToolTipToIconItemMenu then tbl1.activeItemId else nil })

    local var3 = React.useMemo(function()
        local result = {
            IconOnlyMenuListLayout = React.createElement("UIListLayout", {
                FillDirection = if tbl1.direction == "horizontal" then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, var1.iconOnlyMenuItemGap)
            })
        }

        for index, item in tbl1.items do
            local isActive = if item.type == "divider" then nil elseif item.isActive ~= nil then item.isActive else item.id == tbl1.activeItemId
            local str1 = `MenuItem-{item.id}`
            result[str1] = var2({ item = item, isActive = isActive, onItemActivated = tbl1.onItemActivated, index = index })
        end

        return result
    end, {
        tbl1.items,
        tbl1.activeItemId,
        tbl1.onItemActivated,
        tbl1.direction,
        var2
    })
    return React.createElement(Foundation.View, {
        tag = "auto-xy radius-circle padding-xsmall",
        backgroundStyle = var1.menuBackgroundStyle,
        ref = ref,
        Visible = #tbl1.items > 0,
        LayoutOrder = tbl1.LayoutOrder,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        Position = tbl1.Position
    }, var3)
end))
