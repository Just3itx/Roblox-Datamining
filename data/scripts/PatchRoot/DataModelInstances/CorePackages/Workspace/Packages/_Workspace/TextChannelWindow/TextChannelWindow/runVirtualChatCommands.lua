-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Commands = require(script.Parent.Commands)

return function(str1: string, str2: string)
    for _, command in Commands do
        for _, value in command.aliases do
            if str1 == value or string.find(str1, "^" .. value .. "%s") ~= nil then
                return command.run(str1, str2)
            end
        end
    end
    return nil
end
