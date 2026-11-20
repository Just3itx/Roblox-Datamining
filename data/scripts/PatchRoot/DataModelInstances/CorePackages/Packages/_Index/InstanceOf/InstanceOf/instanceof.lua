-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__

local function instanceof(arg1, arg2)
    if __DEV__ then
        assert(typeof(arg2) == "table", "Received a non-table as the second argument for instanceof")
    end

    if typeof(arg1) ~= "table" then
        return false
    end

    local success, result = pcall(function(): boolean
        return not (arg2.new == nil) and arg1.new == arg2.new
    end)
    if success and result then
        return true
    end

    local tbl1 = {
        [arg1] = true
    }
    while arg1 and typeof(arg1) == "table" do
        arg1 = getmetatable(arg1)
        if typeof(arg1) == "table" then
            arg1 = arg1.__index

            if arg1 == arg2 then
                return true
            end
        end

        if typeof(arg1) ~= "table" then
            continue
        end

        if tbl1[arg1] then
            return false
        end
        tbl1[arg1] = true
    end

    return false
end

return instanceof
