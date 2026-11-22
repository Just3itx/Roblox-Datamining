-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local React = require(HomeParent.React)
local startHomeCollectionLayoutSync = require(Home.startHomeCollectionLayoutSync)

local FFlagEnableHomePageSduiPrefetch = require(HomeParent.SharedFlags).FFlagEnableHomePageSduiPrefetch

local function useHomeCollectionLayoutSync()
    React.useEffect(function()
        if FFlagEnableHomePageSduiPrefetch then
            return startHomeCollectionLayoutSync()
        end
    end, {})
end

return useHomeCollectionLayoutSync
