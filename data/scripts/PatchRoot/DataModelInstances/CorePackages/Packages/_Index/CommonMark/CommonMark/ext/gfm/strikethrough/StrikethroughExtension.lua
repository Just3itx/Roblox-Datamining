-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Extension = require(CommonMark.Extension)
local StrikethroughDelimiterProcessor = require(CommonMark.ext.gfm.strikethrough.internal.StrikethroughDelimiterProcessor)

local module = {}

local Builder = {}
Builder.__index = Builder

local function new(arg1)
    local _requireTwoTildes = arg1._requireTwoTildes
    return {
        extendParser = function(arg2)
            arg2:customDelimiterProcessor(StrikethroughDelimiterProcessor.new(_requireTwoTildes))
        end,
        extendHtmlRenderer = function(arg2)
            local strikethroughHtmlNodeRenderer = require(CommonMark.ext.gfm.strikethrough.internal.StrikethroughHtmlNodeRenderer)

            arg2:nodeRendererFactory({
                create = function(_, arg3)
                    return strikethroughHtmlNodeRenderer.new(arg3)
                end
            })
        end
    }
end

function module.create()
    return module.builder():build()
end

function module.builder()
    return Builder.new()
end

function Builder.new()
    return (setmetatable({ _requireTwoTildes = false }, Builder))
end

function Builder:requireTwoTildes(_requireTwoTildes: boolean)
    self._requireTwoTildes = _requireTwoTildes
    return self
end

function Builder.build(arg1)
    return (new(arg1))
end

module.Builder = Builder

return module
