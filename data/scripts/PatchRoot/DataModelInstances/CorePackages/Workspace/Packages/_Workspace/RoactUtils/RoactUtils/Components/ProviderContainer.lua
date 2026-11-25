-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)

local function ProviderContainer(tbl1)
    local var1 = tbl1.providers or {}
    local children = tbl1.children

    local tbl2 = {
        PageWrapper = React.createElement("Folder", {}, children)
    }

    for i = #var1, 1, -1 do
        local var2 = var1[i]
        tbl2 = {
            ProviderChildren = React.createElement(var2.class, var2.props, tbl2)
        }
    end

    return React.createElement("Folder", nil, tbl2)
end

return ProviderContainer
