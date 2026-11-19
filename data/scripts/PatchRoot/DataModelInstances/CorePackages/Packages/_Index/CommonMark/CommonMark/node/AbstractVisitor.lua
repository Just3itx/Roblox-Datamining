-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _BlockQuote = require(CommonMark.node.BlockQuote)
local _BulletList = require(CommonMark.node.BulletList)
local _Code = require(CommonMark.node.Code)
local _CustomBlock = require(CommonMark.node.CustomBlock)
local _CustomNode = require(CommonMark.node.CustomNode)
local _Document = require(CommonMark.node.Document)
local _Emphasis = require(CommonMark.node.Emphasis)
local _FencedCodeBlock = require(CommonMark.node.FencedCodeBlock)
local _HardLineBreak = require(CommonMark.node.HardLineBreak)
local _Heading = require(CommonMark.node.Heading)
local _HtmlBlock = require(CommonMark.node.HtmlBlock)
local _HtmlInline = require(CommonMark.node.HtmlInline)
local _Image = require(CommonMark.node.Image)
local _IndentedCodeBlock = require(CommonMark.node.IndentedCodeBlock)
local _Link = require(CommonMark.node.Link)
local _LinkReferenceDefinition = require(CommonMark.node.LinkReferenceDefinition)
local _ListItem = require(CommonMark.node.ListItem)
local _Node = require(CommonMark.node.Node)
local _OrderedList = require(CommonMark.node.OrderedList)
local _Paragraph = require(CommonMark.node.Paragraph)
local _SoftLineBreak = require(CommonMark.node.SoftLineBreak)
local _StrongEmphasis = require(CommonMark.node.StrongEmphasis)
local _Text = require(CommonMark.node.Text)
local _ThematicBreak = require(CommonMark.node.ThematicBreak)

local module = {}
module.__index = module

function module.visitBlockQuote(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitBulletList(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitCode(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitDocument(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitEmphasis(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitFencedCodeBlock(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitHardLineBreak(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitHeading(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitThematicBreak(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitHtmlInline(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitHtmlBlock(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitImage(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitIndentedCodeBlock(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitLink(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitListItem(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitOrderedList(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitParagraph(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitSoftLineBreak(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitStrongEmphasis(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitText(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitLinkReferenceDefinition(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitCustomBlock(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitCustomNode(arg1, arg2)
    arg1:visitChildren(arg2)
end

function module.visitChildren(arg1, arg2)
    local firstChild = arg2:getFirstChild()

    while firstChild ~= nil do
        local next = firstChild:getNext()
        firstChild:accept(arg1)
        firstChild = next
    end
end

return module
