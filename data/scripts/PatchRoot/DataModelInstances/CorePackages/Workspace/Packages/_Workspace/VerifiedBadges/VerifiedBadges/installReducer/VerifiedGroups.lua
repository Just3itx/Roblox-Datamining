-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedBadges = script:FindFirstAncestor("VerifiedBadges")

local Rodux = require(VerifiedBadges.Parent.Rodux)
local Cryo = require(VerifiedBadges.Parent.Cryo)

return Rodux.createReducer({}, {
    AddGameDetails = function(tbl1, arg1)
        local tbl2 = ({})

        for _, gameDetail in pairs(arg1.gameDetails) do
            local str1 = tostring(gameDetail.creator.id)
            local type = gameDetail.creator.type
            local hasVerifiedBadge = gameDetail.creator.hasVerifiedBadge

            if type == Enum.CreatorType.Group.Name then
                tbl2[str1] = if hasVerifiedBadge then true else Cryo.None
            end
        end

        return Cryo.Dictionary.join(tbl1, tbl2)
    end,
    AddGameDetailsV2 = function(tbl1, arg1)
        local tbl2 = ({})

        for _, gameDetail in pairs(arg1.gameDetails) do
            local str1 = tostring(gameDetail.creator.id)
            local type = gameDetail.creator.type
            local hasVerifiedBadge = gameDetail.creator.hasVerifiedBadge
            if type == Enum.CreatorType.Group.Name then
                tbl2[str1] = if hasVerifiedBadge then true else Cryo.None
            end
        end
        return Cryo.Dictionary.join(tbl1, tbl2)
    end,
    SetAssetInfoFromCatalogItemAction = function(tbl1, arg1)
        if arg1.assetData.creatorType ~= Enum.CreatorType.Group.Name then
            return tbl1
        end

        local str1 = tostring(arg1.assetData.creatorTargetId)
        local creatorHasVerifiedBadge = arg1.assetData.creatorHasVerifiedBadge
        return Cryo.Dictionary.join(tbl1, { [str1] = if creatorHasVerifiedBadge then true else Cryo.None })
    end
})
