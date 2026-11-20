-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MessagingService = game:GetService("MessagingService")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")

local json = require(script.Parent.json)

local isStudio = RunService:IsStudio()

local function dlog(...)
    print("[http]", ...)
end

local module = {
    settings = {},
    max_size = math.huge,
    data = {}
}
function module.update_settings(arg1, arg2)
    arg1 = type(arg1) == "table" and arg1 or { arg1 }
    local num1 = 0

    while num1 < #arg1 do
        num1 += 1

        local var1 = arg1[num1]

        if var1:sub(1, 7) == "http://" then
            arg1[num1] = var1:sub(8)
            var1 = arg1[num1]
        elseif var1:sub(1, 8) == "https://" then
            arg1[num1] = var1:sub(9)
            var1 = arg1[num1]
        end

        if var1:sub(1, 2) == "*." then
            table.insert(arg1, var1:sub(3))
        end

        if not var1:find("/") then
            table.insert(arg1, var1 .. "/")
            table.insert(arg1, var1 .. "/*")
        end
    end

    for _, value in ipairs(arg1) do
        module.settings[value] = arg2

        if arg2.cache_locally == false and not arg2.cache_globally then
            module.settings[value] = nil
        end
    end
end

function module.cache_locally(arg1, arg2)
    arg2 = arg2 or {}
    arg2.cache_globally = false

    module.update_settings(arg1, arg2)
end

function module.cache_globally(arg1, arg2)
    arg2 = arg2 or {}
    arg2.cache_globally = true

    module.update_settings(arg1, arg2)
end

function module.should_cache(arg1)
    arg1 = arg1:split("?")[1]

    for k, _ in pairs(module.settings) do
        if arg1:match(".*://" .. k:gsub("%*", ".*")) then
            return k
        end
    end

    return false
end

function module.is_cached(arg1, arg2): boolean
    local var1 = module.should_cache(arg1)
    local setting = module.settings[var1]

    return if var1 then if module.data[arg2] == nil then if module.settings[var1].cache_globally then not not module.global_cache_index[arg2] else false else not (setting.expires and tick() - module.data[arg2].timestamp > setting.expires) else false
end

module.global_cache_index = {}
local tbl1 = ({})

local success, result = pcall(function(): DataStore
    return DataStoreService:GetDataStore("HttpRequestsCache")
end)

if success then
    local success2, result2 = pcall(function()
        return result:GetAsync("index") or {}
    end)
    if success2 then
        module.global_cache_index = result2

        module.global_cache_update_interval = 20

        coroutine.wrap(function()
            while wait(module.global_cache_update_interval) do
                pcall(function()
                    local num1 = 0
                    for k, value in pairs(tbl1) do
                        result:SetAsync(k, value)
                        num1 += 1
                    end

                    if num1 > 0 then
                        dlog(("pushing %s requests to global cache index"):format(num1))
                    end

                    local tbl2 = {}

                    result:UpdateAsync("index", function(arg1)
                        arg1 = arg1 or {}
                        for k, _ in pairs(tbl1) do
                            table.insert(tbl2, k)

                            arg1[k] = true
                            module.global_cache_index[k] = true
                        end

                        return arg1
                    end)

                    if not isStudio then
                        MessagingService:PublishAsync("RequestsCacheIndex", json.enc(tbl2))
                    end

                    tbl1 = {}
                end)
            end
        end)()

        if not isStudio then
            MessagingService:SubscribeAsync("RequestsCacheIndex", function(arg1)
                local var1 = json.dec(arg1.Data)

                for _, value in ipairs(var1) do
                    module.global_cache_index[value] = true
                end
            end)
        end
    end
end

function module.get_expire(arg1)
    local var1 = module.should_cache(arg1)

    return module.settings[var1].expires or math.huge
end

function module.get_cached(arg1, arg2)
    local var1 = module.should_cache(arg1)

    local var2 = module.data[arg2]
    if var2 then
        return var2, "local"
    end

    if success and module.settings[var1].cache_globally then
        dlog("accessing datastore cache for", arg2)

        return result:GetAsync(arg2), "global"
    end
end

function module.update_cache(arg1, arg2, arg3)
    print(("[http] %s added to cache"):format(arg1))

    arg3.timestamp = tick()

    module.data[arg2] = arg3

    local var1 = module.should_cache(arg1)

    if success and module.settings[var1].cache_globally then
        dlog("queued", arg2)
        tbl1[arg2] = arg3
    end
end

return module
