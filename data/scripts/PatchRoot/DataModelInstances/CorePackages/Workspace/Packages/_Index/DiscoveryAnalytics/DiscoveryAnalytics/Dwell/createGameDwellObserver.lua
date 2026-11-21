-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalytics = script:FindFirstAncestor("DiscoveryAnalytics")
local DiscoveryAnalyticsParent = DiscoveryAnalytics.Parent
local calculateRowPositionFields = require(DiscoveryAnalyticsParent.UnifiedLogging).calculateRowPositionFields
local DwellTracker = require(script.Parent.DwellTracker)
local GameDwellItem = require(script.Parent.GameDwellItem)
local buildGameDwellEvent = require(script.Parent.buildGameDwellEvent)
local sendGameDwellEvent = require(DiscoveryAnalytics.Events.sendGameDwellEvent)

local function itemFromAnalytics(tbl1, cell: number, itemData): {adFlag: number, adId: number, cell: number, componentType: number, positionInRow: any, rank: number, row: any, rowOnPage: any, universeId: number}?
    if type(itemData) ~= "table" then
        return nil
    end

    local universeId = tonumber(itemData.universeId)
    if not universeId or universeId <= 0 or itemData.tileType == "Blank" then
        return nil
    end
    local rowPositionFields = calculateRowPositionFields(cell, tbl1.itemsPerRow, tbl1.startRowNumber)
    local var2 = tonumber(itemData.topicContentsIndex)
    local adFlag = itemData.adFlag
    local bool1 = adFlag == true or adFlag == 1 or type(adFlag) == "string" and (adFlag:lower() == "true" or adFlag:lower() == "t")
    local tbl2 = {
        universeId = universeId,
        cell = cell,
        rank = var2 and var2 > 0 and var2 % 1 == 0 and var2 or -1,
        row = rowPositionFields.rowInSort,
        rowOnPage = rowPositionFields.rowOnPage,
        positionInRow = rowPositionFields.positionInRow,
        componentType = tostring(itemData.itemComponentType or itemData.componentType or "unknown"),
        adFlag = if bool1 then 1 else 0,
        adId = if bool1 then tostring(itemData.adId or "0") else "0"
    }
    return tbl2
end

local function createGameDwellObserver(tbl1)
    local var1 = nil

    local function detach(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = var1
        if not var2 then
            return
        end
        var1 = nil
        for _, connection in var2.connections do
            connection:Disconnect()
        end
        var2.tracker.close(str1 or "collectionReplaced")
    end

    local function createTracker(tbl2, num1: number)
        local tbl3 = {
            gameSetTypeId = 0,
            sortPos = 0,
            collectionComponentType = 0,
            measurementVersion = 1,
            scanDebounceMs = 0
        }
        local collectionId = tbl2.collectionId
        tbl3.gameSetTypeId = tostring(collectionId)
        local collectionPosition = tbl2.collectionPosition
        tbl3.sortPos = tonumber(collectionPosition) or -1
        local collectionComponentType = tbl2.collectionComponentType or "unknown"
        tbl3.collectionComponentType = tostring(collectionComponentType)

        local num2 = num1 * 1000
        tbl3.scanDebounceMs = math.floor(num2)

        if tbl1.collectionItemSize then
            tbl3.collectionItemSize = tbl1.collectionItemSize
        end
        local HttpService = game:GetService("HttpService")
        local tbl4 = {
            now = function(): number
                return math.floor(os.clock() * 1000)
            end,
            wallNow = function(): number
                return DateTime.now().UnixTimestampMillis
            end,
            newUuid = function(): string
                return HttpService:GenerateGUID(false)
            end,
            getItem = function(cell)
                return (itemFromAnalytics(tbl2, cell, tbl1.getItemData(cell)))
            end,
            identity = GameDwellItem.identity,
            sendStarts = function(arg1)
                sendGameDwellEvent("gameDwellStart", buildGameDwellEvent.starts(tbl3, arg1), tbl1.pageContext)
            end,
            sendEnds = function(arg1)
                sendGameDwellEvent("gameDwellEnd", buildGameDwellEvent.ends(tbl3, arg1), tbl1.pageContext)
            end
        }
        return DwellTracker.new(tbl4)
    end

    return {
        attach = function(callback, arg1)
            local var2 = var1
            if var2 then
                var1 = nil
                for _, connection in var2.connections do
                    connection:Disconnect()
                end
                var2.tracker.close("collectionReplaced")
            end

            local collectionData = tbl1.getCollectionData()
            local collectionId = if type(collectionData) == "table" then collectionData.collectionId else nil

            if collectionId == nil or collectionId == -1 then
                return function() end
            end
            local tbl2 = {
                blocked = {},
                connections = {},
                tracker = createTracker(table.clone(collectionData), arg1)
            }
            var1 = tbl2
            local function boundary(str1: string, bool1: boolean) -- Luacid: unused: defined but never referenced
                if var1 ~= tbl2 or tbl2.blocked[str1] == true == bool1 then
                    return
                end
                tbl2.blocked[str1] = if bool1 then true else nil
                if bool1 then
                    tbl2.tracker.close(str1)
                elseif next(tbl2.blocked) == nil then
                    callback()
                end
            end
            local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
            local ExperienceService = game:GetService("ExperienceService")
            tbl2.connections = {
                AppLifecycleObserverService.OnHide:Connect(function()
                    if var1 ~= tbl2 then
                        return
                    end

                    if tbl2.blocked.background == true then
                        return
                    end
                    tbl2.blocked.background = true

                    tbl2.tracker.close("background")
                end),
                AppLifecycleObserverService.OnUnhide:Connect(function()
                    if var1 ~= tbl2 then
                        return
                    end

                    if tbl2.blocked.background ~= true then
                        return
                    end
                    tbl2.blocked.background = nil

                    if next(tbl2.blocked) == nil then
                        callback()
                    end
                end),
                ExperienceService:RegisterForExperienceJoin(function()
                    if var1 ~= tbl2 then
                        return
                    end

                    if tbl2.blocked.experience == true then
                        return
                    end
                    tbl2.blocked.experience = true

                    tbl2.tracker.close("experience")
                end),
                ExperienceService:RegisterForExperienceLeave(function()
                    if var1 ~= tbl2 then
                        return
                    end

                    if tbl2.blocked.experience ~= true then
                        return
                    end
                    tbl2.blocked.experience = nil

                    if next(tbl2.blocked) == nil then
                        callback()
                    end
                end)
            }

            return function(str1: string?)
                if var1 == tbl2 then
                    detach(str1)
                end
            end
        end,
        sample = function(arg1, arg2)
            local var2 = var1
            if not var2 then
                return
            end

            if not arg2 then
                var2.tracker.close("detectorUnavailable")
            elseif next(var2.blocked) == nil then
                var2.tracker.sample(arg1)
            end
        end,
        focusChanged = function(arg1)
            local var2 = var1
            if var2 and not arg1 then
                var2.tracker.close("navigation")
            end
        end
    }
end

return createGameDwellObserver
