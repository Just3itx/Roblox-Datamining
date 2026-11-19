-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:01:11Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)
local uiblox = BuilderIcons.Migration.uiblox

local InputSize = require(Foundation.Enums.InputSize)

local FillBehavior = require(Foundation.Enums.FillBehavior)

local _IconSize = require(Foundation.Enums.IconSize)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)

local _Radius = require(Foundation.Enums.Radius)

local useTokens = require(Foundation.Providers.Style.useTokens)
local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext
local getIconScale = require(Foundation.Utility.getIconScale)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local isBuilderIcon = require(Foundation.Utility.isBuilderIcon)
local useIconButtonVariants = require(script.Parent.useIconButtonVariants)
local useIconSize = require(Foundation.Utility.useIconSize)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon

local Constants = require(Foundation.Constants)

local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local tbl1 = {
    isDisabled = false,
    size = InputSize.Medium,
    width = UDim.new(0, 0),
    isCircular = false,
    variant = ButtonVariant.Utility,
    testId = "--foundation-icon-button"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: IconButton
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = usePresentationContext()

    local image = if typeof(var1.icon) == "table" then var1.icon.name else var1.icon
    local variant = if typeof(var1.icon) == "table" then var1.icon.variant else nil
    local var5, var6

    if isBuilderOrMigratedIcon(image) then
        var5 = nil
        var6 = 1
    else
        var5, var6 = getIconScale(image, var1.size)
    end

    local var7 = useIconButtonVariants

    local size = var1.size
    local variant2 = var1.variant
    local colorNamespace = if var3 then var3.colorNamespace else nil
    local var8 = var7(var2, size, variant2, colorNamespace)

    local size2 = var8.container.size
    local uDim = if var1.isCircular then UDim.new(0, var2.Radius.Circle) else UDim.new(0, var8.container.radius or var2.Radius.Large)
    local var9 = useIconSize(var1.size, isBuilderIcon(image), true)

    local cursor = React.useMemo(function()
        return {
            radius = uDim,
            offset = var2.Size.Size_150,
            borderWidth = var2.Stroke.Thicker
        }
    end, { var2, uDim })

    local bool1 = var1.fillBehavior == FillBehavior.Fill

    local bool2 = var1.width.Scale ~= 0 or var1.width.Offset ~= 0
    local x = if bool1 then UDim.new(1, 0) elseif bool2 then var1.width else size2.X
    local createElement = React.createElement
    local var11 = View
    local var12 = withCommonProps
    local tbl2 = {
        onActivated = var1.onActivated,
        Size = UDim2.new(x, UDim.new(0, size2.Y.Offset)),
        flexItem = if var1.fillBehavior then {
            FlexMode = if var1.fillBehavior == FillBehavior.Fill then Enum.UIFlexMode.Fill else Enum.UIFlexMode.Shrink
        } else nil,
        selection = {
            Selectable = not var1.isDisabled and var1.Selectable,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = var1.NextSelectionLeft,
            NextSelectionRight = var1.NextSelectionRight
        },
        isDisabled = var1.isDisabled,
        stateLayer = var8.container.stateLayer,
        padding = var8.container.padding,
        cornerRadius = uDim,
        backgroundStyle = var8.container.style,
        stroke = var8.container.stroke,
        cursor = cursor,
        GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
        ref = ref
    }
    local var13 = var12(var1, tbl2)

    local tbl4 = { Icon = 0 }
    local element

    if isBuilderOrMigratedIcon(image) then
        element = React.createElement(Text, {
            Text = if isMigrated(image) then uiblox[image].name else image,
            fontStyle = {
                Font = BuilderIcons.Font[if isMigrated(image) then uiblox[image].variant else variant or BuilderIcons.IconVariant.Regular],
                FontSize = var9.Y.Offset
            },
            tag = "position-center-center anchor-center-center",
            Size = var9,
            textStyle = var8.content.style,
            testId = `{var1.testId}--icon`
        })
    else
        local createElement2 = React.createElement
        local var14 = Image
        local tbl5 = {
            tag = "position-center-center anchor-center-center",
            Image = image,
            Size = 0,
            imageStyle = 0,
            scale = 0,
            testId = 0
        }

        if var5 then
            var9 = UDim2.fromOffset(var5.X, var5.Y)
        end

        tbl5.Size = var9

        tbl5.imageStyle = var8.content.style
        tbl5.scale = var6
        tbl5.testId = `{var1.testId}--image`
        element = createElement2(var14, tbl5)
    end

    tbl4.Icon = element
    return createElement(var11, var13, tbl4)
end))
