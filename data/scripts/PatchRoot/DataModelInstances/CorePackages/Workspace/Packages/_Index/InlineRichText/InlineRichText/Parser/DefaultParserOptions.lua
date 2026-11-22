-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local _Types = require(InlineRichText.Types)
local NodeType = require(InlineRichText.Enums.NodeType)

return {
    TagConfigurations = {
        b = {
            NodeType = NodeType.EngineTag
        },
        i = {
            NodeType = NodeType.EngineTag
        },
        u = {
            NodeType = NodeType.EngineTag
        },
        s = {
            NodeType = NodeType.EngineTag
        },
        font = {
            NodeType = NodeType.EngineTag
        },
        stroke = {
            NodeType = NodeType.EngineTag
        },
        uc = {
            NodeType = NodeType.EngineTag
        },
        sc = {
            NodeType = NodeType.EngineTag
        },
        mark = {
            NodeType = NodeType.EngineTag
        },
        a = {
            NodeType = NodeType.InlineCustom,
            OverrideName = "LINK"
        },
        icon = {
            NodeType = NodeType.InlineCustom,
            OverrideName = "ICON"
        }
    },
    TagAliases = {
        strong = "b",
        em = "i",
        strike = "s",
        del = "s",
        uppercase = "uc",
        smallcaps = "sc"
    }
}
