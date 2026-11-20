-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local AccessoryType = require(Foundation.Enums.AccessoryType)
local AvatarIcon = require(Foundation.Components.AvatarIcon)
local Icon = require(Foundation.Components.Icon)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local _useMetadataVariants = require(script.Parent.useMetadataVariants)

local function MetadataAccessoryElement(tbl1)
    local variant = tbl1.variant
    local var1 = type(tbl1.config) == "string" and {
        iconName = tbl1.config
    } or tbl1.config

    if var1.type ~= AccessoryType.Avatar then
        return React.createElement(Icon, {
            name = var1.iconName,
            variant = var1.iconVariant,
            size = variant.iconSize,
            style = variant.style,
            LayoutOrder = tbl1.LayoutOrder,
            testId = tbl1.testId
        })
    end

    return React.createElement(
        View,
        {
            tag = variant.avatarTag,
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            Avatar = React.createElement(AvatarIcon, { userId = var1.userId, size = variant.avatarSize, testId = tbl1.testId })
        }
    )
end
return MetadataAccessoryElement
