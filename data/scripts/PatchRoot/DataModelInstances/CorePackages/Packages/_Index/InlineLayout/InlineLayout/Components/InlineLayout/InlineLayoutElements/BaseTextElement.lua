-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParent = script:FindFirstAncestor("Components").Parent
local ComponentsParentParent = ComponentsParent.Parent

local React = require(ComponentsParentParent.React)
local Dash = require(ComponentsParentParent.Dash)

local isCli = require(ComponentsParentParent.MarkdownCore).Utils.isCli
local TextSplitBy = require(ComponentsParent.Enums.TextSplitBy)

local SplitText = require(ComponentsParent.Utils.SplitText)
local _Types = require(ComponentsParent.Types)
local Escape = require(ComponentsParentParent.MarkdownCore).Utils.Escape

local InlineElementType = require(ComponentsParent.Utils.InlineElementType)
local getFontFace = require(ComponentsParent.Utils.getFontFace)

local join = Dash.join

local tbl1 = {}

local function formatTextWithEngineTag(str1: string, arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = Dash.reduce(arg1.attributes, function(arg2, arg3, arg4): string
        local str2 = if string.find(arg3, "\"") then "'" else "\""
        return `{arg2} {arg4}={str2}{arg3}{str2}`
    end, "")
    return `<{arg1.name}{var1}>{str1}</{arg1.name}>`
end

local function getRichText(text: string, engineTags) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = Escape.escapeRichFormatting(text)
    return (Dash.reduce(engineTags, function(arg1, arg2): string
        return formatTextWithEngineTag(arg1, arg2)
    end, var1))
end

local module = {}
module.__index = module
module.__type = InlineElementType

function module.new(element: (...any) -> (...any), props, mapProps: ((...any) -> (...any))?)
    local self = setmetatable({}, module)
    self.props = props
    self.mapProps = mapProps or Dash.identity
    self.Element = element
    self.canForceSplit = self.splitBy ~= TextSplitBy.Symbol
    self.splitBy = if self.props.SplitBy then self.props.SplitBy else TextSplitBy.Word

    self.hasRichText = not (self.props.EngineTags == nil) and next(self.props.EngineTags) ~= nil
    if self.hasRichText and self.props.Text then
        self.props = Dash.assign(self.props, { Text = Escape.unescapeRichFormatting(self.props.Text) })
    end
    return self
end

function module:_clone(arg1)
    return module.new(self.Element, arg1 or self.props, self.mapProps)
end

local TextService = game:GetService("TextService")

if isCli() then
    local tbl2 = {}
    tbl2.__index = tbl2
    TextService = setmetatable({}, tbl2)
    function tbl2.GetTextBoundsAsync(_)
        return { X = 100 }
    end
end

function module:getWidth()
    return self:_getWidth(self.props.Text)
end

function module:_getWidth(getTextBoundsParamsText: string)
    local getTextBoundsParams = Instance.new("GetTextBoundsParams")
    getTextBoundsParams.Font = getFontFace(self.props.fontStyle)
    getTextBoundsParams.Size = self.props.fontStyle.FontSize
    getTextBoundsParams.Text = getTextBoundsParamsText
    if self.hasRichText then
        local engineTags = self.props.EngineTags
        local var1 = Escape.escapeRichFormatting(getTextBoundsParamsText)
        getTextBoundsParams.Text = Dash.reduce(engineTags, function(arg1, arg2): string
            return formatTextWithEngineTag(arg1, arg2)
        end, var1)
        getTextBoundsParams.RichText = true
    end

    local success, result = pcall(function()
        return TextService:GetTextBoundsAsync(getTextBoundsParams).X
    end)

    if success then
        return result
    end

    if not tbl1[getTextBoundsParams.Text] then
        tbl1[getTextBoundsParams.Text] = true
        warn(`Failed to get width for the {getTextBoundsParams.Text} in BaseTextElement`)
    end

    getTextBoundsParams.RichText = false
    return TextService:GetTextBoundsAsync(getTextBoundsParams).X
end

function module:split(num1: number, bool1: boolean?)
    bool1 = self.canForceSplit and bool1
    local var1 = SplitText
    local var2 = if bool1 then TextSplitBy.Symbol else self.splitBy

    local var3, var4 = var1(var2, function(arg1)
        return self:_getWidth(arg1)
    end, self.props.Text, num1)

    local var5 = self:_clone(join(self.props, { Text = var3 }))

    if var4 then
        return var5, (self:_clone(join(self.props, { Text = var4:gsub("^%s*", "") })))
    end

    return var5, nil
end

function module:trimStart()
    local propsText = self.props.Text
    if propsText == nil then
        return self
    end
    local var1 = propsText:gsub("^%s+", "")
    if var1 == "" then
        return nil
    elseif var1 == propsText then
        return self
    end
    return self:_clone(join(self.props, { Text = var1 }))
end

function module:render(id, layoutOrder: number)
    local propsText = self.props.Text
    if self.hasRichText and self.props.Text and self.props.EngineTags then
        propsText = getRichText(self.props.Text, self.props.EngineTags)
    end
    return React.createElement(
        self.Element,
        self.mapProps(
            join(self.props, {
                id = id,
                Text = propsText,
                RichText = self.hasRichText,
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = layoutOrder,
                key = tostring(layoutOrder),
                EngineTags = Dash.None
            })
        )
    )
end
return module
