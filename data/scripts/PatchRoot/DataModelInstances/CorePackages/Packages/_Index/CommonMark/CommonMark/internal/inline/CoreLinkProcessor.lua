-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _InlineParserContext = require(CommonMark.parser.InlineParserContext)
local _LinkInfo = require(CommonMark.parser.beta.LinkInfo)
local _LinkProcessor = require(CommonMark.parser.beta.LinkProcessor)
local LinkResult = require(CommonMark.parser.beta.LinkResult)
local Nodes = require(CommonMark.node.Nodes)
local _Scanner = require(CommonMark.parser.beta.Scanner)

local module = {}
module.__index = module

function module.new(bool1: boolean?, bool2: boolean?)
    return (setmetatable({ _linkEnabled = bool1 ~= false, _imageEnabled = bool2 ~= false }, module))
end

local function process(tbl1, arg1, arg2, str1: string?, str2: string?)
    local var1 = arg1:marker()
    if var1 ~= nil and var1.literal == "!" and tbl1._imageEnabled then
        return LinkResult.wrapTextIn(Nodes.Image(str1, str2), arg2:position()):includeMarker()
    elseif not tbl1._linkEnabled then
        return LinkResult.none()
    end
    return LinkResult.wrapTextIn(Nodes.Link(str1, str2), arg2:position())
end

function module.process(arg1, arg2, arg3, arg4)
    if arg2:destination() ~= nil then
        return process(arg1, arg2, arg3, arg2:destination(), arg2:title())
    end

    local var1 = arg2:label()
    if var1 == nil or var1 == "" then
        var1 = arg2:text()
    end

    local definition = arg4:getDefinition("LinkReferenceDefinition", var1)
    if definition ~= nil then
        return process(arg1, arg2, arg3, definition.destination, definition.title)
    end
    return LinkResult.none()
end

return module
