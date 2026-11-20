-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

local function new(blockLayout, arg1)
    local tbl1 = { blockLayout = blockLayout }

    for layoutOrder, value in ipairs(arg1 or {}) do
        local size = value.size
        local element = value.element

        tbl1[layoutOrder .. "-block"] = Roact.createElement(
            "Frame",
            { BackgroundTransparency = 1, Size = size, LayoutOrder = layoutOrder },
            { child = element }
        )
    end

    return tbl1
end

return new
