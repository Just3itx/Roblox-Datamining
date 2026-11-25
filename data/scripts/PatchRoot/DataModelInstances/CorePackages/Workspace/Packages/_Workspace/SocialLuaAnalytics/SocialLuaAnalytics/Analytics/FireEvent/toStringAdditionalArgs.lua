-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local tutils = dependencies.tutils
local llama = dependencies.llama

return function(arg1): string
    if llama.isEmpty(arg1) then
        return "{}"
    end

    local var1, _ = string.gsub(" args: " .. tutils.toString(arg1), "%s+", " ")
    return var1
end
