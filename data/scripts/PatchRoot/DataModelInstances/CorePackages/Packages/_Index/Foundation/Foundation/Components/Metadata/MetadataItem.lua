-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local AccessoryType = require(Foundation.Enums.AccessoryType)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local MetadataAccessory = require(script.Parent.MetadataAccessory)
local _useMetadataVariants = require(script.Parent.useMetadataVariants)

return React.memo(function(tbl1) -- name: MetadataItem
    local var1 = React.useCallback(function(arg1)
        if arg1 == nil then
            return 0
        end

        return (if type(arg1) ~= "string" and arg1.type == AccessoryType.Avatar then tbl1.variantProps.accessory.avatarWidth else tbl1.variantProps.accessory.width) + tbl1.variantProps.item.gap
    end, { tbl1.variantProps.accessory, tbl1.variantProps.item.gap })

    local x = if tbl1.minTextWidth then tbl1.minTextWidth + var1(tbl1.leading) + var1(tbl1.trailing) else nil
    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = tbl1.variantProps.item.tag,
        flexItem = tbl1.shrinkRatio and {
            FlexMode = Enum.UIFlexMode.Custom,
            ShrinkRatio = tbl1.shrinkRatio,
            GrowRatio = 0
        } or nil,
        sizeConstraint = x and {
            MinSize = Vector2.new(x, 0)
        } or nil,
        LayoutOrder = tbl1.LayoutOrder,
        testId = `{tbl1.testId}--item-{tbl1.index}`
    }
    local tbl3 = {
        Leading = if tbl1.leading then React.createElement(MetadataAccessory, {
            config = tbl1.leading,
            variant = tbl1.variantProps.accessory,
            LayoutOrder = 1,
            testId = `{tbl1.testId}--item-{tbl1.index}--leading`
        }) else nil,
        Text = React.createElement(Text, {
            Text = tbl1.text,
            OpenTypeFeatures = tbl1.variantProps.text.openTypeFeatures,
            tag = if tbl1.isWrapped then tbl1.variantProps.wrappedText.tag elseif tbl1.shrinkRatio then tbl1.variantProps.truncatedText.tag else tbl1.variantProps.text.tag,
            sizeConstraint = tbl1.isWrapped and {
                MaxSize = Vector2.new(math.huge, tbl1.textHeight)
            } or nil,
            onAbsoluteSizeChanged = tbl1.onTextSizeChanged,
            LayoutOrder = 3,
            testId = `{tbl1.testId}--text-{tbl1.index}`
        }),
        Trailing = if tbl1.trailing then React.createElement(MetadataAccessory, {
            config = tbl1.trailing,
            variant = tbl1.variantProps.accessory,
            LayoutOrder = 4,
            testId = `{tbl1.testId}--trailing`
        }) else nil
    }
    return createElement(var2, tbl2, tbl3)
end)
