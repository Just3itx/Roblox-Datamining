-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _MetadataSize = require(Foundation.Enums.MetadataSize)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local useTextSizeOffset = require(Foundation.Providers.Style.useTextSizeOffset)

local MetadataItem = require(script.Parent.MetadataItem)
local _useMetadataVariants = require(script.Parent.useMetadataVariants)
local useTruncationFallback = require(script.Parent.useTruncationFallback)

local function MetadataItems(tbl1)
    local itemsLen = #tbl1.items
    local var1 = React.useMemo(function()
        local tbl2 = {
            [tbl1.truncateIndex] = 0
        }
        local num1 = 1
        for i = 1, itemsLen do
            if i ~= tbl1.truncateIndex then
                tbl2[i] = num1
                num1 += 1
            end
        end
        return tbl2
    end, { itemsLen, tbl1.truncateIndex })
    local var2 = useTextSizeOffset()
    local var3 = React.useMemo(function()
        local tbl2 = {}
        for _, item in tbl1.items do
            local leading = item.leading
            table.insert(
                tbl2,
                `{if leading == nil then "" elseif type(leading) == "string" then "icon" else leading.type}:{item.text}`
            )
        end

        return table.concat({
            tostring(tbl1.truncateIndex),
            tbl1.size,
            tostring(tbl1.hasSeparator),
            tostring(tbl1.trailing ~= nil),
            tostring(var2),
            table.concat(tbl2, "\0")
        }, "|")
    end, {
        tbl1.items,
        tbl1.truncateIndex,
        tbl1.size,
        tbl1.hasSeparator,
        tbl1.trailing,
        var2
    })
    local var4 = useTruncationFallback(var3, itemsLen, tbl1.variantProps.text.fontStyle)
    local var5 = React.useMemo(function()
        local result = ({})
        for i = 0, itemsLen - 1 do
            result[i] = function(arg1)
                var4.onSizeChanged(i, arg1)
            end
        end
        return result
    end, { itemsLen, var4.onSizeChanged })
    local tbl2 = ({})

    for index, item in tbl1.items do
        local var6 = var1[index]
        local shrinkRatio = var4.getShrinkRatio(var6)
        if index > 1 and tbl1.hasSeparator then
            local str1 = `Separator{index - 1}`
            tbl2[str1] = React.createElement(Text, {
                Text = "·",
                tag = tbl1.variantProps.text.tag,
                LayoutOrder = index * 2 - 1,
                testId = `{tbl1.testId}--separator-{index - 1}`
            })
        end

        local bool1 = itemsLen > 1 and shrinkRatio ~= nil
        local str1 = `Item{index}`
        tbl2[str1] = React.createElement(MetadataItem, {
            index = index,
            text = item.text,
            leading = item.leading,
            trailing = if index == itemsLen then tbl1.trailing else nil,
            variantProps = tbl1.variantProps,
            isWrapped = tbl1.maxLines > 1,
            textHeight = tbl1.textHeight,
            shrinkRatio = shrinkRatio,
            minTextWidth = if bool1 and var4.isPinned(var6) then var4.minWidth else nil,
            onTextSizeChanged = if bool1 and var4.isDeciding(var6) then var5[var6] else nil,
            LayoutOrder = index * 2,
            testId = tbl1.testId
        })
    end

    return React.createElement(React.Fragment, nil, tbl2)
end

return MetadataItems
