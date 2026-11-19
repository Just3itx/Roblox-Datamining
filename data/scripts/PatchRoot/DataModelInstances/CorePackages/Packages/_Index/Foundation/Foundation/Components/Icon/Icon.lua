-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:01:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BuilderIcons = require(FoundationParent.BuilderIcons)
local Font = BuilderIcons.Font
local IconVariant = BuilderIcons.IconVariant

local IconSize = require(Foundation.Enums.IconSize)
local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)

local Flags = require(Foundation.Utility.Flags)
local Logger = require(Foundation.Utility.Logger)
local devAssert = require(Foundation.Utility.devAssert)
local isBuilderIcon = require(Foundation.Utility.isBuilderIcon)
local migrateFontSize = require(script.Parent.migrateFontSize)
local migrateIconName = require(script.Parent.migrateIconName)
local useIconSize = require(Foundation.Utility.useIconSize)
local useTextSizeOffset = require(Foundation.Providers.Style.useTextSizeOffset)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _Types = require(Foundation.Components.Types)

local tbl1 = {
    size = IconSize.Medium,
    variant = IconVariant.Regular,
    testId = "--foundation-icon"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Icon
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useTextSizeOffset()
    local var4 = migrateIconName(var1.name)
    local var5 = useIconSize(var1.size, isBuilderIcon(var1.name))

    local variant = var1.variant
    local name = var1.name
    local offset = if typeof(var5) == "table" then nil else var5.Y.Offset
    local bool1 = false

    if not isBuilderIcon(name) and var4 then
        if typeof(var5) ~= "table" then
            variant = var4.variant or variant
            name = var4.name
            offset = migrateFontSize(offset, var2)
            bool1 = true
        elseif Flags.FoundationDevOnlyPropAsserts then
            devAssert(false, "Binding size isn't supported when migrating a UIBlox icon, use Builder Icons directly")
        else
            error("Binding size isn't supported when migrating a UIBlox icon, use Builder Icons directly")
        end
    end

    local var6 = var1.style or var2.Color.Content.Default

    if not (isBuilderIcon(name) or bool1) then
        if arg1.variant ~= nil then
            Logger:warning("variant is not supported when using FoundationImages, consider using BuilderIcons")
        end
        return (React.createElement(
            Image,
            withCommonProps(var1, { imageStyle = var6, Image = name, Size = var5, ref = ref, Rotation = var1.Rotation }),
            var1.children
        ))
    end
    return React.createElement(
        Text,
        withCommonProps(var1, {
            textStyle = var6,
            Text = name,
            fontStyle = {
                Font = Font[variant],
                FontSize = offset
            },
            TextScaled = typeof(var5) == "table",
            Size = var5,
            ref = ref,
            Rotation = var1.Rotation
        }),
        {
            UITextSizeConstraint = if var3 > 0 and offset then React.createElement("UITextSizeConstraint", { MaxTextSize = offset }) else nil,
            Children = React.createElement(React.Fragment, nil, var1.children)
        }
    )
end))
