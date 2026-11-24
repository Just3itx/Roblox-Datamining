-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBuilder = require(DataHydrationParent.UrlBuilder)
local UrlBase = UrlBuilder.UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local ExperienceGenreStoreTypes = require(script.Parent.ExperienceGenreStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local module = {}

function module.fetchExperienceGenre(universeId: number, arg1, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or UrlBase.APIS
    local var2 = arg1 or {}

    local tbl3 = {
        universeId = universeId,
        genreTaxonomyVersion = var2.genreTaxonomyVersion or ExperienceGenreStoreTypes.DEFAULT_TAXONOMY_VERSION
    }
    if var2.includeGenreTaxonomyVersion then
        tbl3["responseOptions.includeGenreTaxonomyVersion"] = "true"
    end
    if var2.includeUpdateLockExpirationTime then
        tbl3["responseOptions.includeUpdateLockExpirationTime"] = "true"
    end
    if var2.includeVerificationState then
        tbl3["responseOptions.includeVerificationState"] = "true"
    end
    if var2.includeAppealState then
        tbl3["responseOptions.includeAppealState"] = "true"
    end
    if var2.includeCreatorSelectedGenre then
        tbl3["responseOptions.includeCreatorSelectedGenre"] = "true"
    end
    if var2.includeNotifyGenreChange then
        tbl3["responseOptions.includeNotifyGenreChange"] = "true"
    end

    local var3 = fetch({
        network = tbl2.network,
        method = "GET",
        url = UrlBuilder.UrlBuilder.addQueryString(var1 .. "/experience-genre-api/v1/Creator/ExperienceGenre", tbl3),
        analyticsKey = "experience-genre.get",
        decode = function<T>(arg2: T): T
            return arg2
        end
    })
    return asPromise(var3)
end

function module.setExperienceGenre(arg1, tbl1)
    local var1 = (tbl1 or {}).baseUrl or UrlBase.APIS

    local body = {
        universeId = arg1.universeId,
        genre = arg1.genre,
        genreTaxonomyVersion = arg1.genreTaxonomyVersion or ExperienceGenreStoreTypes.DEFAULT_TAXONOMY_VERSION
    }
    if arg1.responseOptions then
        body.responseOptions = arg1.responseOptions
    end

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = var1 .. "/experience-genre-api/v1/Creator/ExperienceGenre",
        body = body,
        analyticsKey = "experience-genre.set",
        decode = function<T>(arg2: T): T
            return arg2
        end
    })
    return asPromise(var2)
end

return module
