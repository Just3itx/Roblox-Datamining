-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:20:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Avatar = require(Foundation.Components.Avatar)
local Badge = require(Foundation.Components.Badge)
local Icon = require(Foundation.Components.Icon)
local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local Flags = require(Foundation.Utility.Flags)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon
local normalizeIconName = iconMigrationUtils.normalizeIconName

local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local _Tokens = require(Foundation.Providers.Style.Tokens)

local AccessoryType = require(Foundation.Enums.AccessoryType)
local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local _InputSize = require(Foundation.Enums.InputSize)

local value = {
    colorNamespace = ColorNamespace.Color,
    isIconSize = true
}

local function Accessory(tbl2)
    local accessory = tbl2.accessory
    if accessory == nil then
        return nil
    end

    local tag = `align-x-center align-y-center {tbl2.iconVariant.tag}`

    if accessory.type == AccessoryType.Avatar then
        return React.createElement(View, {
            LayoutOrder = tbl2.LayoutOrder,
            tag = tag,
            testId = tbl2.testId
        }, {
            Avatar = React.createElement(PresentationContext.Provider, { value = value }, {
                Avatar = React.createElement(
                    Avatar,
                    {
                        userId = accessory.userId,
                        backplateStyle = tbl2.tokens.Color.Shift.Shift_200,
                        size = tbl2.size
                    }
                )
            })
        })
    end
    if accessory.type == "Hint" then
        return React.createElement(
            View,
            {
                LayoutOrder = tbl2.LayoutOrder,
                tag = "row align-y-center auto-xy padding-x-xsmall radius-small bg-shift-200",
                testId = tbl2.testId
            },
            {
                Text = React.createElement(Text, { Text = accessory.text, tag = "auto-xy text-caption-medium content-muted" })
            }
        )
    elseif accessory.type == "Badge" then
        return React.createElement(Badge, {
            LayoutOrder = tbl2.LayoutOrder,
            text = accessory.text,
            icon = accessory.icon,
            variant = accessory.variant,
            testId = tbl2.testId
        })
    end

    if Flags.FoundationBaseMenuAccessorySizing and not isBuilderOrMigratedIcon(accessory.iconName) then
        return React.createElement(View, {
            LayoutOrder = tbl2.LayoutOrder,
            tag = tag,
            testId = tbl2.testId
        }, {
            Media = React.createElement(Image, {
                Image = accessory.iconName,
                ScaleType = Enum.ScaleType.Crop,
                tag = "size-full-full radius-xsmall",
                testId = `{tbl2.testId}--media`
            })
        })
    end

    local var1 = if Flags.FoundationBaseMenuAccessorySizing then normalizeIconName(accessory.iconName) else nil
    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        LayoutOrder = tbl2.LayoutOrder,
        tag = tag,
        testId = tbl2.testId
    }
    local tbl4 = {
        Icon = React.createElement(Icon, {
            name = if Flags.FoundationBaseMenuAccessorySizing then var1.name else accessory.iconName,
            variant = if Flags.FoundationBaseMenuAccessorySizing then var1.variant or accessory.iconVariant else accessory.iconVariant,
            style = tbl2.iconVariant.style,
            size = tbl2.iconVariant.size
        })
    }
    return createElement(var2, tbl3, tbl4)
end

return Accessory
