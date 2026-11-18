-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function create(className: string)
    return function(tbl1): Instance
        local instance = Instance.new(className)
        local var1 = nil

        for k, value in pairs(tbl1) do
            if type(k) == "number" and typeof(value) == "Instance" then
                value.Parent = instance
            elseif type(k) == "string" then
                if k == "Parent" then
                    var1 = value
                else
                    instance[k] = value
                end
            end
        end

        instance.Parent = var1

        return instance
    end
end

return create
