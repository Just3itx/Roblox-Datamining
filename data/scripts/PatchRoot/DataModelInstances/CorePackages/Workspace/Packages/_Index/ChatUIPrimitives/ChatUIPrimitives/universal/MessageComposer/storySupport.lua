-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _MessageComposer = require(script.Parent.MessageComposer)
local _Types = require(script.Parent.Parent.Types)
local PlainTextContentModel = require(script.Parent.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PresetContentModel = require(script.Parent.Parent.ContentKinds.Preset.PresetContentModel)
local EmojiContentModel = require(script.Parent.Parent.ContentKinds.Emoji.EmojiContentModel)

local module = {
    noopDelivery = {
        sendMessageDraft = function(_) end
    }
}
function module.draftLabel(arg1): string
    local tbl1 = {}
    for _, content in arg1.contents do
        local draft = PlainTextContentModel.getDraft(content)
        if draft then
            table.insert(tbl1, `plainText "{draft.text}"`)
        end
        local draft2 = PresetContentModel.getDraft(content)
        if draft2 then
            table.insert(tbl1, `preset "{draft2.presetId}" "{draft2.displayText}"`)
        end
        local draft3 = EmojiContentModel.getDraft(content)
        if draft3 then
            table.insert(tbl1, `emoji "{draft3.emojiId}" {draft3.unicode}`)
        end
    end
    if #tbl1 == 0 then
        return "(no content)"
    end
    return table.concat(tbl1, ", ")
end

function module.useEventLog()
    local var1, var2 = React.useState({})
    return var1, (React.useCallback(function(str1: string)
        var2(function(tbl1)
            local var3 = table.clone(tbl1)
            table.insert(var3, str1)
            return var3
        end)
    end, {}))
end

function module.useDeliveryLog()
    local entries, var2 = module.useEventLog()

    local sendMessageDraft = React.useCallback(function(arg1)
        var2(`sent: {module.draftLabel(arg1)}`)
    end, { var2 })

    return {
        messageDelivery = React.useMemo(function()
            return { sendMessageDraft = sendMessageDraft }
        end, { sendMessageDraft }),
        entries = entries
    }
end

function module.LogPanel(tbl1)
    local tbl2 = {}
    local num1 = 0
    for value, value2 in tbl1.header or {} do
        num1 += 1
        tbl2[`header-{value}`] = React.createElement(
            Foundation.Text,
            {
                tag = "size-full-0 auto-y text-wrap text-align-x-left text-caption-medium",
                Text = value2,
                LayoutOrder = num1
            }
        )
    end

    if #tbl1.lines == 0 then
        local layoutOrder = num1 + 1
        tbl2.empty = React.createElement(Foundation.Text, {
            tag = "content-muted size-full-0 auto-y text-wrap text-align-x-left text-caption-medium",
            Text = tbl1.emptyText,
            LayoutOrder = layoutOrder
        })
    else
        for value, value2 in tbl1.lines do
            num1 += 1
            tbl2[`line-{value}`] = React.createElement(
                Foundation.Text,
                {
                    tag = "size-full-0 auto-y text-wrap text-align-x-left text-caption-medium",
                    Text = value2,
                    LayoutOrder = num1
                }
            )
        end
    end
    return React.createElement(
        Foundation.View,
        {
            tag = "col gap-xsmall auto-y",
            Size = UDim2.fromOffset(300, 0),
            LayoutOrder = tbl1.LayoutOrder
        },
        tbl2
    )
end

function module.Layout(tbl1)
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "row gap-large auto-xy" }

    local tbl3 = {
        composerColumn = React.createElement(
            Foundation.View,
            {
                tag = "col gap-medium auto-y",
                Size = UDim2.fromOffset(400, 0),
                LayoutOrder = 1
            },
            {
                toolbar = if tbl1.toolbar then React.createElement(Foundation.View, { tag = "size-full-0 auto-y", LayoutOrder = 1 }, tbl1.toolbar) else nil,
                composer = React.createElement(Foundation.View, { tag = "size-full-0 auto-y", LayoutOrder = 2 }, tbl1.composer)
            }
        ),
        panel = if tbl1.panel then React.createElement(Foundation.View, { tag = "auto-xy", LayoutOrder = 2 }, tbl1.panel) else nil
    }
    return createElement(view, tbl2, tbl3)
end

return module
