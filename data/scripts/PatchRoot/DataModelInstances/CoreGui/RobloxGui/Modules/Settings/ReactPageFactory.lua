-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local module = ({})

local function createNewPage(name: string)
    local module2 = { name = name, page = nil, hubRef = nil }

    function module2.setPage(_, page)
        module2.page = page
    end

    function module2.createPage(_, arg1)
        if not module2.page then
            return nil
        end

        return React.createElement(module2.page, arg1)
    end

    return module2
end

function module.createNewPage(_, str1: string)
    return (createNewPage(str1))
end

return module
