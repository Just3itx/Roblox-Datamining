-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent
local _Types = require(InlineRichText.Types)
local var1 = require(InlineRichText.Logger):new(script.Name)

local Cryo = require(InlineRichTextParent.Cryo)
local NodeConfig = require(InlineRichText.NodeConfig)
local NodeStack = require(InlineRichText.Parser.NodeStack)
local NodeType = require(InlineRichText.Enums.NodeType)
local TokenName = require(InlineRichText.Enums.TokenName)

local tbl1 = {}
tbl1[TokenName.Text] = function(arg1, arg2, _)
    local var2 = arg1:peek()
    if not var2 or var2.type ~= NodeType.Plaintext then
        local _, var3 = arg1:pushDefault(NodeType.Plaintext)
        if not var3 then
            var1:error("Failed to push default plaintext node to add text to")
            return nil
        end
    end

    local var3 = arg1:peek()
    var3.text = `{var3.text}{arg2.text}`
end

tbl1[TokenName.Break] = function(arg1, _, _)
    local var2, var3 = arg1:push({ type = NodeType.InlineCustom, name = "BREAK", text = "", children = {}, attributes = {} })

    local _, var4 = arg1:findAndClose("BREAK")
    if not (var3 and var4) then
        var1:error("Failed to push break node")
        return nil
    end

    for _, value in Cryo.List.reverse(var2) do
        local var5 = arg1:peek()
        local byNode = var5 and NodeConfig.getByNode(var5)
        if not byNode then
            break
        end

        if not byNode.children[value.type] then
            continue
        end

        local _, var6 = arg1:push(value)
        if not var6 then
            var1:error(`Failed to re-open node {value.name} after break`)
            return nil
        end
    end
end

tbl1[TokenName.Open] = function(arg1, arg2, arg3)
    local var2 = arg3.TagAliases[arg2.text] or arg2.text
    local tagConfiguration = arg3.TagConfigurations[var2]
    if not tagConfiguration then
        var1:error(`No configuration open tag name {var2}`)
        return nil
    end
    local name = tagConfiguration.OverrideName or var2

    local _, var4 = arg1:push({ type = tagConfiguration.NodeType, name = name, text = "", children = {}, attributes = arg2.attributes })

    if not var4 then
        var1:error(`Failed to push open tag {name}`)
        return nil
    end
end

tbl1[TokenName.Close] = function(arg1, arg2, arg3)
    local var2 = arg3.TagAliases[arg2.text] or arg2.text
    local tagConfiguration = arg3.TagConfigurations[var2]
    if not tagConfiguration then
        var1:error(`No configuration close tag name {var2}`)
        return nil
    end
    local var3 = tagConfiguration.OverrideName or var2

    local _, var4 = arg1:findAndClose(var3)
    if not var4 then
        var1:error(`Failed to find and close tag {var3}`)
        return nil
    end
end

local function buildTree(tbl2, arg1)
    local nodeStack = NodeStack.new()
    for _, value in tbl2 do
        local var2 = tbl1[value.name]
        if not var2 then
            var1:error(`No processor for token name {value.name}`)
        else
            var2(nodeStack, value, arg1)
        end
    end
    return nodeStack:buildRoot()
end

return buildTree
