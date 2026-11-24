-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchExperienceGenre = require(script.Parent.fetchExperienceGenre)
local syncExperienceGenreToGameInfo = require(script.Parent.syncExperienceGenreToGameInfo).syncExperienceGenreToGameInfo
local _ExperienceGenreStoreTypes = require(script.Parent.ExperienceGenreStoreTypes)

local tbl1 = {
    includeGenreTaxonomyVersion = true,
    includeUpdateLockExpirationTime = true,
    includeVerificationState = true,
    includeAppealState = true,
    includeCreatorSelectedGenre = true,
    includeNotifyGenreChange = true
}

local function createExperienceGenreStore(tbl2)
    local tbl3 = tbl2 or {}
    local tbl4 = {
        network = tbl3.network,
        baseUrl = tbl3.baseUrl
    }
    local var1 = tbl3.defaultGetOptions or tbl1

    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchExperienceGenre.fetchExperienceGenre(num1, var1, tbl4)
    end)

    return {
        getExperienceGenre = singleEntityResolver.get,
        fetchExperienceGenre = singleEntityResolver.fetch,
        getAndFetchExperienceGenre = singleEntityResolver.getAndFetch,
        setExperienceGenre = function(arg1)
            return fetchExperienceGenre.setExperienceGenre(arg1, tbl4):andThen(function(arg2)
                singleEntityResolver.update(arg1.universeId, arg2)

                syncExperienceGenreToGameInfo(arg1.universeId, nil, arg2.genre)
                return arg2
            end)
        end,
        updateExperienceGenre = singleEntityResolver.update,
        clear = singleEntityResolver.clear,
        dispose = singleEntityResolver.dispose
    }
end

return createExperienceGenreStore
