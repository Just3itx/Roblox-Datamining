-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Signals = require(AvatarExperienceCatalogParent.Signals)
local normalizeScreenSizeForWire = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Utils.normalizeScreenSizeForWire
local sendAXCounterV2 = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).sendAXCounterV2
local Constants = require(AvatarExperienceCatalog.Constants)

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXSduiBracedPageRequestId = AvatarExperienceFlags.FFlagAXSduiBracedPageRequestId
local FFlagAXSduiPageVariantRequestId = AvatarExperienceFlags.FFlagAXSduiPageVariantRequestId
local FFlagAXSduiPublishRequestIdWithResponse = AvatarExperienceFlags.FFlagAXSduiPublishRequestIdWithResponse

local function getVariantKey(str1: string, str2: string): string -- Luacid: Inlined by compiler; 8 call sites recovered
    return `{str1}|{normalizeScreenSizeForWire(str2)}`
end

local function createCatalogPageRequestIdStore()
    local getPageRequestIdMap, var2 = Signals.createSignal({})

    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = ({})

    local function generateRequestId() -- Luacid: Inlined by compiler; 4 call sites recovered
        if FFlagAXSduiBracedPageRequestId then
            return HttpService:GenerateGUID(true)
        end
        return HttpService:GenerateGUID(false)
    end

    local function setIdentifierRequestId(str1: string, str2: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local var3 = getPageRequestIdMap(false)
        if var3[str1] == str2 then
            return
        end
        local var4 = table.clone(var3)
        var4[str1] = str2
        var2(var4)
    end

    local function recordFetchedVariant(identifier: string, variantKey: string, str1: string)
        local tbl5 = tbl3[identifier]
        if tbl5 == nil then
            tbl5 = {}
            tbl3[identifier] = tbl5
        end
        if tbl5[variantKey] then
            return
        end
        if next(tbl5) ~= nil then
            sendAXCounterV2(
                Constants.COUNTERS.CatalogPageSecondVariantFetched,
                {
                    identifier = identifier,
                    screenSize = normalizeScreenSizeForWire(str1)
                }
            )
        end

        tbl5[variantKey] = true
    end

    local function getOrCreateVariantRequestIdForKey(identifier: string, variantKey: string, str1: string)
        local var3 = tbl1[variantKey]
        if var3 ~= nil then
            return var3
        end

        recordFetchedVariant(identifier, variantKey, str1)
        local var4

        if tbl2[identifier] == nil then
            tbl2[identifier] = variantKey

            var4 = getPageRequestIdMap(false)[identifier]
            var4 = var4 or generateRequestId()
        else
            var4 = generateRequestId()
        end

        tbl1[variantKey] = var4

        if tbl2[identifier] == variantKey then
            setIdentifierRequestId(identifier, var4)
        end

        return var4
    end

    local function resetPageRequestId(str1: string)
        if FFlagAXSduiPageVariantRequestId then
            local var3 = tbl2[str1]
            if var3 ~= nil then
                tbl1[var3] = nil
            end
        end

        local var3 = getPageRequestIdMap(false)
        if var3[str1] == nil then
            return
        end

        local tbl5 = ({})
        for value, value2 in var3 do
            if value ~= str1 then
                tbl5[value] = value2
            end
        end
        var2(tbl5)
    end

    return {
        getPageRequestIdMap = getPageRequestIdMap,
        getOrCreatePageRequestId = function(str1: string)
            local var3

            if FFlagAXSduiPageVariantRequestId then
                var3 = tbl2[str1]
                if var3 ~= nil then
                    local var4 = tbl1[var3]
                    if var4 ~= nil then
                        return var4
                    end
                end
            else
                var3 = nil
            end

            local var4 = getPageRequestIdMap(false)
            local var5 = var4[str1]
            if var5 ~= nil then
                return var5
            end

            local str2 = if FFlagAXSduiBracedPageRequestId then generateRequestId() else HttpService:GenerateGUID(false)

            if FFlagAXSduiPageVariantRequestId and var3 ~= nil then
                tbl1[var3] = str2
            end
            local var6 = table.clone(var4)
            var6[str1] = str2
            var2(var6)
            return str2
        end,
        resetPageRequestId = resetPageRequestId,
        getOrCreatePageVariantRequestId = function(identifier: string, str1: string)
            return (getOrCreateVariantRequestIdForKey(identifier, getVariantKey(identifier, str1), str1))
        end,
        activatePageVariant = function(identifier: string, str1: string)
            local variantKey = getVariantKey(identifier, str1)

            local orCreateVariantRequestIdForKey = getOrCreateVariantRequestIdForKey(identifier, variantKey, str1)
            tbl2[identifier] = variantKey
            setIdentifierRequestId(identifier, orCreateVariantRequestIdForKey)
            return orCreateVariantRequestIdForKey
        end,
        resetPageVariantRequestId = function(str1: string, str2: string)
            local variantKey = getVariantKey(str1, str2)

            local var3 = tbl2[str1]
            tbl1[variantKey] = nil
            if FFlagAXSduiPublishRequestIdWithResponse then
                tbl4[variantKey] = nil
            end

            if var3 == nil or var3 == variantKey then
                resetPageRequestId(str1)
            end
        end,
        beginPageVariantRefresh = function(identifier: string, str1: string)
            local variantKey = getVariantKey(identifier, str1)

            if tbl1[variantKey] == nil then
                return (getOrCreateVariantRequestIdForKey(identifier, variantKey, str1))
            end

            local str2 = generateRequestId()
            tbl4[variantKey] = str2
            return str2
        end,
        getPageVariantRequestIdToSend = function(identifier: string, str1: string)
            local variantKey = getVariantKey(identifier, str1)

            return tbl4[variantKey] or getOrCreateVariantRequestIdForKey(identifier, variantKey, str1)
        end,
        commitPageVariantRequestId = function(str1: string, str2: string, str3: string)
            local variantKey = getVariantKey(str1, str2)

            if tbl4[variantKey] ~= str3 then
                return
            end
            tbl4[variantKey] = nil
            tbl1[variantKey] = str3
            if tbl2[str1] == variantKey then
                setIdentifierRequestId(str1, str3)
            end
        end,
        discardPageVariantRequestId = function(str1: string, str2: string, str3: string)
            local variantKey = getVariantKey(str1, str2)

            if tbl4[variantKey] == str3 then
                tbl4[variantKey] = nil
            end
        end,
        getPageVariantRequestId = function(str1: string, str2: string)
            return tbl1[getVariantKey(str1, str2)]
        end
    }
end
return createCatalogPageRequestIdStore
