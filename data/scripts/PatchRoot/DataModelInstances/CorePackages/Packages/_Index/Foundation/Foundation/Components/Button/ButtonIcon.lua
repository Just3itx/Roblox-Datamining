-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox

local React = require(FoundationParent.React)

local _ButtonVariant = require(Foundation.Enums.ButtonVariant)

local _InputSize = require(Foundation.Enums.InputSize)

local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)

local getIconScale = require(Foundation.Utility.getIconScale)

local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon

local useButtonVariants = require(script.Parent.useButtonVariants)
local useTextSizeOffset = require(Foundation.Providers.Style.useTextSizeOffset)
local useTokens = require(Foundation.Providers.Style.useTokens)
local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext

local function ButtonIcon(tbl1)
    local disabledTransparencyBinding = tbl1.disabledTransparencyBinding
    local textTransparencyBinding = tbl1.textTransparencyBinding

    local var1 = useTokens()
    local var2 = useTextSizeOffset()
    local var3, scale = getIconScale(tbl1.icon, tbl1.size)
    local var5 = usePresentationContext()
    local var6 = useButtonVariants(var1, tbl1.size, tbl1.variant, if var5 then var5.colorNamespace else nil)

    if not tbl1.icon then
        return nil
    end

    if not isBuilderOrMigratedIcon(tbl1.icon) then
        return React.createElement(Image, {
            tag = "position-center-center anchor-center-center",
            Image = tbl1.icon,
            Size = if var3 then UDim2.fromOffset(var3.X, var3.Y) else var6.icon.size,
            imageStyle = React.joinBindings({ disabledTransparencyBinding, textTransparencyBinding }):map(function(arg1)
                local var7 = arg1[1]
                local var8 = arg1[2]
                return {
                    Color3 = var6.content.style.Color3,
                    Transparency = var8 + var7
                }
            end),
            scale = scale,
            testId = `{tbl1.testId}--icon`
        })
    end

    return React.createElement(Text, {
        Text = if isMigrated(tbl1.icon) then uiblox[tbl1.icon].name else tbl1.icon,
        fontStyle = {
            Font = BuilderIcons.Font[if isMigrated(tbl1.icon) then uiblox[tbl1.icon].variant else BuilderIcons.IconVariant.Regular],
            FontSize = var6.icon.size.Y.Offset
        },
        tag = "position-center-center anchor-center-center",
        Size = var6.icon.size,
        textStyle = React.joinBindings({ disabledTransparencyBinding, textTransparencyBinding }):map(function(arg1)
            local var7 = arg1[1]
            local var8 = arg1[2]
            return {
                Color3 = var6.content.style.Color3,
                Transparency = var8 + var7
            }
        end),
        testId = `{tbl1.testId}--icon`
    }, {
        UITextSizeConstraint = if var2 > 0 then React.createElement("UITextSizeConstraint", { MaxTextSize = var6.icon.size.Y.Offset }) else nil
    })
end

return ButtonIcon
