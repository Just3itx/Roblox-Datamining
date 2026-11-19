-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:40:50Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractVisitor = require(CommonMark.node.AbstractVisitor)
local _HtmlNodeRendererContext = require(CommonMark.renderer.html.HtmlNodeRendererContext)
local _HtmlWriter = require(CommonMark.renderer.html.HtmlWriter)
local LinkedHashMap = require(CommonMark.internal.port.LinkedHashMap)
local _Nodes = require(CommonMark.node.Nodes)

local find = string.find
local sub = string.sub

local var1 = setmetatable({}, { __index = AbstractVisitor })
var1.__index = var1

function var1.new()
    return (setmetatable({ _sb = {}, _n = 0 }, var1))
end

function var1:getAltText(): string
    return table.concat(self._sb)
end

local function orNull(literal: string?): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return if literal == nil then "null" else literal
end

function var1:visitText(arg1)
    self._n += 1
    self._sb[self._n] = orNull(arg1.literal)
end

function var1:visitCode(arg1)
    self._n += 1
    self._sb[self._n] = orNull(arg1.literal)
end

function var1:visitSoftLineBreak(_)
    self._n += 1
    self._sb[self._n] = "\n"
end

function var1:visitHardLineBreak(_)
    self._n += 1
    self._sb[self._n] = "\n"
end

local var2 = setmetatable({}, { __index = AbstractVisitor })
var2.__index = var2

function var2.new(context)
    return (setmetatable({ context = context, _html = context:getWriter() }, var2))
end

local getNodeTypes = table.freeze({
    "Document",
    "Heading",
    "Paragraph",
    "BlockQuote",
    "BulletList",
    "FencedCodeBlock",
    "HtmlBlock",
    "ThematicBreak",
    "IndentedCodeBlock",
    "Link",
    "ListItem",
    "OrderedList",
    "Image",
    "Emphasis",
    "StrongEmphasis",
    "Text",
    "Code",
    "HtmlInline",
    "SoftLineBreak",
    "HardLineBreak"
})

function var2.getNodeTypes(_)
    return getNodeTypes
end

function var2.render(arg1, arg2)
    arg2:accept(arg1)
end

function var2.visitDocument(arg1, arg2)
    arg1:visitChildren(arg2)
end

function var2:visitHeading(arg1)
    local str1 = `h{arg1.level}`
    self._html:line()
    self._html:tag(str1, self:getAttrs(arg1, str1))
    self:visitChildren(arg1)
    self._html:tag("/" .. str1)
    self._html:line()
end

function var2:visitParagraph(arg1)
    local parent = arg1:getParent()
    local bool1 = self:isInTightList(arg1)

    if not bool1 then
        bool1 = self.context:shouldOmitSingleParagraphP()

        if bool1 then
            if parent == nil or parent.kind ~= "Document" or arg1:getPrevious() ~= nil then
                bool1 = false
            else
                bool1 = arg1:getNext() == nil
            end
        end
    end

    if not bool1 then
        self._html:line()
        self._html:tag("p", self:getAttrs(arg1, "p"))
    end
    self:visitChildren(arg1)
    if not bool1 then
        self._html:tag("/p")
        self._html:line()
    end
end

function var2:visitBlockQuote(arg1)
    self._html:line()
    self._html:tag("blockquote", self:getAttrs(arg1, "blockquote"))
    self._html:line()
    self:visitChildren(arg1)
    self._html:line()
    self._html:tag("/blockquote")
    self._html:line()
end

function var2.visitBulletList(arg1, arg2)
    arg1:renderListBlock(arg2, "ul", arg1:getAttrs(arg2, "ul"))
end

function var2.visitFencedCodeBlock(arg1, arg2)
    local literal = arg2.literal
    local linkedHashMap = LinkedHashMap.new()
    local info = arg2.info
    if info ~= nil and info ~= "" then
        local var4 = (find(info, " ", 1, true) or 0) - 1

        if var4 ~= -1 then
            info = sub(info, 1, var4)
        end
        linkedHashMap:put("class", "language-" .. info)
    end
    arg1:renderCodeBlock(literal, arg2, linkedHashMap)
end

function var2:visitHtmlBlock(arg1)
    self._html:line()
    if self.context:shouldEscapeHtml() then
        self._html:tag("p", self:getAttrs(arg1, "p"))
        self._html:text(arg1.literal)
        self._html:tag("/p")
    else
        self._html:raw(arg1.literal)
    end
    self._html:line()
end

function var2:visitThematicBreak(arg1)
    self._html:line()
    self._html:tag("hr", self:getAttrs(arg1, "hr"), true)
    self._html:line()
end

function var2.visitIndentedCodeBlock(arg1, arg2)
    arg1:renderCodeBlock(arg2.literal, arg2, LinkedHashMap.of())
end

function var2:visitLink(arg1)
    local linkedHashMap = LinkedHashMap.new()
    local destination = arg1.destination

    if self.context:shouldSanitizeUrls() then
        destination = self.context:urlSanitizer():sanitizeLinkUrl(destination)
        linkedHashMap:put("rel", "nofollow")
    end

    linkedHashMap:put("href", (self.context:encodeUrl(destination)))
    if arg1.title ~= nil then
        linkedHashMap:put("title", arg1.title)
    end
    self._html:tag("a", self:getAttrs(arg1, "a", linkedHashMap))
    self:visitChildren(arg1)
    self._html:tag("/a")
end

function var2:visitListItem(arg1)
    self._html:tag("li", self:getAttrs(arg1, "li"))
    self:visitChildren(arg1)
    self._html:tag("/li")
    self._html:line()
end

function var2.visitOrderedList(arg1, arg2)
    local var4 = if arg2.markerStartNumber == nil then 1 else arg2.markerStartNumber
    local linkedHashMap = LinkedHashMap.new()
    if var4 ~= 1 then
        linkedHashMap:put("start", tostring(var4))
    end
    arg1:renderListBlock(arg2, "ol", arg1:getAttrs(arg2, "ol", linkedHashMap))
end

function var2:visitImage(arg1)
    local destination = arg1.destination

    local var4 = var1.new()
    arg1:accept(var4)
    local altText = var4:getAltText()

    local linkedHashMap = LinkedHashMap.new()
    if self.context:shouldSanitizeUrls() then
        destination = self.context:urlSanitizer():sanitizeImageUrl(destination)
    end

    linkedHashMap:put("src", self.context:encodeUrl(destination))
    linkedHashMap:put("alt", altText)
    if arg1.title ~= nil then
        linkedHashMap:put("title", arg1.title)
    end

    self._html:tag("img", self:getAttrs(arg1, "img", linkedHashMap), true)
end

function var2:visitEmphasis(arg1)
    self._html:tag("em", self:getAttrs(arg1, "em"))
    self:visitChildren(arg1)
    self._html:tag("/em")
end

function var2:visitStrongEmphasis(arg1)
    self._html:tag("strong", self:getAttrs(arg1, "strong"))
    self:visitChildren(arg1)
    self._html:tag("/strong")
end

function var2:visitText(arg1)
    self._html:text(arg1.literal)
end

function var2:visitCode(arg1)
    self._html:tag("code", self:getAttrs(arg1, "code"))
    self._html:text(arg1.literal)
    self._html:tag("/code")
end

function var2:visitHtmlInline(arg1)
    if self.context:shouldEscapeHtml() then
        self._html:text(arg1.literal)
        return
    end
    self._html:raw(arg1.literal)
end

function var2:visitSoftLineBreak(_)
    self._html:raw(self.context:getSoftbreak())
end

function var2:visitHardLineBreak(arg1)
    self._html:tag("br", self:getAttrs(arg1, "br"), true)
    self._html:line()
end

function var2:visitChildren(arg1)
    local firstChild = arg1:getFirstChild()
    while firstChild ~= nil do
        local next = firstChild:getNext()
        self.context:render(firstChild)
        firstChild = next
    end
end

function var2:renderCodeBlock(str1: string, arg1, arg2)
    self._html:line()
    self._html:tag("pre", self:getAttrs(arg1, "pre"))
    self._html:tag("code", self:getAttrs(arg1, "code", arg2))
    self._html:text(str1)
    self._html:tag("/code")
    self._html:tag("/pre")
    self._html:line()
end

function var2:renderListBlock(arg1, str1: string, arg2)
    self._html:line()
    self._html:tag(str1, arg2)
    self._html:line()
    self:visitChildren(arg1)
    self._html:line()
    self._html:tag("/" .. str1)
    self._html:line()
end

function var2:isInTightList(arg1)
    local parent = arg1:getParent()
    if parent ~= nil then
        local parent2 = parent:getParent()
        if parent2 ~= nil and (parent2.kind == "BulletList" or parent2.kind == "OrderedList") then
            return parent2.tight
        end
    end
    return false
end

function var2:getAttrs(arg1, str1: string, arg2)
    local context = self.context

    if arg2 == nil then
        arg2 = LinkedHashMap.of()
    end

    return context:extendAttributes(arg1, str1, arg2)
end

return var2
