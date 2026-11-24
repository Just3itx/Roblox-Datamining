-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local DiscoveryEventErrorLogger = require(DataHydrationParent.DiscoveryUtils).DiscoveryEventErrorLogger
local EnumIgrsRating = require(DataHydrationParent.DiscoveryTypes).EnumIgrsRating
local FFlagLuaAppAddIgrsImages = require(DataHydrationParent.SharedFlags).FFlagLuaAppAddIgrsImages

local tbl1 = {
    [EnumIgrsRating.IgrsThirteenPlus] = "rbxasset://textures/ui/LuaApp/icons/GameDetails/contentRating/igrs-13.png",
    [EnumIgrsRating.IgrsFifteenPlus] = "rbxasset://textures/ui/LuaApp/icons/GameDetails/contentRating/igrs-15.png",
    [EnumIgrsRating.IgrsEighteenPlus] = "rbxasset://textures/ui/LuaApp/icons/GameDetails/contentRating/igrs-18.png",
    [EnumIgrsRating.IgrsUnrated] = "rbxasset://textures/ui/LuaApp/icons/GameDetails/contentRating/igrs-pending.png"
}

if FFlagLuaAppAddIgrsImages then
    if EnumIgrsRating.IgrsThreePlus then
        tbl1[EnumIgrsRating.IgrsThreePlus] = "rbxasset://textures/ui/LuaApp/icons/GameDetails/contentRating/igrs-3.png"
    end
    if EnumIgrsRating.IgrsSevenPlus then
        tbl1[EnumIgrsRating.IgrsSevenPlus] = "rbxasset://textures/ui/LuaApp/icons/GameDetails/contentRating/igrs-7.png"
    end
end

return {
    getIgrsImage = function(arg1)
        if tbl1[arg1] then
            return tbl1[arg1]
        end

        DiscoveryEventErrorLogger.reportError("getIgrsImage", `Invalid IGRS rating: {arg1}`)
        return nil
    end
}
