-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local tbl1 = {}
tbl1.__index = tbl1

function tbl1:GetInstance(className: string): Instance
    if self.InstancePoolsByClass[className] == nil then
        self.InstancePoolsByClass[className] = {}
    end
    local num1 = #self.InstancePoolsByClass[className]
    if not (num1 > 0) then
        return Instance.new(className)
    end

    local var1 = self.InstancePoolsByClass[className][num1]
    table.remove(self.InstancePoolsByClass[className])
    return var1
end

function tbl1:ReturnInstance(arg1)
    if self.InstancePoolsByClass[arg1.ClassName] == nil then
        self.InstancePoolsByClass[arg1.ClassName] = {}
    end
    if #self.InstancePoolsByClass[arg1.ClassName] < self.PoolSizePerType then
        table.insert(self.InstancePoolsByClass[arg1.ClassName], arg1)
        return
    end
    arg1:Destroy()
end

function module.new(poolSizePerType)
    local self = setmetatable({}, tbl1)
    self.InstancePoolsByClass = {}
    self.Name = "ObjectPool"
    self.PoolSizePerType = poolSizePerType

    return self
end

return module
