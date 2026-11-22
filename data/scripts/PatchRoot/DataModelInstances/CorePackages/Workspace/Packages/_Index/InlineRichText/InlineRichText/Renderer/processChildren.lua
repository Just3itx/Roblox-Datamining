-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent
local var1 = require(InlineRichText.Logger):new(script.Name)

local Cryo = require(InlineRichTextParent.Cryo)
local _Types = require(InlineRichText.Types)
local NodeType = require(InlineRichText.Enums.NodeType)
local NodeRenderers = script.Parent.NodeRenderers
local PlaintextRenderer = require(NodeRenderers.PlaintextRenderer)
local EngineTagRenderer = require(NodeRenderers.EngineTagRenderer)
local InlineCustomRenderer = require(NodeRenderers.InlineCustomRenderer)
local NodeConfig = require(InlineRichText.NodeConfig)

local tbl1 = {
    [NodeType.Plaintext] = PlaintextRenderer,
    [NodeType.EngineTag] = EngineTagRenderer,
    [NodeType.InlineCustom] = InlineCustomRenderer
}

local function processChildren(arg1, arg2)
    local result = {}
    local byNode = NodeConfig.getByNode(arg1)
    if not byNode then
        var1:warning(`Node {arg1.name}: No config found for node type {arg1.type}`)
        return result
    end

    for _, value in (Cryo.List.map(arg1.children, function(arg3)
        local byNode2 = NodeConfig.getByNode(arg3)
        if not byNode2 then
            var1:warning(`Node {arg3.name}: No config found for node {arg3.name} type {arg3.type}`)
            return {}
        end
        if not byNode.children[arg3.type] then
            var1:warning(
                `Node {arg3.name}: Node type {arg3.type} is not a valid child of node {arg1.name} type {arg1.type}`
            )
            return {}
        end

        local var2 = tbl1[arg3.type]
        if not var2 then
            var1:warning(`Node {arg3.name}: No renderer found for type {arg3.type}`)
            return {}
        end

        local var3 = var2(arg3, arg2)
        local var4 = typeof(var3) ~= "table" and { var3 } or var3

        if Cryo.List.foldLeft(var4, function(arg4, arg5)
            return arg4 and byNode2.validateRenderResult(arg5)
        end, true) then
            return var4
        end

        var1:warning(`Node {arg3.name}: Rendered result is not valid for type {arg3.type}`)
        return {}
    end)) do
        for _, value2 in value do
            table.insert(result, value2)
        end
    end

    return result
end

return processChildren
