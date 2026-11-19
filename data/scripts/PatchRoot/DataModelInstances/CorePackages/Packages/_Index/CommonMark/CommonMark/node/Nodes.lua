-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local BlockQuote = require(CommonMark.node.BlockQuote)
local BulletList = require(CommonMark.node.BulletList)
local Code = require(CommonMark.node.Code)
local _CustomBlock = require(CommonMark.node.CustomBlock)
local _CustomNode = require(CommonMark.node.CustomNode)
local _Delimited = require(CommonMark.node.Delimited)
local Document = require(CommonMark.node.Document)
local Emphasis = require(CommonMark.node.Emphasis)
local FencedCodeBlock = require(CommonMark.node.FencedCodeBlock)
local HardLineBreak = require(CommonMark.node.HardLineBreak)
local Heading = require(CommonMark.node.Heading)
local HtmlBlock = require(CommonMark.node.HtmlBlock)
local HtmlInline = require(CommonMark.node.HtmlInline)
local Image = require(CommonMark.node.Image)
local IndentedCodeBlock = require(CommonMark.node.IndentedCodeBlock)
local Link = require(CommonMark.node.Link)
local LinkReferenceDefinition = require(CommonMark.node.LinkReferenceDefinition)
local _ListBlock = require(CommonMark.node.ListBlock)
local ListItem = require(CommonMark.node.ListItem)
local _Node = require(CommonMark.node.Node)
local module = {
    BlockQuote = BlockQuote,
    BulletList = BulletList,
    Code = Code,
    Document = Document,
    Emphasis = Emphasis,
    FencedCodeBlock = FencedCodeBlock,
    HardLineBreak = HardLineBreak,
    Heading = Heading,
    HtmlBlock = HtmlBlock,
    HtmlInline = HtmlInline,
    Image = Image,
    IndentedCodeBlock = IndentedCodeBlock,
    Link = Link,
    LinkReferenceDefinition = LinkReferenceDefinition,
    ListItem = ListItem,
    OrderedList = require(CommonMark.node.OrderedList),
    Paragraph = require(CommonMark.node.Paragraph),
    SoftLineBreak = require(CommonMark.node.SoftLineBreak),
    StrongEmphasis = require(CommonMark.node.StrongEmphasis),
    Text = require(CommonMark.node.Text),
    ThematicBreak = require(CommonMark.node.ThematicBreak)
}

function module.between(arg1, arg2)
    local next = arg1:getNext()
    return function()
        if next == nil or next == arg2 then
            return nil
        end

        local var1 = next
        next = var1:getNext()
        return var1
    end
end

return module
