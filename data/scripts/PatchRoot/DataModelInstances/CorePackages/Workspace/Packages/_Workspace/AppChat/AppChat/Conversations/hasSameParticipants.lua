-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local llama = require(AppChatParent.LuaSocialLibrariesDeps).llama

return function(arg1)
    if #arg1.existing ~= #arg1.new then
        return false
    end

    local var1 = llama.List.sort(arg1.existing)
    local var2 = llama.List.sort(arg1.new)

    return llama.List.equals(var1, var2)
end
