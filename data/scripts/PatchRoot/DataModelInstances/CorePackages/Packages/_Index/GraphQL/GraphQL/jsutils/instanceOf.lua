-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local isNillish = require(script.Parent.Parent.luaUtils.isNillish).isNillish

local function instanceOf(arg1, __index)
    if isNillish(arg1) then
        return false
    end

    if typeof(arg1) ~= "table" or typeof(__index) ~= "table" then
        return false
    end

    if __index.new ~= nil and arg1.new == __index.new then
        return true
    end

    local var1 = getmetatable(arg1)

    while typeof(var1) == "table" do
        if var1.__index == __index then
            return true
        end

        local var2 = getmetatable(var1.__index)
        if var1 == var2 then
            return false
        end

        var1 = var2
    end

    return false
end

return function(arg1, __index): boolean
    return instanceOf(arg1, __index)
end
