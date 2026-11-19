-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagDevConsoleKeyCollisionFix = require(script.Parent.Flags.FFlagDevConsoleKeyCollisionFix)

local Signal = require(script.Parent.Parent.Parent.Signal)
local SoundService = game:GetService("SoundService")
local TextService = game:GetService("TextService")
local MeshContentProvider = game:GetService("MeshContentProvider")
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")

local Stats = game:GetService("Stats")
local StatsUtils = require(script.Parent.Parent.Parent.Parent.Stats.StatsUtils)

local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local ChartHeaderNames = require(script.Parent.Parent.Parent.Constants).MemoryFormatting.ChartHeaderNames

local var1 = tonumber(settings():GetFVariable("NewDevConsoleMaxGraphCount"))

local tbl1 = {}
tbl1[ChartHeaderNames[1]] = function(arg1, arg2): boolean
    return arg1.name < arg2.name
end

tbl1[ChartHeaderNames[2]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().data < arg2.dataStats.dataSet:back().data
end

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._pollingId = 0
    result._totalMemory = 0
    result._memoryData = {}
    result._memoryDataSorted = {}
    result._treeViewUpdatedSignal = Signal.new()
    result._totalMemoryUpdated = Signal.new()
    result._sortType = ChartHeaderNames[1]
    result._isRunning = false

    result._doGranularMemUpdate = {}
    result._granularMemTable = {}

    return result
end

local function GetMemoryPerformanceStatsItem() -- Luacid: Inlined by compiler; 1 call site recovered
    local performanceStats = Stats and Stats:FindFirstChild("PerformanceStats")
    if not performanceStats then
        return nil
    end
    return (performanceStats:FindFirstChild(StatsUtils.StatNames[StatsUtils.StatType_Memory]))
end

local function fetchSoundMemoryData()
    local soundMemoryData = SoundService:GetSoundMemoryData()
    local result = {}

    for name, value in pairs(soundMemoryData) do
        table.insert(result, { name = name, value = value })
    end

    table.sort(result, function(arg1, arg2): boolean
        return arg1.value > arg2.value
    end)

    return result
end

local function fetchGraphicsTextureMemoryData()
    local paginatedMemoryByTexture = Stats:GetPaginatedMemoryByTexture(Enum.TextureQueryType.NonHumanoid, 0, 100)
    local paginatedMemoryByTexture2 = Stats:GetPaginatedMemoryByTexture(Enum.TextureQueryType.NonHumanoidOrphaned, 0, 100)
    local result = {}

    local function aggregateData(tbl2, paginatedMemoryByTexture3)
        for _, result2 in ipairs(paginatedMemoryByTexture3.Results) do
            local value = result2.MemoryInBytes / 1048576
            table.insert(tbl2, { name = result2.TextureId, value = value })
        end
    end

    aggregateData(result, paginatedMemoryByTexture)
    aggregateData(result, paginatedMemoryByTexture2)

    table.sort(result, function(arg1, arg2): boolean
        return arg1.value > arg2.value
    end)
    return result
end

local function fetchGraphicsTextureCharacterMemoryData()
    local paginatedMemoryByTexture = Stats:GetPaginatedMemoryByTexture(Enum.TextureQueryType.Humanoid, 0, 100)
    local paginatedMemoryByTexture2 = Stats:GetPaginatedMemoryByTexture(Enum.TextureQueryType.HumanoidOrphaned, 0, 100)
    local result = {}

    local function aggregateData(tbl2, paginatedMemoryByTexture3)
        for _, result2 in ipairs(paginatedMemoryByTexture3.Results) do
            local var2 = result2.MemoryInBytes / 1048576
            local moreInfo = {}

            local textureId = result2.TextureId
            local tbl4 = {}
            for _, value in pairs(string.split(textureId, " ")) do
                if string.sub(value, 1, 2) == "T[" then
                    table.insert(tbl4, value)
                end
            end

            local tbl5 = {}
            for _, value in pairs(tbl4) do
                local str1 = string.split(value, ".mesh:")[2]

                local var3 = string.find(str1, ":", 12)

                if var3 ~= nil then
                    var3 -= 1
                end
                tbl5[string.sub(str1, 1, var3)] = true
            end

            for name, _ in pairs(tbl5) do
                table.insert(moreInfo, { name = name })
            end

            table.sort(moreInfo, function(arg1, arg2): boolean
                return arg1.name < arg2.name
            end)

            if FFlagDevConsoleKeyCollisionFix then
                table.insert(tbl2, { name = "Composite Texture", id = result2.TextureId, value = var2, moreInfo = moreInfo })
            else
                table.insert(tbl2, { name = "Composite Texture", value = var2, moreInfo = moreInfo })
            end
        end
    end

    aggregateData(result, paginatedMemoryByTexture)
    aggregateData(result, paginatedMemoryByTexture2)

    return result
end

local function fetchGraphicsMeshPartsMemoryData()
    local contentMemoryData = MeshContentProvider:getContentMemoryData()
    local result = {}

    for name, value in pairs(contentMemoryData) do
        table.insert(result, { name = name, value = value / 1048576 })
    end

    table.sort(result, function(arg1, arg2): boolean
        return arg1.value > arg2.value
    end)

    return result
end

local function fetchFuncAnimation()
    local memStats = KeyframeSequenceProvider:GetMemStats()
    local result = {}

    for name, memStat in pairs(memStats) do
        table.insert(result, { name = name, value = memStat / 1048576 })
    end

    table.sort(result, function(arg1, arg2): boolean
        return arg1.value > arg2.value
    end)

    return result
end

local function fetchFontMemoryData()
    local fontMemoryData = TextService:GetFontMemoryData()
    local result = {}

    for name, value in pairs(fontMemoryData) do
        table.insert(result, { name = name, value = value / 1048576 })
    end

    table.sort(result, function(arg1, arg2): boolean
        return arg1.value > arg2.value
    end)

    return result
end

function module:updateCachedData(arg1, arg2)
    if self._doGranularMemUpdate[arg1] then
        self._doGranularMemUpdate[arg1] = false
        self._granularMemTable[arg1] = arg2()
    end
end

function module:getAdditionalMemoryFunc(arg1): (() -> any)?
    local var2 = nil
    if arg1 == "Sounds" then
        var2 = fetchSoundMemoryData
    elseif arg1 == "GraphicsTexture" then
        var2 = fetchGraphicsTextureMemoryData
    elseif arg1 == "GraphicsTextureCharacter" then
        var2 = fetchGraphicsTextureCharacterMemoryData
    elseif arg1 == "GraphicsMeshParts" then
        var2 = fetchGraphicsMeshPartsMemoryData
    elseif arg1 ~= "csgDictionary" then
        if arg1 == "Animation" then
            var2 = fetchFuncAnimation
        elseif arg1 == "gui/FontData" and game:GetEngineFeature("TextServiceGetFontMemoryData") then
            var2 = fetchFontMemoryData
        end
    end
    return if var2 then function()
        self:updateCachedData(arg1, var2)
        return self._granularMemTable[arg1]
    end else nil
end

function module:recursiveUpdateEntry(arg1, tbl2: {any}, arg2)
    local name = StatsUtils.GetMemoryAnalyzerStatName(arg2.DisplayName)
    local value = arg2:GetValue()

    local children = arg2:GetChildren()

    if not arg1[name] then
        local circularBuffer = CircularBuffer.new(var1)

        circularBuffer:push_back({ data = value, time = self._lastUpdate })

        arg1[name] = {
            min = value,
            max = value,
            dataSet = circularBuffer,
            children = #children > 0 and {} or false,
            sortedChildren = #children > 0 and {} or false
        }

        local additionalInfoFunc = self:getAdditionalMemoryFunc(name)
        if additionalInfoFunc then
            arg1[name].additionalInfoFunc = additionalInfoFunc
            self._doGranularMemUpdate[name] = true
        end

        table.insert(tbl2, { name = name, dataStats = arg1[name] })
    else
        local max = arg1[name].max
        local min = arg1[name].min

        local tbl3 = {
            data = value,
            time = self._lastUpdate
        }

        if arg1[name].additionalInfoFunc and arg1[name].dataSet:back().data ~= tbl3.data then
            self._doGranularMemUpdate[name] = true
        end

        local var2 = arg1[name].dataSet:push_back(tbl3)

        if var2 then
            local var3 = arg1[name].dataSet:iterator()
            local var4 = var3:next()
            if max == var2.data then
                local var5 = min

                while var4 do
                    min = var4.data < min and min or var4.data
                    var4 = var3:next()
                end

                max = min
                min = var5
            end

            if min == var2.data then
                local var5 = max

                while var4 do
                    max = max < var4.data and max or var4.data
                    var4 = var3:next()
                end

                min = max
                max = var5
            end
        end

        arg1[name].max = max < value and value or max
        local var3 = arg1[name]

        if min < value then
            value = min or value
        end

        var3.min = value
    end

    local var2 = arg1[name]

    local tbl3 = {}

    for _, child in ipairs(children) do
        tbl3[child.DisplayName] = true

        self:recursiveUpdateEntry(var2.children, var2.sortedChildren, child)
    end

    if not var2.children then
        return
    end

    for k, _ in pairs(var2.children) do
        if tbl3[k] ~= nil then
            continue
        end

        var2.children[k] = nil

        for i, sortedChild in ipairs(var2.sortedChildren) do
            if k == sortedChild.name then
                table.remove(var2.sortedChildren, i)
                break
            end
        end
    end
end

function module:totalMemSignal()
    return self._totalMemoryUpdated
end

function module:treeUpdatedSignal()
    return self._treeViewUpdatedSignal
end

function module:getSortType()
    return self._sortType
end

local function recursiveSort<T>(tbl2: {T}, func1: ((T, T) -> boolean)?)
    table.sort(tbl2, func1)
    for _, value in pairs(tbl2) do
        if value.dataStats.sortedChildren then
            recursiveSort(value.dataStats.sortedChildren, func1)
        end
    end
end

function module:setSortType(_sortType)
    if tbl1[_sortType] then
        self._sortType = _sortType

        recursiveSort(self._memoryDataSorted, tbl1[self._sortType])
        return
    end
    error(string.format("attempted to pass invalid sortType: %s", tostring(_sortType)), 2)
end

function module:getMemoryData()
    return self._memoryDataSorted
end

function module:isRunning()
    return self._isRunning
end

function module.start(arg1)
    spawn(function()
        arg1._pollingId += 1
        local _pollingId = arg1._pollingId
        arg1._isRunning = true

        while _pollingId == arg1._pollingId do
            local memoryPerformanceStatsItem = GetMemoryPerformanceStatsItem()

            if not memoryPerformanceStatsItem then
                return
            end
            arg1._lastUpdate = os.time()
            arg1:recursiveUpdateEntry(arg1._memoryData, arg1._memoryDataSorted, memoryPerformanceStatsItem)

            if arg1._totalMemory ~= memoryPerformanceStatsItem:getValue() then
                arg1._totalMemory = memoryPerformanceStatsItem:getValue()
                arg1._totalMemoryUpdated:Fire(arg1._totalMemory)
            end

            arg1._treeViewUpdatedSignal:Fire(arg1._memoryDataSorted)

            wait(3)
        end
        arg1._isRunning = false
    end)
end

function module:stop()
    self._pollingId += 1
end

return module
