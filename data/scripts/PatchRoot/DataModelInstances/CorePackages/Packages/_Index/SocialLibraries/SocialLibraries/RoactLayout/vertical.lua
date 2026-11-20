-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

local new = require(script.Parent.new)

local function vertical(arg1)
    local element = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })

    return new(element, arg1)
end

return vertical
