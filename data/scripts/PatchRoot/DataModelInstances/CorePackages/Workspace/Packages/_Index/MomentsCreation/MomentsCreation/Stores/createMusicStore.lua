-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Signals = require(MomentsCreationParent.Signals)

local createMusicSource = require(MomentsCreation.Stores.createMusicSource)

local GetFFlagMomentsCreationMusicSearchStateFix = require(MomentsCreation.Flags.GetFFlagMomentsCreationMusicSearchStateFix)
local _Music = require(MomentsCreation.Types.Music)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createMusicStore(arg1)
    local var1 = arg1 or createMusicSource()

    local getInfoMap, var3 = createSignal({})
    local var4, var5 = createSignal({})
    local getSearchStatus, var7 = createSignal("idle")
    local getHasMore, var9 = createSignal(false)
    local getIsLoadingMore, var11 = createSignal(false)

    local num1 = 0

    local tbl1 = ({})

    local str1 = ""
    local var12 = nil

    local var13 = nil

    local getResults = createComputed(function(arg2)
        local var14 = getInfoMap(arg2)
        local result = {}
        for _, value in var4(arg2) do
            local var15 = var14[value]
            if var15 ~= nil then
                table.insert(result, var15)
            end
        end
        return result
    end)

    local function mergeInfo(tbl2) -- Luacid: Inlined by compiler; 5 call sites recovered
        if #tbl2 == 0 then
            return
        end
        local var14 = table.clone(getInfoMap(false))
        for _, value in tbl2 do
            var14[value.AssetId] = value
        end
        var3(var14)
    end

    local function extractIds(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        local result = {}
        for _, value in tbl2 do
            table.insert(result, value.AssetId)
        end
        return result
    end

    local function setCursor(arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
        var13 = arg2
        var9(not (arg2 == nil) and not arg2.isFinished())
        var11(false)
    end

    local function search(str2: string, num2: number?)
        str1 = str2
        var12 = num2
        var13 = nil
        var9(false)
        var11(false)

        if not GetFFlagMomentsCreationMusicSearchStateFix() then
            task.spawn(function()
                local success, result, result2 = pcall(var1.searchMusic, str2, num2 or 30)
                if not success then
                    return
                end

                mergeInfo(result)
                var5((extractIds(result)))
                setCursor(result2)
            end)

            return
        end

        num1 += 1
        local num3 = num1
        var7("loading")

        var5({})
        task.spawn(function()
            local success, result, result2 = pcall(var1.searchMusic, str2, num2 or 30)

            if num3 ~= num1 then
                return
            end

            if not success then
                var7("error")
            else
                mergeInfo(result)
                var5((extractIds(result)))
                setCursor(result2)
                var7("success")
            end
        end)
    end
    return {
        getInfoMap = getInfoMap,
        getResults = getResults,
        getSearchStatus = getSearchStatus,
        search = search,
        retry = function()
            search(str1, var12)
        end,
        getHasMore = getHasMore,
        getIsLoadingMore = getIsLoadingMore,
        loadMore = function()
            local var14 = var13
            if var14 == nil or not getHasMore(false) or getIsLoadingMore(false) then
                return
            end
            var11(true)
            task.spawn(function()
                local success, result = pcall(var14.nextPage)
                if var13 ~= var14 then
                    return
                end

                if not success then
                    var13 = nil
                    var9(false)
                    var11(false)
                    return
                end

                mergeInfo(result)
                local var15 = table.clone(var4(false))
                local tbl2 = ({})
                for _, value in var15 do
                    tbl2[value] = true
                end
                for _, value in result do
                    if not tbl2[value.AssetId] then
                        tbl2[value.AssetId] = true
                        table.insert(var15, value.AssetId)
                    end
                end
                var5(var15)
                setCursor(var14)
            end)
        end,
        fetchInfo = function(num2: number)
            if getInfoMap(false)[num2] ~= nil then
                return
            end

            if not GetFFlagMomentsCreationMusicSearchStateFix() then
                task.spawn(function()
                    local success, result = pcall(var1.getMetadata, { num2 })
                    if success then
                        mergeInfo(result)
                    end
                end)

                return
            end

            if tbl1[num2] then
                return
            end
            tbl1[num2] = true
            task.spawn(function()
                local success, result = pcall(var1.getMetadata, { num2 })
                tbl1[num2] = nil
                if success then
                    mergeInfo(result)
                end
            end)
        end
    }
end

return createMusicStore
