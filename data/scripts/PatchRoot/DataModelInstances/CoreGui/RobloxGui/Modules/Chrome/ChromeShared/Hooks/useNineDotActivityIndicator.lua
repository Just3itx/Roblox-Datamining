-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Service = require(ChromeShared.Service)

return function(str1: string, bool1: boolean)
    React.useEffect(function()
        Service:setNineDotActivityIndicatorVisible(str1, bool1)

        return function()
            Service:setNineDotActivityIndicatorVisible(str1, false)
        end
    end, { str1, bool1 })
end
