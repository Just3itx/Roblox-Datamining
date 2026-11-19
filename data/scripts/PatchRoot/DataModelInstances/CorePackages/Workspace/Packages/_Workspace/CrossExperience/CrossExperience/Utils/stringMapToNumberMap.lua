-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")
local Cryo = require(CrossExperience.dependencies).Cryo

return function(arg1)
    local result = ({})
    if arg1 ~= nil then
        local var1 = Cryo.Dictionary.keys(arg1)
        for _, value in ipairs(var1) do
            local var2 = tonumber(value)
            if var2 then
                result[var2] = arg1[value]
            end
        end
    end
    return result
end
