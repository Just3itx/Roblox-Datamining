-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent
local RunService = game:GetService("RunService")

local _Types = require(InlineRichText.Types)
local NodeType = require(InlineRichText.Enums.NodeType)
local var1 = require(InlineRichText.Logger):new(script.Name)
local Cryo = require(InlineRichTextParent.Cryo)
local isDescendant = require(InlineRichText.Utils.isDescendant)
local ReactIs = require(InlineRichTextParent.ReactIs)

local isInlineElement = require(InlineRichTextParent.InlineLayout).Utils.isInlineElement

local isStudio = RunService:IsStudio()

local tbl1 = {
    getDefault = function()
        return {
            name = "ROOT",
            text = "",
            type = NodeType.Root,
            children = {},
            attributes = {}
        }
    end,
    children = {
        [NodeType.InlineCustom] = true
    },
    validateRenderResult = 0
}

function tbl1.validateRenderResult(arg1)
    return ReactIs.isElement(arg1)
end

local tbl2 = {}
local InlineCustom = NodeType.InlineCustom

local tbl3 = {
    defaultParent = NodeType.Root,
    getDefault = function()
        return {
            name = "TEXT_SPAN",
            text = "",
            type = NodeType.InlineCustom,
            children = {},
            attributes = {}
        }
    end,
    children = {
        [NodeType.EngineTag] = true,
        [NodeType.Plaintext] = true
    },
    validateRenderResult = 0
}

function tbl3.validateRenderResult(arg1)
    return isInlineElement(arg1)
end

tbl2[InlineCustom] = tbl3

local EngineTag = NodeType.EngineTag
local tbl4 = {
    defaultParent = NodeType.InlineCustom,
    children = {
        [NodeType.EngineTag] = true,
        [NodeType.Plaintext] = true
    },
    validateRenderResult = 0
}
function tbl4.validateRenderResult(_): boolean
    return true
end

tbl2[EngineTag] = tbl4

tbl2[NodeType.Plaintext] = {
    defaultParent = NodeType.InlineCustom,
    getDefault = function()
        return {
            name = "TEXT",
            text = "",
            type = NodeType.Plaintext,
            children = {},
            attributes = {}
        }
    end,
    children = {},
    validateRenderResult = function(_): boolean
        return true
    end
}

local var2 = Cryo.Dictionary.union(tbl2, { [NodeType.Root] = tbl1 })

local function getByType(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var3 = var2[arg1]
    if var3 then
        return var3
    end

    var1:error(`getByType: No config found for node type {arg1}`)
    return nil
end

local function getByNode(arg1)
    if arg1 then
        return getByType(arg1.type)
    end

    var1:error("getByNode: No node provided")
    return nil
end

local function func1(arg1, arg2)
    return isDescendant(var2, "InlineRichTextNodeConfigGraph", arg1.type, arg2.type)
end

if _G.__DEV__ or isStudio then
    for value, value2 in tbl2 do
        if not isDescendant(var2, "InlineRichTextNodeConfigGraph", NodeType.Root, value) then
            error(`NodeConfigNonRoot: Node type {value} does not descend from the root node`)
        end
        if isDescendant(var2, "InlineRichTextNodeConfigGraph", value, NodeType.Root) then
            error(`NodeConfigNonRoot: Node type {value} descends from the root node`)
        end
        if value2.getDefault and value2.getDefault().type ~= value then
            error(
                `NodeConfigNonRoot: Node type {value} getDefault function returns a node with type {value2.getDefault().type} instead of {value}`
            )
        end
        if not value2.defaultParent then
            error(`NodeConfigNonRoot: Node type {value} has no defaultParent`)
        end
        if not var2[value2.defaultParent].getDefault then
            error(
                `NodeConfigNonRoot: Node type {value2.defaultParent} has no getDefault function, but {value} has it as its defaultParent`
            )
        end
    end
end

return { getByType = getByType, getByNode = getByNode, isDescendant = func1 }
