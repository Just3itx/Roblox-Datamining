-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local Badge = Foundation.Badge
local Coachmark = Foundation.Coachmark
local IconButton = Foundation.IconButton
local View = Foundation.View
local BadgeVariant = Foundation.Enums.BadgeVariant
local InputSize = Foundation.Enums.InputSize
local IconVariant = Foundation.Enums.IconVariant
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local AvatarExperienceFlags = require(AvatarExperienceUIKitParent.AvatarExperienceFlags)
local FFlagAXCategoryMenuVisualFixes = AvatarExperienceFlags.FFlagAXCategoryMenuVisualFixes
local FFlagAXMigrateAllTabToSduiDev = AvatarExperienceFlags.FFlagAXMigrateAllTabToSduiDev
local bool1 = game:DefineFastFlag("AXCategoryMenuBadgePositionTokens2", false)

local TabGroup = require(AvatarExperienceUIKit.TabGroup.TabGroup)

local CategoryMenuButtonsLocationEnum = require(script.Parent.CategoryMenuButtonsLocationEnum)

local layout = {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalFlex = Enum.UIFlexAlignment.Fill
}

local tbl1 = {
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder
}

local flexItem = {
    FlexMode = Enum.UIFlexMode.Fill
}

local function CategoryMenuButtonGroup(tbl4)
    local var1 = if bool1 then Foundation.Hooks.useTokens() else nil
    local backgroundColor3 = tbl4.BackgroundColor3
    local backgroundTransparency = tbl4.BackgroundTransparency
    local var2 = React.useMemo(function()
        local tbl5 = {
            FlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.None }),
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        }
        if tbl4.buttons then
            for layoutOrder, button in tbl4.buttons do
                local str1 = `Button-{button.id}`
                if bool1 then
                    local badgeCount = button.badgeCount
                    local bool2 = typeof(badgeCount) == "number" and badgeCount > 0
                    local var2 = if FFlagAXMigrateAllTabToSduiDev then IconVariant.Regular else IconVariant.Filled
                    local variant = button.iconVariant or var2

                    local createElement = React.createElement
                    local var4 = View
                    local tbl6 = {
                        LayoutOrder = layoutOrder,
                        AutomaticSize = Enum.AutomaticSize.XY
                    }
                    local tbl7 = {
                        IconButton = React.createElement(IconButton, {
                            onActivated = button.onActivated,
                            icon = {
                                name = button.icon,
                                variant = variant
                            },
                            size = InputSize.Medium,
                            isDisabled = button.isDisabled,
                            BackgroundColor3 = backgroundColor3,
                            BackgroundTransparency = if backgroundTransparency == nil then 1 else backgroundTransparency
                        }),
                        CountBadge = 0
                    }
                    local element

                    if bool2 then
                        element = React.createElement(Badge, {
                            text = if badgeCount > 99 then "99+" else tostring(badgeCount),
                            variant = BadgeVariant.Contrast,
                            AnchorPoint = Vector2.new(1, 0),
                            Position = if var1 then UDim2.new(1, var1.Gap.XXSmall, 0, -var1.Gap.XXSmall) else UDim2.new(1, 0, 0, -4),
                            ZIndex = 2
                        })
                    else
                        element = nil
                    end

                    tbl7.CountBadge = element
                    tbl5[str1] = createElement(var4, tbl6, tbl7)
                else
                    tbl5[str1] = React.createElement(IconButton, {
                        onActivated = button.onActivated,
                        LayoutOrder = layoutOrder,
                        icon = {
                            name = button.icon,
                            variant = IconVariant.Filled
                        },
                        size = InputSize.Small,
                        isDisabled = button.isDisabled,
                        BackgroundColor3 = backgroundColor3,
                        BackgroundTransparency = if backgroundTransparency == nil then 1 else backgroundTransparency
                    })
                end
            end
        end
        return tbl5
    end, {
        tbl4.buttons,
        backgroundColor3,
        backgroundTransparency,
        var1
    })

    local var3

    if bool1 then
        local paddingRight = tbl4.paddingRight
        var3 = React.useMemo(function(): {right: any}?
            return if paddingRight then { right = paddingRight } else nil
        end, { paddingRight })
    else
        var3 = nil
    end

    return React.createElement(
        View,
        {
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = tbl4.LayoutOrder,
            padding = var3
        },
        var2
    )
end

return React.forwardRef(function(tbl4, ref) -- name: CategoryMenu
    local var1 = React.useRef(nil)
    local var2 = Foundation.Hooks.useTokens()
    local var3

    if FFlagAXCategoryMenuVisualFixes then
        local var4 = React.useRef(nil)

        local var5 = React.useRef(false)
        React.useEffect(function()
            if not var5.current then
                var5.current = true
                return
            end
            local current = var4.current
            if current then
                current.setOffset(0)
            end
        end, { tbl4.activeCategoryId })

        var3 = var4
    else
        var3 = nil
    end

    local activeTooltipIdx = tbl4.activeTooltipIdx
    local tooltips = tbl4.tooltips
    local tooltip = if activeTooltipIdx and tooltips then tooltips[activeTooltipIdx] else nil

    local items = React.useMemo(function()
        local result = {}
        if not tooltip then
            return tbl4.categories
        end

        for _, value in tbl4.categories do
            if value.id == tooltip.anchorId then
                local var4 = table.clone(value)
                var4.ref = var1
                table.insert(result, var4)
            else
                table.insert(result, value)
            end
        end
        return result
    end, { tbl4.categories, tooltip })

    local var5 = if tbl4.categoryBackgroundStyle then tbl4.categoryBackgroundStyle else var2.Color.Common.NavigationBar
    local var6 = if tbl4.subcategoryBackgroundStyle then tbl4.subcategoryBackgroundStyle else var2.Color.Common.NavigationBar
    local var7 = if tbl4.buttonsLocation then tbl4.buttonsLocation else CategoryMenuButtonsLocationEnum.SubcategoriesStart
    local bool2 = if tbl4.buttons then #tbl4.buttons > 0 else false
    local paddingRight = if bool1 then UDim.new(0, var2.Padding.Medium) else nil
    local subcategories = tbl4.subcategories
    local bool3 = if subcategories then #subcategories > 0 else false
    local bool4 = bool3 or bool2

    local createElement = React.createElement
    local var9 = View
    local tbl5 = {
        ref = ref,
        Position = tbl4.Position,
        LayoutOrder = tbl4.LayoutOrder,
        ZIndex = tbl4.ZIndex,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        layout = tbl1
    }
    local tbl6 = {
        CategoryRow = React.createElement(
            View,
            {
                LayoutOrder = 1,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                layout = layout
            },
            {
                ButtonsStart = if bool2 and var7 == CategoryMenuButtonsLocationEnum.CategoriesStart then React.createElement(
                    CategoryMenuButtonGroup,
                    {
                        LayoutOrder = 1,
                        buttons = tbl4.buttons,
                        BackgroundColor3 = var5.Color3,
                        BackgroundTransparency = var5.Transparency
                    }
                ) else nil,
                Categories = React.createElement(
                    View,
                    {
                        LayoutOrder = 2,
                        Size = UDim2.new(0, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        flexItem = flexItem
                    },
                    {
                        TabGroup = React.createElement(TabGroup, {
                            items = items,
                            activeTabId = tbl4.activeCategoryId,
                            onTabActivated = tbl4.onCategoryActivated,
                            tabFontStyle = tbl4.categoryFontStyle,
                            tabPadding = tbl4.categoryPadding,
                            tabTextStyle = tbl4.categoryTextStyle,
                            tabActiveTextStyle = tbl4.categoryActiveTextStyle,
                            BackgroundColor3 = var5.Color3,
                            BackgroundTransparency = var5.Transparency
                        })
                    }
                ),
                ButtonsEnd = if bool2 and var7 == CategoryMenuButtonsLocationEnum.CategoriesEnd then React.createElement(
                    CategoryMenuButtonGroup,
                    {
                        LayoutOrder = 3,
                        buttons = tbl4.buttons,
                        BackgroundColor3 = var5.Color3,
                        BackgroundTransparency = var5.Transparency,
                        paddingRight = paddingRight
                    }
                ) else nil
            }
        ),
        SubcategoryRow = 0,
        ToolTip = 0
    }
    local var10

    if bool4 then
        local createElement2 = React.createElement
        local var11 = View
        local tbl7 = {
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            layout = layout
        }
        local tbl8 = {
            ButtonsStart = if bool2 and var7 == CategoryMenuButtonsLocationEnum.SubcategoriesStart then React.createElement(
                CategoryMenuButtonGroup,
                {
                    LayoutOrder = 1,
                    buttons = tbl4.buttons,
                    BackgroundColor3 = var6.Color3,
                    BackgroundTransparency = var6.Transparency
                }
            ) else nil,
            Subcategories = 0,
            ButtonsEnd = 0
        }
        local element

        if bool3 then
            element = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    Size = UDim2.new(0, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    flexItem = flexItem
                },
                {
                    TabGroup = React.createElement(TabGroup, {
                        items = subcategories or {},
                        activeTabId = tbl4.activeSubcategoryId,
                        onTabActivated = tbl4.onSubcategoryActivated,
                        tabFontStyle = tbl4.subcategoryFontStyle,
                        tabPadding = tbl4.subcategoryPadding,
                        tabTextStyle = tbl4.subcategoryTextStyle,
                        tabActiveTextStyle = tbl4.subcategoryActiveTextStyle,
                        BackgroundColor3 = var6.Color3,
                        BackgroundTransparency = var6.Transparency,
                        controllerRef = var3
                    })
                }
            )
        else
            element = nil
        end

        tbl8.Subcategories = element

        tbl8.ButtonsEnd = if bool2 and var7 == CategoryMenuButtonsLocationEnum.SubcategoriesEnd then React.createElement(
            CategoryMenuButtonGroup,
            {
                LayoutOrder = 3,
                buttons = tbl4.buttons,
                BackgroundColor3 = var6.Color3,
                BackgroundTransparency = var6.Transparency,
                paddingRight = paddingRight
            }
        ) else nil
        var10 = createElement2(var11, tbl7, tbl8)
    else
        var10 = nil
    end

    tbl6.SubcategoryRow = var10

    tbl6.ToolTip = if tooltip then React.createElement(Coachmark, {
        LayoutOrder = 3,
        title = tooltip.title,
        text = tooltip.text,
        isOpen = tooltip.isOpen,
        side = tooltip.side or PopoverSide.Bottom,
        align = tooltip.align or PopoverAlign.Center,
        anchorRef = var1,
        onClose = tooltip.onClose,
        actions = tooltip.actions
    }) else nil
    return createElement(var9, tbl5, tbl6)
end)
