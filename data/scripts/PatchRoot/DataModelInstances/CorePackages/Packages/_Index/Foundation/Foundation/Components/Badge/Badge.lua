-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BuilderIcons = require(FoundationParent.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox
local IconVariant = BuilderIcons.IconVariant

local Icon = require(Foundation.Components.Icon)
local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getIconScale = require(Foundation.Utility.getIconScale)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local useBadgeVariants = require(script.Parent.useBadgeVariants)
local useIconSize = require(Foundation.Utility.useIconSize)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon
local Flags = require(Foundation.Utility.Flags)
local useScaledValue = require(Foundation.Utility.useScaledValue)

local BadgeVariant = require(Foundation.Enums.BadgeVariant)

local BadgeShape = require(Foundation.Enums.BadgeShape)

local BadgeSize = require(Foundation.Enums.BadgeSize)

local IconSize = require(Foundation.Enums.IconSize)

local IconPosition = require(Foundation.Enums.IconPosition)

local tbl1 = {
    variant = BadgeVariant.Contrast,
    shape = BadgeShape.Pill,
    size = BadgeSize.Small,
    testId = "--foundation-badge"
}

local tbl2 = {
    [BadgeVariant.Primary] = BadgeVariant.Contrast,
    [BadgeVariant.Secondary] = if Flags.FoundationBadgeBetaUpdate then BadgeVariant.Standard else BadgeVariant.Neutral,
    [BadgeVariant.Neutral] = if Flags.FoundationBadgeBetaUpdate then BadgeVariant.Standard else nil
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Badge
    local var1 = withDefaults(arg1, tbl1)
    local var2 = tbl2[var1.variant] or var1.variant
    local x = useScaledValue(200)

    local var3 = useTokens()

    local var4 = React.useMemo(function()
        return if typeof(var1.icon) == "string" then {
            name = var1.icon,
            position = IconPosition.Left
        } else var1.icon
    end, { var1.icon })

    local bool1 = not (var1.text == nil) and #var1.text > 0
    local bool2 = not bool1
    local var5 = useBadgeVariants

    local shape = var1.shape
    local size = if Flags.FoundationBadgeBetaUpdate then var1.size else nil
    local position = if Flags.FoundationBadgeBetaUpdate and var4 then var4.position else nil

    if Flags.FoundationBadgeBetaUpdate then
        bool2 = nil
    end

    local var6 = var5(var3, var2, shape, size, position, bool2)
    local var7 = if Flags.FoundationBadgeBetaUpdate then var6.icon.size else IconSize.XSmall
    local var8 = useIconSize(var7, true)

    local element = nil
    if var4 ~= nil then
        local layoutOrder = if var4.position == IconPosition.Left then 1 else 3
        if isBuilderOrMigratedIcon(var4.name) then
            element = React.createElement(Icon, {
                name = if isMigrated(var4.name) then uiblox[var4.name].name else var4.name,
                variant = if isMigrated(var4.name) then uiblox[var4.name].variant elseif Flags.FoundationBadgeBetaUpdate then var4.variant or IconVariant.Filled else var4.variant,
                size = var7,
                style = if Flags.FoundationBadgeBetaUpdate then var6.icon.style else var6.content.style,
                LayoutOrder = layoutOrder,
                testId = `{var1.testId}--icon`
            })
        else
            local var9, scale = getIconScale(var4.name, var7)
            if var9 then
                element = React.createElement(
                    View,
                    { Size = var8 },
                    React.createElement(Image, {
                        Image = var4.name,
                        Size = UDim2.fromOffset(var9.X, var9.Y),
                        imageStyle = if Flags.FoundationBadgeBetaUpdate then var6.icon.style else var6.content.style,
                        scale = scale,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        LayoutOrder = layoutOrder,
                        testId = `{var1.testId}--icon`
                    })
                )
            end
        end
    end

    local createElement = React.createElement
    local var9 = View
    local var10 = withCommonProps(var1, {
        backgroundStyle = var6.container.backgroundStyle,
        stroke = var6.container.stroke,
        tag = var6.container.tag,
        ref = ref
    })
    local tbl3 = { Icon = element, Text = 0 }
    local element2

    if bool1 then
        element2 = React.createElement(Text, {
            Text = var1.text,
            textStyle = var6.content.style,
            RichText = true,
            LayoutOrder = 2,
            tag = var6.text.tag,
            testId = `{var1.testId}--text`,
            sizeConstraint = Flags.FoundationBadgeBetaUpdate and {
                MaxSize = Vector2.new(x, math.huge)
            } or nil
        })
    else
        element2 = nil
    end

    tbl3.Text = element2
    return createElement(var9, var10, tbl3)
end))
