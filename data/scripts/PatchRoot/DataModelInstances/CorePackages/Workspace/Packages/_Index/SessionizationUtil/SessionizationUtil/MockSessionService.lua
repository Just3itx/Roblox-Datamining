-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionizationUtilParent = script:FindFirstAncestor("SessionizationUtil").Parent

local Signal = require(SessionizationUtilParent.AppCommonLib).Signal

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(sid: string, tag: string)
    local tbl2 = {
        sid = sid,
        tag = tag,
        metadata = {},
        children = {},
        timestamp = tick(),
        parent = nil
    }

    setmetatable(tbl2, { __index = tbl1 })

    return tbl2
end

function tbl1:addChild(arg1, arg2)
    local var1 = tbl1.new(arg1, arg2)
    var1.parent = self
    self.children[arg1] = var1
end

function tbl1:dump(arg1, arg2)
    arg2 ..= `{arg1} sid: {self.sid}, tag: {self.tag}\n`
    arg1 ..= "----"
    for _, child in self.children do
        arg2 = child:dump(arg1, arg2)
    end

    return arg2
end

function findSid(arg1, sid)
    if arg1.sid == sid then
        return arg1
    end

    for _, child in arg1.children do
        local sid2 = findSid(child, sid)
        if sid2 ~= nil then
            return sid2
        end
    end

    return nil
end

local module = { MOCK_ROOT_SID = "MOCK_ROOT_SID" }

module.__index = module

function module.new()
    local tbl2 = {
        mockRootNode = tbl1.new(module.MOCK_ROOT_SID, module.MOCK_ROOT_SID),
        SessionChangedSignal = Signal.new()
    }

    setmetatable(tbl2, { __index = module })

    return tbl2
end

function module:_resetMockData()
    self.mockRootNode = tbl1.new(module.MOCK_ROOT_SID, module.MOCK_ROOT_SID)
end

function module:_findSid(arg1)
    return findSid(self.mockRootNode, arg1)
end

function module:_dumpSessionTree()
    if self.mockRootNode ~= nil then
        return self.mockRootNode:dump("", "")
    end
    return "Root node is nil!"
end

function module.GetRootSID(arg1)
    return arg1.MOCK_ROOT_SID
end

function module:SetSession(arg1, arg2, arg3)
    (findSid(self.mockRootNode, arg1) or self.mockRootNode):addChild(arg2, arg3)
end

function module:ReplaceSession(arg1, arg2)
    local sid = findSid(self.mockRootNode, arg1)
    if sid ~= nil and sid.parent ~= nil then
        sid.parent.children[arg1] = nil
        sid.parent:addChild(arg1, arg2)
    end
end

function module:RemoveSession(arg1)
    local sid = findSid(self.mockRootNode, arg1)
    if sid == nil then
        return
    end

    local parent = sid.parent
    if parent ~= nil then
        parent.children[arg1] = nil
    end
end

function module:GetMetadata(arg1, arg2)
    local sid = findSid(self.mockRootNode, arg1)
    return if sid == nil then nil else sid.metadata[arg2]
end

function module:SetMetadata(arg1, arg2, arg3)
    local sid = findSid(self.mockRootNode, arg1)
    if sid ~= nil then
        sid.metadata[arg2] = arg3
    end
end

function module:SessionExists(arg1): boolean
    return findSid(self.mockRootNode, arg1) ~= nil
end

function module:RemoveSessionsWithMetadataKey(arg1)
    if arg1 == nil then
        return
    end

    local function findNodeWithMetadataKey(arg2, arg3)
        if arg3 ~= nil then
            if arg3.metadata[arg2] ~= nil then
                return arg3
            end

            for _, child in arg3.children do
                local nodeWithMetadataKey = findNodeWithMetadataKey(arg2, child)
                if nodeWithMetadataKey ~= nil then
                    return nodeWithMetadataKey
                end
            end
        end

        return nil
    end

    local nodeWithMetadataKey = findNodeWithMetadataKey(arg1, self.mockRootNode)
    while nodeWithMetadataKey ~= nil do
        self:RemoveSession(nodeWithMetadataKey.sid)
        nodeWithMetadataKey = findNodeWithMetadataKey(arg1, self.mockRootNode)
    end
end

function module.generateSessionInfoString(_, _, _, _, _): string
    return ""
end

function module:GetSessionTag(arg1)
    local sid = findSid(self.mockRootNode, arg1)
    return if sid == nil then "" else sid.tag
end

return module
