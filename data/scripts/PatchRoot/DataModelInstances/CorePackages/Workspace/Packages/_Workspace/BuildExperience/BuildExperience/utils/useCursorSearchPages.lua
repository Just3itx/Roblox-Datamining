-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local Promise = require(BuildExperienceParent.Promise)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local _UniverseSearch = require(BuildExperienceParent.DataHydration.UniverseSearch)

local DataStatus = DataHydration.DataStatus
local useSignalState = SignalsReact.useSignalState

local tbl1 = {}

local function keyForSources(sources) -- Luacid: Inlined by compiler; 1 call site recovered
    if sources == nil then
        return nil
    end

    local var1 = table.create(#sources)
    for value, value2 in sources do
        var1[value] = value2.key
    end
    return table.concat(var1, ";")
end

local function firstPages(sources)
    local result = {}
    for sourceIndex in sources or {} do
        table.insert(result, { sourceIndex = sourceIndex, cursor = "" })
    end

    return result
end

local function isPageRequested(pages, tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in pages do
        if value.sourceIndex == tbl2.sourceIndex and value.cursor == tbl2.cursor then
            return true
        end
    end
    return false
end

local function paramsForPage(tbl2, cursor: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = table.clone(tbl2.params)
    if cursor == "" then
        cursor = nil
    end

    var1.cursor = cursor
    return var1
end

local function refreshFirstPages(searchStore, sources)
    local var1 = table.create(#sources)
    for _, value in sources do
        local refreshSearch = searchStore.refreshSearch
        local var2 = table.clone(value.params)
        var2.cursor = nil

        table.insert(var1, refreshSearch(var2))
    end
    return Promise.all(var1)
end

local function ignorePromiseRejection() end

local function useCursorSearchPages(tbl2)
    local searchStore = tbl2.searchStore
    local sources = tbl2.sources
    local var1 = keyForSources(sources)
    local var2, var3 = React.useState({ sourcesKey = var1, pages = firstPages(sources) })

    local tbl3 = var2
    if var2.sourcesKey ~= var1 then
        tbl3 = {
            sourcesKey = var1,
            pages = firstPages(sources)
        }
        var3(tbl3)
    end

    local var4 = React.useMemo(function()
        local result = {}
        if sources ~= nil then
            for _, value in tbl3.pages do
                local var4 = paramsForPage(sources[value.sourceIndex], value.cursor)
                table.insert(result, (searchStore.getSearch(var4)))
            end
        end
        return result
    end, { tbl3, searchStore, sources })

    local var5 = React.useRef({ sources = sources, sourcesKey = var1 })
    var5.current = { sources = sources, sourcesKey = var1 }

    local var6 = React.useRef(var1)

    local var7 = React.useRef(nil)

    React.useEffect(function()
        local sources2 = var5.current.sources
        if sources2 == nil then
            var6.current = nil
            return
        end

        if var6.current == var1 then
            return
        end

        var6.current = var1

        local current = {
            sourcesKey = var1,
            load = refreshFirstPages(searchStore, sources2)
        }
        var7.current = current

        current.load:catch(ignorePromiseRejection):finally(function()
            if var7.current == current then
                var7.current = nil
            end
        end)
    end, { searchStore, var1 })

    local var8 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local pages = tbl3.pages
            local tbl4 = {}
            local tbl5 = ({})
            for value, _ in sources or {} do
                tbl5[value] = {
                    items = {},
                    seen = {},
                    lastResponse = nil,
                    lastPageIndex = nil,
                    newItemCount = 0
                }
            end

            local bool1 = false
            local var8 = nil
            local var9 = if #pages == 0 then DataStatus.Ready else DataStatus.NotReady
            local num1 = 0

            for lastPageIndex, value2 in var4 do
                local var10 = pages[lastPageIndex]
                local var11 = value2.status(arg1)
                local bool2 = var10.cursor == ""
                if var11 == DataStatus.NotReady then
                    bool1 = bool1 or not bool2
                elseif var11 == DataStatus.Failed then
                    if bool2 then
                        var9 = DataStatus.Failed
                    else
                        var8 = var10
                    end
                elseif bool2 then
                    num1 += 1
                end

                local lastResponse = value2.data(arg1)
                if lastResponse == nil then
                    continue
                end

                local var13 = tbl5[var10.sourceIndex]
                var13.lastResponse = lastResponse
                var13.lastPageIndex = lastPageIndex

                local num2 = 0
                for _, value3 in lastResponse.data or tbl1 do
                    if not var13.seen[value3.id] then
                        var13.seen[value3.id] = true
                        num2 += 1
                    end
                    if not tbl4[value3.id] then
                        tbl4[value3.id] = true
                        table.insert(var13.items, value3)
                    end
                end
                var13.newItemCount = num2
            end
            if var9 ~= DataStatus.Failed and #pages > 0 and num1 == #(sources or {}) then
                var9 = DataStatus.Ready
            end

            local items = {}
            local var10 = nil
            for sourceIndex, value2 in tbl5 do
                for _, item in value2.items do
                    table.insert(items, item)
                end

                local lastPageIndex = value2.lastPageIndex
                local lastResponse = value2.lastResponse
                local nextCursor = if lastResponse == nil then nil else lastResponse.nextCursor

                if var10 == nil
                    and lastPageIndex ~= nil
                    and var4[lastPageIndex].status(arg1) == DataStatus.Ready
                    and nextCursor ~= nil
                    and nextCursor ~= ""
                    and value2.newItemCount > 0
                    and not isPageRequested(pages, { sourceIndex = sourceIndex, cursor = nextCursor })
                then
                    var10 = { sourceIndex = sourceIndex, cursor = nextCursor }
                end
            end

            return {
                sourcesKey = tbl3.sourcesKey,
                items = items,
                status = var9,
                nextPage = var10,
                isLoadingMore = bool1,
                failedPage = var8
            }
        end)
    end, { var4, tbl3, sources })

    local var9 = useSignalState(var8)
    local bool1 = not (sources == nil) and var9.sourcesKey ~= var1
    local var10 = React.useRef({})

    local loadMore = React.useCallback(function()
        if sources == nil or bool1 or var5.current.sourcesKey ~= var1 then
            return
        end

        local function loadPage(tbl4)
            local str1 = `{tbl4.sourceIndex}|{tbl4.cursor}|{var1}`
            if var10.current[str1] then
                return
            end
            var10.current[str1] = true

            local var11 = paramsForPage(sources[tbl4.sourceIndex], tbl4.cursor)
            searchStore.getSearch(var11)
            searchStore.refreshSearch(var11):catch(ignorePromiseRejection):finally(function()
                var10.current[str1] = nil
            end)
        end

        local failedPage = var9.failedPage
        if failedPage ~= nil then
            loadPage(failedPage)
            return
        end

        local nextPage = var9.nextPage
        if var9.isLoadingMore or nextPage == nil then
            return
        end

        loadPage(nextPage)
        var3(function(arg1)
            if arg1.sourcesKey ~= var1 or isPageRequested(arg1.pages, nextPage) then
                return arg1
            end
            local pages = table.clone(arg1.pages)
            table.insert(pages, nextPage)
            return { sourcesKey = var1, pages = pages }
        end)
    end, {
        bool1,
        var9,
        searchStore,
        sources,
        var1
    })

    local refresh = React.useCallback(function()
        local current = var5.current
        local sources2 = current.sources
        if sources2 == nil then
            return Promise.resolve()
        end

        var3({ sourcesKey = current.sourcesKey, pages = firstPages(sources2) })

        local current2 = var7.current
        if current2 ~= nil and current2.sourcesKey == current.sourcesKey then
            return current2.load
        end

        return refreshFirstPages(searchStore, sources2)
    end, { searchStore })

    return {
        items = if bool1 then tbl1 else var9.items,
        status = if sources == nil then DataStatus.NotReady elseif bool1 then DataStatus.NotReady else var9.status,
        isLoadingMore = var9.isLoadingMore,
        failedLoadMore = var9.failedPage ~= nil,
        refresh = refresh,
        loadMore = loadMore
    }
end

return useCursorSearchPages
