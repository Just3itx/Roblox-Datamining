-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Cryo = require(AuthCommonParent.Cryo)
local InlineLayout = require(AuthCommonParent.InlineLayout)
local _InlineRichText = require(AuthCommonParent.InlineRichText)

local TextElement = InlineLayout.Components.InlineLayoutElements.TextElement
local LinkElement = InlineLayout.Components.InlineLayoutElements.LinkElement

local tbl1 = {
    name = "u",
    attributes = {}
}

local function createLegalLinkRenderer(callback: (...any) -> (...any))
    return function(arg1, arg2): {[any]: any} | {any}
        local href = arg1.attributes.href or ""
        local var1 = arg2.processChildren(arg1, arg2)
        local var2 = Cryo.List.map(var1, function(arg3, layoutOrder)
            return TextElement.new({
                LayoutOrder = layoutOrder,
                EngineTags = Cryo.List.join({ tbl1 }, arg3.engineTags),
                Text = arg3.text,
                fontStyle = arg2.styles.fontStyle,
                textStyle = arg2.styles.textStyle
            })
        end)

        return if #var2 == 0 then {} else {
            LinkElement.new(var2, {
                onActivated = function()
                    callback(href)
                end
            })
        }
    end
end

return createLegalLinkRenderer
