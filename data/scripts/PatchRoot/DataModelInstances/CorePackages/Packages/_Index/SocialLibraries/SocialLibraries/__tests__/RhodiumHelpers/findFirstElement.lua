-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Packages = script:FindFirstAncestor("Packages")
local Element = require(Packages.Dev.Rhodium).Element
local findFirstInstance = require(script.Parent.findFirstInstance)

return function(arg1, arg2)
    local firstInstance = findFirstInstance(arg1, arg2)

    if firstInstance then
        return Element.new("game." .. firstInstance:GetFullName())
    end
    return nil
end
