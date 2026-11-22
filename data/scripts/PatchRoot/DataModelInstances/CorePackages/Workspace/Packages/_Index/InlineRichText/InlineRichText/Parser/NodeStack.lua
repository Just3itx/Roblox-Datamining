-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local _Types = require(InlineRichText.Types)
local NodeType = require(InlineRichText.Enums.NodeType)
local var1 = require(InlineRichText.Logger):new(script.Name)
local Cryo = require(InlineRichTextParent.Cryo)
local NodeConfig = require(InlineRichText.NodeConfig)

local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)
    self.__stack = {}
    self.__index = 1
    return self
end

function module:push(arg1)
    if not NodeConfig.getByNode(arg1) then
        return {}, false
    end

    local var2 = self:peek()
    local tbl1 = {}

    while var2 and not NodeConfig.isDescendant(var2, arg1) do
        if not self:__canCloseTop() then
            var1:error("push: Cannot closeAndReduce top node. Last item in stack is not the root node")
            return tbl1, false
        end
        local var3 = self:__closeTopAndReduce()
        if not var3 then
            var1:error("push: Failed to closeAndReduce top node")
            return tbl1, false
        end
        var2 = self:peek()
        table.insert(tbl1, var3)
    end

    if not var2 and arg1.type == NodeType.Root then
        self:__push(arg1)
        return tbl1, true
    end

    local byNode = var2 and NodeConfig.getByNode(var2)
    if byNode and byNode.children[arg1.type] then
        self:__push(arg1)
        return tbl1, true
    end

    local byNode2 = NodeConfig.getByNode(arg1)
    local defaultParent = byNode2 and byNode2.defaultParent
    if not defaultParent then
        var1:error(`push: No default parent found for node type {arg1.type}`)
        return tbl1, false
    end
    local var3, var4 = self:pushDefault(defaultParent)
    local var5 = Cryo.List.join(tbl1, var3)
    if not var4 then
        return var5, false
    end
    self:__push(arg1)
    return var5, true
end

function module:pushDefault(arg1)
    local byType = NodeConfig.getByType(arg1)
    if byType and byType.getDefault then
        return self:push((byType.getDefault()))
    end

    var1:error(`pushDefault: No config or getDefault function found for node type {arg1}`)
    return {}, false
end

function module.findAndClose(arg1, name: string)
    if not arg1:__has(name) then
        return {}, false
    end

    local tbl1 = {}
    local bool1 = false

    while arg1:__canCloseTop() do
        local var2 = arg1:__closeTopAndReduce()
        if not var2 then
            var1:error("findAndClose: Failed to closeAndReduce top node")
            return tbl1, false
        end
        table.insert(tbl1, var2)
        if var2.name == name then
            return tbl1, true
        end
    end

    return tbl1, bool1
end

function module:buildRoot()
    while self:__canCloseTop() do
        if not self:__closeTopAndReduce() then
            var1:error("buildRoot: Failed to closeAndReduce top node")
            break
        end
    end

    if #self.__stack == 0 then
        self:pushDefault(NodeType.Root)
    end

    local var2 = self.__stack[1]
    if var2 and var2.type ~= NodeType.Root then
        var1:error("buildRoot: Last node on stack is not the root node")
    end

    return {
        name = "ROOT",
        text = "",
        type = NodeType.Root,
        children = var2.children,
        attributes = var2.attributes,
        index = var2.index
    }
end

function module:peek()
    return self.__stack[#self.__stack]
end

function module:__push(arg1)
    local var2 = Cryo.Dictionary.join(arg1, { index = self.__index })

    table.insert(self.__stack, var2)
    self.__index += 1
    return nil
end

function module:__closeTopAndReduce()
    local var2 = self.__stack[#self.__stack]
    local var3 = self.__stack[#self.__stack - 1]
    if not (var2 and var3) then
        var1:error("closeTop: No top or next node found")
        return nil
    end

    local var4 = Cryo.Dictionary.join(var3, { children = Cryo.List.join(var3.children, { var2 }) })

    table.remove(self.__stack, #self.__stack)
    self.__stack[#self.__stack] = var4
    return {
        name = var2.name,
        text = "",
        type = var2.type,
        children = {},
        attributes = var2.attributes,
        index = var2.index
    }
end

function module:__canCloseTop(): boolean
    return #self.__stack > 1
end

function module:__has(name: string): boolean
    return Cryo.List.findWhere(self.__stack, function(arg1): boolean
        return arg1.name == name
    end) ~= nil
end

return module
