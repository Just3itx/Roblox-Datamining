-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local num1 = game:DefineFastInt("CorescriptMemoryPeriodSeconds", 30)
local FFlagEnableCorescriptMemoryTracker = require(script.Parent.Parent.Flags.FFlagEnableCorescriptMemoryTracker)
local bool1 = game:DefineFastFlag("EnableMemorySnapshotCategories", false)

local Stats = game:GetService("Stats")
local TelemetryService = game:GetService("TelemetryService")
local MemoryParent = script:FindFirstAncestor("Memory").Parent
local DeviceTier = require(MemoryParent.Devices).DeviceTier

local MemoryScope = require(script.Parent.MemoryScope)

local function GetMemoryPerformanceStatsItem() -- Luacid: Inlined by compiler; 2 call sites recovered
    local performanceStats = Stats and Stats:FindFirstChild("PerformanceStats")
    if not performanceStats then
        return nil
    end
    return (performanceStats:FindFirstChild("Memory"))
end

local function GetChildValue(arg1, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == nil then
        return tostring(arg1:GetValue())
    end

    for _, value in ipairs(string.split(str1, "#")) do
        arg1 = arg1:FindFirstChild(value)
        if not (arg1 and arg1:IsA("StatsItem")) then
            return "-1"
        end
    end

    return tostring(arg1:GetValue())
end

local function GetLuaHeapMb(): string -- Luacid: Inlined by compiler; 3 call sites recovered
    local success, result = pcall(gcinfo)
    if success and result then
        return string.format("%.2f", result / 1024)
    end
    return "-1"
end

local function GetCorescriptMemory()
    local memoryPerformanceStatsItem = GetMemoryPerformanceStatsItem()

    if memoryPerformanceStatsItem then
        for _, child in memoryPerformanceStatsItem:GetChildren() do
            if child:IsA("StatsItem") and child.DisplayName == "CoreScriptMemory" then
                return child:GetValue()
            end
        end
    end

    return nil
end

local config = {
    eventName = "CorescriptMemory",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 7, 16 },
    throttlingPercentage = 10000,
    description = "Memory consumption for corescript, in MB",
    links = "https://docs.google.com/document/d/1BEOgxPzSelCLEHdrHdD_8Kh4ssIcGLlndDXrLmIBNmk"
}

local config2 = {
    eventName = "CorescriptSessionMaxMemory",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 7, 16 },
    throttlingPercentage = 10000,
    description = "Maximum memory consumption for corescript in the session, in MB",
    links = "https://docs.google.com/document/d/1BEOgxPzSelCLEHdrHdD_8Kh4ssIcGLlndDXrLmIBNmk"
}

local config3 = {
    eventName = "CorescriptSessionAvgMemory",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2026, 3, 4 },
    throttlingPercentage = 10000,
    description = "Average memory consumption for corescript in the session, in MB",
    links = "https://docs.google.com/document/d/1BEOgxPzSelCLEHdrHdD_8Kh4ssIcGLlndDXrLmIBNmk"
}

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(context: string?, memoryScope)
    return (setmetatable({
        memoryMb = 0,
        maxMemoryMb = 0,
        avgMemoryMb = 0,
        sampleCount = 0,
        context = context,
        memoryScope = memoryScope,
        status = 2,
        loggingTask = nil
    }, tbl1))
end

function tbl1:start()
    self.status = 1
    self.loggingTask = task.delay(num1, function()
        local corescriptMemory = GetCorescriptMemory()
        if corescriptMemory then
            local var1 = self
            var1.maxMemoryMb = math.max(corescriptMemory, self.maxMemoryMb)
            self.sampleCount += 1
            self.avgMemoryMb += (corescriptMemory - self.avgMemoryMb) / self.sampleCount
            self:report(self.context, corescriptMemory)
        end
        if self.status == 1 then
            self:start()
        end
    end)
end

function tbl1:pause()
    if self.loggingTask then
        task.cancel(self.loggingTask)
        self.loggingTask = nil
    end
    self.status = 2
end

function tbl1:resume()
    if self.status == 2 then
        self:start()
    end
end

function tbl1:destroy()
    if self.loggingTask then
        task.cancel(self.loggingTask)
        self.loggingTask = nil
    end
    self.status = 3
    if self.maxMemoryMb > 0 then
        self:reportMaxMemoryUsed(self.context, self.maxMemoryMb)
    end
    if self.sampleCount > 0 then
        self:reportAvgMemoryUsed(self.context, self.avgMemoryMb)
    end
end

function tbl1:_buildCustomFields(context: string?)
    return {
        deviceTier = DeviceTier.GetDeviceMemoryTier(),
        context = context,
        memoryScope = self.memoryScope
    }
end

function tbl1:report(arg1, num2: number)
    TelemetryService:LogStat(config, { customFields = self:_buildCustomFields(arg1) }, num2)
end

function tbl1:reportMaxMemoryUsed(arg1, num2: number)
    if self.memoryScope == MemoryScope.UniversalApp then
        return
    end
    TelemetryService:LogStat(config2, { customFields = self:_buildCustomFields(arg1) }, num2)
end

function tbl1:reportAvgMemoryUsed(arg1, num2: number)
    if self.memoryScope == MemoryScope.UniversalApp then
        return
    end
    TelemetryService:LogStat(config3, { customFields = self:_buildCustomFields(arg1) }, num2)
end

function tbl1.getSnapshot()
    local memoryPerformanceStatsItem = GetMemoryPerformanceStatsItem()

    if not memoryPerformanceStatsItem then
        return {
            luaHeapMb = GetLuaHeapMb()
        }
    end

    local tbl2 = {
        luaHeapMb = GetLuaHeapMb(),
        totalMemory = GetChildValue(memoryPerformanceStatsItem, nil),
        coreMemory = GetChildValue(memoryPerformanceStatsItem, "CoreMemory"),
        placeMemory = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory"),
        placeLuaHeap = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#LuaHeap"),
        coreScriptMemory = GetChildValue(memoryPerformanceStatsItem, "CoreScriptMemory"),
        untrackedMemory = GetChildValue(memoryPerformanceStatsItem, "UntrackedMemory")
    }

    if bool1 then
        tbl2.placeInstances = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#Instances")
        tbl2.placeSignals = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#Signals")
        tbl2.placeScript = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#Script")
        tbl2.placePhysicsCollision = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#PhysicsCollision")
        tbl2.placeGraphicsSolidModels = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#GraphicsSolidModels")
        tbl2.placeGraphicsMeshParts = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#GraphicsMeshParts")
        tbl2.placeGraphicsParticles = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#GraphicsParticles")
        tbl2.placeGraphicsTerrain = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#GraphicsTerrain")
        tbl2.placeGraphicsTexture = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#GraphicsTexture")
        tbl2.placeGraphicsTextureCharacter = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#GraphicsTextureCharacter")
        tbl2.placeSounds = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#Sounds")
        tbl2.placeTerrainVoxels = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#TerrainVoxels")
        tbl2.placeGui = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#Gui")
        tbl2.placeAnimation = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#Animation")
        tbl2.placeNavigation = GetChildValue(memoryPerformanceStatsItem, "PlaceMemory#Navigation")

        tbl2.coreRenderTarget = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/target")
        tbl2.coreRenderGpuGeomMgr = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/gpu_geom_mgr")
        tbl2.coreRenderTextureLocal = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/texture/local")
        tbl2.coreRenderFonts = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/fonts")
        tbl2.coreRenderLightgrid = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/lightgrid")
        tbl2.coreGuiFontData = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#gui/FontData")
        tbl2.coreRenderEnvmap = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/envmap")
        tbl2.coreRenderShader = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/shader")
        tbl2.coreRenderSystem = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#render/system")
        tbl2.coreDynamicTexture = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#dynamic/texture")
        tbl2.coreDynamicMesh = GetChildValue(memoryPerformanceStatsItem, "CoreMemory#dynamic/mesh")
    end

    return tbl2
end

function tbl1.getLuaHeapOnly()
    return {
        luaHeapMb = GetLuaHeapMb()
    }
end
local var1 = nil

return function(str1: string?, arg1)
    if not FFlagEnableCorescriptMemoryTracker then
        return nil
    end

    var1 = var1 or tbl1.new(str1, arg1)

    return var1
end
