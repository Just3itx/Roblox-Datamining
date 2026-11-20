-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)
local MetadataSize = require(Foundation.Enums.MetadataSize)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getMultiLineTextHeight = require(Foundation.Utility.getMultiLineTextHeight)
local useTextSizeOffset = require(Foundation.Providers.Style.useTextSizeOffset)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local MetadataAccessory = require(script.Parent.MetadataAccessory)
local MetadataItems = require(script.Parent.MetadataItems)
local useMetadataVariants = require(script.Parent.useMetadataVariants)

local tbl1 = {
    size = MetadataSize.Medium,
    maxLines = 1,
    hasSeparator = true,
    testId = "--foundation-metadata"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Metadata
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useTextSizeOffset()
    local variantProps = useMetadataVariants(var2, var1.size, not var1.hasSeparator)
    local fontStyle = variantProps.text.fontStyle
    local bool1 = type(var1.text) == "string" or var1.text.text ~= nil

    local items = {}

    for _, text in bool1 and { var1.text } or var1.text do
        table.insert(items, type(text) == "string" and { text = text } or text)
    end
    local num1 = #items
    local truncateIndex = math.clamp(var1.truncateIndex or num1, 1, math.max(num1, 1))
    local var5 = if bool1 then math.max(var1.maxLines, 1) else 1
    local textHeight = getMultiLineTextHeight((fontStyle.FontSize or 0) + var3, var5, fontStyle.LineHeight or 1)
    local tbl3 = {}

    if Flags.FoundationMetadataTruncateFallback then
        tbl3.Items = React.createElement(MetadataItems, {
            items = items,
            trailing = var1.trailing,
            truncateIndex = truncateIndex,
            maxLines = var5,
            textHeight = textHeight,
            hasSeparator = var1.hasSeparator,
            size = var1.size,
            variantProps = variantProps,
            testId = var1.testId
        })
    else
        for value, value2 in items do
            if value > 1 and var1.hasSeparator then
                local str1 = `Separator{value - 1}`
                tbl3[str1] = React.createElement(Text, {
                    Text = "·",
                    tag = variantProps.text.tag,
                    LayoutOrder = value * 2 - 1,
                    testId = `{var1.testId}--separator-{value - 1}`
                })
            end

            local element = if value2.leading then React.createElement(MetadataAccessory, {
                config = value2.leading,
                variant = variantProps.accessory,
                LayoutOrder = 1,
                testId = `{var1.testId}--item-{value}--leading`
            }) else nil
            local element2 = if value == num1 and var1.trailing then React.createElement(MetadataAccessory, {
                config = var1.trailing,
                variant = variantProps.accessory,
                LayoutOrder = 4,
                testId = `{var1.testId}--trailing`
            }) else nil
            local str1 = `Item{value}`
            local createElement = React.createElement
            local var6 = View
            local tbl4 = {
                tag = if value == truncateIndex then variantProps.truncatedItem.tag else variantProps.item.tag,
                LayoutOrder = value * 2,
                testId = `{var1.testId}--item-{value}`
            }
            local tbl5 = { Leading = element, Text = 0, Trailing = 0 }
            local createElement2 = React.createElement
            local var7 = Text
            local tbl6 = {
                Text = value2.text,
                OpenTypeFeatures = variantProps.text.openTypeFeatures,
                tag = if var5 > 1 then variantProps.wrappedText.tag elseif value == truncateIndex then variantProps.truncatedText.tag else variantProps.text.tag,
                sizeConstraint = if var5 > 1 then {
                    MaxSize = Vector2.new(math.huge, textHeight)
                } else nil,
                LayoutOrder = 3,
                testId = `{var1.testId}--text-{value}`
            }
            tbl5.Text = createElement2(var7, tbl6)

            tbl5.Trailing = element2
            tbl3[str1] = createElement(var6, tbl4, tbl5)
        end
    end

    return React.createElement(View, withCommonProps(var1, { tag = variantProps.container.tag, ref = ref }), tbl3)
end))
