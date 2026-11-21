-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")
local useNavigateToSeeAll = require(GameCollections.useNavigateToSeeAll)
local useNavigateToSortLinkWebView = require(GameCollections.useNavigateToSortLinkWebView)

local GameCollectionsParent = GameCollections.Parent

local React = require(GameCollectionsParent.React)
local useLocalization = require(GameCollectionsParent.Localization).Hooks.useLocalization
local _DiscoveryTypes = require(GameCollectionsParent.DiscoveryTypes)
local FFlagLuaAppHeaderButtonText = require(GameCollectionsParent.SharedFlags).FFlagLuaAppHeaderButtonText

local function useGameSortHeaderButtonParams(callback: (...any) -> (...any), arg1, bool1: boolean, num1: number?, str1: string?, str2: string?, str3: string, str4: string?, str5: string?, str6: string?, callback2: ((...any) -> (...any))?)
    local var1 = useNavigateToSeeAll(arg1, bool1, num1, str1, str2, str3)
    local var2 = React.useCallback(function()
        var1()
        callback()
    end, { var1, callback })

    local var3 = useNavigateToSortLinkWebView()
    local var4 = React.useCallback(function()
        local var4 = if arg1 then if bool1 then arg1.topicId else arg1.gameSetTypeId else nil

        if str4 then
            var3(str4, str3, arg1 and arg1.displayName or "", var4)
        end
    end, {
        var3,
        str4,
        str3,
        arg1,
        bool1
    })
    if not str4 then
        var4 = var2
    end
    local var5 = useLocalization({ learnMore = "Feature.GameDetails.Label.LearnMore" })

    if not (FFlagLuaAppHeaderButtonText and str6) then
        if str4 then
            str6 = var5.learnMore
        else
            str6 = nil
        end
    end
    return var4, str6, (React.useCallback(function()
        if callback2 then
            callback2()
        elseif arg1 and str5 then
            local var6 = if bool1 then arg1.topicId else arg1.gameSetTypeId
            var3(str5, str3, arg1 and arg1.displayName or "", var6)
        else
            var4()
        end
    end, {
        var3,
        str5,
        str3,
        arg1,
        bool1,
        var4,
        callback2
    }))
end
return useGameSortHeaderButtonParams
