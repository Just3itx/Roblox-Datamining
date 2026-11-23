-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local SignalsReact = require(AvatarSwitcherParent.SignalsReact)

local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)
local _types = require(AvatarSwitcher.types)

local ExperienceAvatarSupportType = require(AvatarSwitcher.Enums.ExperienceAvatarSupportType)

local num1 = game:DefineFastInt("AvatarSwitcherShimmerTiles", 12)

local function useOutfitsGridProps()
    local var1 = SignalsReact.useSignalState(getAvatarSwitcherStore)
    local tbl1 = SignalsReact.useSignalState(var1.getOutfits)
    local lastPageReached = SignalsReact.useSignalState(var1.getLastPageReached)
    local disabled = SignalsReact.useSignalState(var1.getExperienceAvatarSupportType) == ExperienceAvatarSupportType.NoSupport

    if #tbl1 == 0 and not lastPageReached then
        tbl1 = {}
        for _ = 1, num1 do
            table.insert(tbl1, {})
        end
    end

    return {
        outfits = tbl1,
        lastPageReached = lastPageReached,
        fetchNextOutfitsPage = var1.fetchNextOutfitsPage,
        disabled = disabled
    }
end

return useOutfitsGridProps
