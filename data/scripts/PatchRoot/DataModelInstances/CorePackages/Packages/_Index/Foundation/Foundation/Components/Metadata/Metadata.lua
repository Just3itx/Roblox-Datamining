-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:21:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local AccessoryType = require(Foundation.Enums.AccessoryType)
local AvatarIcon = require(Foundation.Components.AvatarIcon)
local Icon = require(Foundation.Components.Icon)
local MetadataSize = require(Foundation.Enums.MetadataSize)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getMultiLineTextHeight = require(Foundation.Utility.getMultiLineTextHeight)
local useTextSizeOffset = require(Foundation.Providers.Style.useTextSizeOffset)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useMetadataVariants = require(script.Parent.useMetadataVariants)

local tbl1 = {
    size = MetadataSize.Medium,
    maxLines = 1,
    hasSeparator = true,
    testId = "--foundation-metadata"
}

local function MetadataAccessoryElement(tbl2)
    local variant = tbl2.variant
    local var1 = type(tbl2.config) == "string" and {
        iconName = tbl2.config
    } or tbl2.config

    if var1.type ~= AccessoryType.Avatar then
        return React.createElement(Icon, {
            name = var1.iconName,
            variant = var1.iconVariant,
            size = variant.iconSize,
            style = variant.style,
            LayoutOrder = tbl2.LayoutOrder,
            testId = tbl2.testId
        })
    end

    return React.createElement(
        View,
        {
            tag = variant.avatarTag,
            LayoutOrder = tbl2.LayoutOrder
        },
        {
            Avatar = React.createElement(AvatarIcon, { userId = var1.userId, size = variant.avatarSize, testId = tbl2.testId })
        }
    )
end
return React.memo(React.forwardRef(function(arg1, ref) -- name: Metadata
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useTextSizeOffset()
    local var4 = useMetadataVariants(var2, var1.size, not var1.hasSeparator)
    local fontStyle = var4.text.fontStyle
    local bool1 = type(var1.text) == "string" or var1.text.text ~= nil

    local tbl2 = {}

    for _, text in bool1 and { var1.text } or var1.text do
        table.insert(tbl2, type(text) == "string" and { text = text } or text)
    end
    local num1 = #tbl2
    local num2 = math.clamp(var1.truncateIndex or num1, 1, math.max(num1, 1))
    local var5 = if bool1 then math.max(var1.maxLines, 1) else 1
    local multiLineTextHeight = getMultiLineTextHeight((fontStyle.FontSize or 0) + var3, var5, fontStyle.LineHeight or 1)
    local tbl3 = ({})

    for value, value2 in tbl2 do
        if value > 1 and var1.hasSeparator then
            local str1 = `Separator{value - 1}`
            tbl3[str1] = React.createElement(Text, {
                Text = "·",
                tag = var4.text.tag,
                LayoutOrder = value * 2 - 1,
                testId = `{var1.testId}--separator-{value - 1}`
            })
        end

        local element = if value2.leading then React.createElement(MetadataAccessoryElement, {
            config = value2.leading,
            variant = var4.accessory,
            LayoutOrder = 1,
            testId = `{var1.testId}--item-{value}--leading`
        }) else nil
        local element2 = if value == num1 and var1.trailing then React.createElement(
            MetadataAccessoryElement,
            {
                config = var1.trailing,
                variant = var4.accessory,
                LayoutOrder = 4,
                testId = `{var1.testId}--trailing`
            }
        ) else nil
        local str1 = `Item{value}`
        local createElement = React.createElement
        local var6 = View
        local tbl4 = {
            tag = if value == num2 then var4.truncatedItem.tag else var4.item.tag,
            LayoutOrder = value * 2,
            testId = `{var1.testId}--item-{value}`
        }
        local tbl5 = { Leading = element, Text = 0, Trailing = 0 }
        local createElement2 = React.createElement
        local var7 = Text
        local tbl6 = {
            Text = value2.text,
            OpenTypeFeatures = var4.text.openTypeFeatures,
            tag = if var5 > 1 then var4.wrappedText.tag elseif value == num2 then var4.truncatedText.tag else var4.text.tag,
            sizeConstraint = if var5 > 1 then {
                MaxSize = Vector2.new(math.huge, multiLineTextHeight)
            } else nil,
            LayoutOrder = 3,
            testId = `{var1.testId}--text-{value}`
        }
        tbl5.Text = createElement2(var7, tbl6)

        tbl5.Trailing = element2
        tbl3[str1] = createElement(var6, tbl4, tbl5)
    end

    return React.createElement(View, withCommonProps(var1, { tag = var4.container.tag, ref = ref }), tbl3)
end))
