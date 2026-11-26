-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-26T01:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
_G.LUAUFORGE_SENTRY_DEBUG_IDS = _G.LUAUFORGE_SENTRY_DEBUG_IDS or {}
local var1 = debug.info(1, "s")

if var1 and type(var1) == "string" then
    _G.LUAUFORGE_SENTRY_DEBUG_IDS[var1] = "7b0e8c3d-1bed-5787-ada9-f13f0435e64f"
end

local _LUAUFORGE_SENTRY_DEBUG_IDS = _G.LUAUFORGE_SENTRY_DEBUG_IDS

_G.ENVIRONMENT = "PRODUCTION"

_ = "apps/UniversalApp/build/app/bootstrap.luau"
local var2 = nil
var2 = {
    cache = {},
    load = function(arg1)
        if not var2.cache[arg1] then
            var2.cache[arg1] = {
                c = var2[arg1]()
            }
        end

        return var2.cache[arg1].c
    end
}

function var2.b()
    return {}
end

function var2.c()
    return {
        chunkMounted = function(callback, chunkName, loadingMs)
            if callback ~= nil then
                pcall(callback, table.freeze({ chunkName = chunkName, loadingMs = loadingMs }))
            end
        end,
        chunkError = function(callback, chunkName, error, loadingMs)
            if callback == nil then
                return
            end

            pcall(callback, table.freeze({ chunkName = chunkName, loadingMs = loadingMs, error = error }))
        end,
        moduleLoaded = function(callback, chunkName, moduleId, loadingMs)
            if callback == nil then
                return
            end

            pcall(callback, table.freeze({ chunkName = chunkName, moduleId = moduleId, loadingMs = loadingMs }))
        end,
        moduleError = function(callback, chunkName, moduleId, error, loadingMs)
            if callback == nil then
                return
            end

            pcall(callback, table.freeze({ chunkName = chunkName, moduleId = moduleId, loadingMs = loadingMs, error = error }))
        end
    }
end

function var2.a()
    var2.load("b")
    local var3 = var2.load("c")

    local function newSlot()
        return {
            state = "loading",
            value = nil,
            error = nil,
            waiters = {},
            loadingThread = coroutine.running()
        }
    end

    local waiters = table.freeze({})

    local function wakeWaiters(tbl1: {error: nil, loadingThread: thread?, state: string, value: nil, waiters: {[any]: any}})
        local var5 = table.freeze(tbl1.waiters)

        tbl1.waiters = waiters
        table.freeze(tbl1)

        for _, value in var5 do
            coroutine.resume(value)
        end
    end

    local function waitForSlot(arg1, str1: string)
        if arg1.state == "ready" then
            return arg1.value
        end

        if arg1.state == "errored" then
            error(arg1.error)
        elseif arg1.loadingThread == coroutine.running() then
            error(`circular require: {str1}`)
        elseif not coroutine.isyieldable() then
            error("cannot yield from non-yieldable coroutine")
        end

        table.insert(arg1.waiters, coroutine.running())
        coroutine.yield()

        if arg1.state == "ready" then
            return arg1.value
        end

        if arg1.state == "errored" then
            error(arg1.error)
        end

        error(`unexpected slot state: {arg1.state}`)
    end

    local function fillSlot(tbl1: {error: nil, loadingThread: thread?, state: string, value: nil, waiters: {[any]: any}}, callback)
        local startTime = os.clock()
        local success, result = pcall(callback)
        local num1 = os.clock() - startTime
        tbl1.loadingThread = nil
        if success then
            tbl1.state = "ready"
            tbl1.value = result
        else
            tbl1.state = "errored"
            tbl1.error = result
        end
        wakeWaiters(tbl1)
        return success, result, num1 * 1000
    end

    return {
        createContainer = function(arg1)
            local tbl1 = ({})

            local function makeChunkLoadModule(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
                local tbl2 = ({})
                return function(arg3, callback)
                    local var5 = tbl2[arg3]
                    if var5 then
                        return waitForSlot(var5, `{arg2}:{arg3}`)
                    end
                    local tbl3 = newSlot()
                    tbl2[arg3] = tbl3
                    local success, var6, num1 = fillSlot(tbl3, callback)
                    if success then
                        var3.moduleLoaded(arg1.onModuleLoaded, arg2, arg3, num1)
                        return var6
                    end
                    var3.moduleError(arg1.onModuleError, arg2, arg3, var6, num1)
                    error(var6)
                end
            end

            local function resolveChunk(arg2)
                local var5 = tbl1[arg2]
                if var5 then
                    return waitForSlot(var5, `chunk {arg2}`)
                end
                local tbl2 = newSlot()
                tbl1[arg2] = tbl2
                local success, var6, num1 = fillSlot(tbl2, function()
                    return arg1.loadChunk(arg2).mount(table.freeze({ resolveChunk = resolveChunk, loadModule = makeChunkLoadModule(arg2) }))
                end)

                if success then
                    var3.chunkMounted(arg1.onChunkMounted, arg2, num1)
                    return var6
                end
                var3.chunkError(arg1.onChunkError, arg2, var6, num1)
                error(var6)
            end

            return table.freeze({
                resolveChunk = resolveChunk,
                preloadChunk = function(arg2, arg3)
                    local thread = coroutine.create(function()
                        local var5 = resolveChunk(arg2)
                        if arg3 then
                            var5.loadModule(arg3)
                        end
                    end)
                    coroutine.resume(thread)
                end
            })
        end
    }
end

local bool1 = game:DefineFastFlag("LuaAppLoadChunksFromManifest", false)
local bool2 = game:DefineFastFlag("LuaAppLoadChunksFallbackToEmbedded", false)

if not bool1 then
    local function createModuleLoader(_) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl1 = ({})
        local function loadModule(arg1, arg2)
            local var3 = tbl1[arg1]
            if var3 ~= nil then
                return var3.c
            end
            local c = arg2()
            tbl1[arg1] = { c = c }
            return c
        end
        return loadModule
    end

    local function createChunkLoader(arg1) -- Luacid: unused: defined but never referenced
        local tbl1 = ({})
        local function resolveChunk(arg2)
            local var3 = tbl1[arg2]
            if var3 then
                return var3
            end
            local var4 = arg1(arg2).mount(table.freeze({ resolveChunk = resolveChunk, loadModule = createModuleLoader(nil) }))

            tbl1[arg2] = var4
            return var4
        end
        return resolveChunk
    end

    local function requireChunk(arg1)
        return require(`@game/CorePackages/LuauForgeChunks/{arg1}`)
    end

    local tbl1 = ({})
    local function resolveChunk(arg1)
        local var3 = tbl1[arg1]
        if var3 then
            return var3
        end
        local var4 = requireChunk(arg1).mount(table.freeze({ resolveChunk = resolveChunk, loadModule = createModuleLoader(nil) }))

        tbl1[arg1] = var4
        return var4
    end

    resolveChunk("bundled").loadModule("LUAUFORGE_MAIN")
    return
end

local var3 = var2.load("a")

local InsertService = game:GetService("InsertService")
local TelemetryService = game:GetService("TelemetryService")

local var4 = table.freeze({
    eventName = "LuauForgeChunkError",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 2026, 8, 24 },
    description = "Fired when a LuauForge container chunk fails to mount."
})

local var5 = table.freeze({
    eventName = "LuauForgeModuleError",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 2026, 8, 24 },
    description = "Fired when a module factory inside a LuauForge chunk errors."
})

local function onChunkError(arg1)
    TelemetryService:LogEvent(
        var4,
        {
            customFields = {
                chunkName = arg1.chunkName,
                loadingMs = arg1.loadingMs,
                error = tostring(arg1.error)
            }
        }
    )
end

local function getContentManifest() -- Luacid: Inlined by compiler; 1 call site recovered
    return require("@game/CorePackages/LuauForgeContentManifest")
end

local function resolveEmbeddedChunk(chunkName)
    return require(`@game/CorePackages/LuauForgeChunks/{chunkName}`)
end

local function unpackChunk(assetWithBytecodeAsyncResult: Instance)
    local bundle = assetWithBytecodeAsyncResult:FindFirstChild("bundle")
    if bundle ~= nil and bundle:IsA("ModuleScript") then
        return require(bundle)
    end
    error("Chunk is not a ModuleScript named bundle")
end

local function resolveContentChunk(content: Content)
    local assetWithBytecodeAsyncResult = InsertService:LoadAssetWithBytecodeAsync(content)
    return unpackChunk(assetWithBytecodeAsyncResult)
end

var3.createContainer(table.freeze({
    loadChunk = function(chunkName)
        print(`Loading chunk {chunkName}`)
        local content = getContentManifest()[chunkName]

        if content ~= nil then
            print(`Loading content chunk {content}`)
            if not bool2 then
                return resolveContentChunk(content)
            end

            local startTime = os.clock()
            local success, result = pcall(resolveContentChunk, content)
            if success then
                return result
            end
            onChunkError({ chunkName = chunkName, loadingMs = (os.clock() - startTime) * 1000, error = result })
        end

        print(`Loading embedded chunk {chunkName}`)
        return resolveEmbeddedChunk(chunkName)
    end,
    onChunkError = onChunkError,
    onModuleError = function(arg1)
        TelemetryService:LogEvent(var5, {
            customFields = {
                chunkName = arg1.chunkName,
                moduleId = arg1.moduleId,
                loadingMs = arg1.loadingMs,
                error = tostring(arg1.error)
            }
        })
    end
})).resolveChunk("bundled").loadModule(
    "LUAUFORGE_MAIN"
)
