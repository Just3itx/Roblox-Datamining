-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local luau = require("@std/luau")
local fs = require("@std/fs")
local json = require("@std/json")
local net = require("@std/net")
local process = require("@std/process")

local var1 = process.args[1]:match("^(.*)/[^/]+$") or "."

local dsn = process.args[2] or process.env.SENTRY_DSN
if not dsn or dsn == "" then
    print("ERROR: no DSN provided.")
    print("  lute test_client.lua \"<your-sentry-dsn>\"")
    print("  or set SENTRY_DSN in the environment")
    process.exit(1)
end

if not fs.exists(var1 .. "/Client.lua") then
    print(`ERROR: cannot find {var1}/Client.lua`)
    process.exit(1)
end

local HttpService = {
    JSONEncode = function(_, arg1)
        return json.serialize(arg1)
    end,
    JSONDecode = function(_, arg1)
        return json.deserialize(arg1)
    end,
    RequestInternal = function(_, arg1)
        return {
            Start = function(_, callback)
                local success, result = pcall(function()
                    return net.request(arg1.Url, { method = arg1.Method, headers = arg1.Headers, body = arg1.Body })
                end)

                if not success then
                    callback(false, tostring(result))

                    return
                end

                callback(true, { Success = result.ok, StatusCode = result.status, Body = result.body, Headers = result.headers })
            end
        }
    end
}

local tbl2 = {
    HttpService = HttpService,
    RunService = {
        IsStudio = function(_): boolean
            return false
        end,
        GetRobloxVersion = function(_): string
            return "version-9.999.0.9999999"
        end
    }
}

local game = setmetatable({ PlaceId = 0, JobId = "lute-test-job" }, {})
function game.GetService(_, arg1)
    return tbl2[arg1]
end

function game.DefineFastFlag(_): boolean
    return false
end

local tbl3 = {
    print = print,
    warn = print,
    error = error,
    assert = assert,
    pcall = pcall,
    xpcall = xpcall,
    type = type,
    typeof = typeof,
    tostring = tostring,
    tonumber = tonumber,
    next = next,
    pairs = pairs,
    ipairs = ipairs,
    select = select,
    unpack = unpack,
    setmetatable = setmetatable,
    getmetatable = getmetatable,
    rawget = rawget,
    rawset = rawset,
    rawequal = rawequal,
    rawlen = rawlen,
    string = string,
    table = table,
    math = math,
    os = os,
    coroutine = coroutine,
    bit32 = bit32,
    utf8 = utf8,
    buffer = buffer,
    game = game
}

local _G = {}
local tbl5 = ({})

local var4 = nil
local var5 = nil

local function parentDir(__dir) -- Luacid: Inlined by compiler; 1 call site recovered
    return __dir:match("^(.*)/[^/]+$") or "."
end

local function folderNode(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (setmetatable({ __dir = arg1, __isFolder = true }, var5))
end

local function fileNode(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (setmetatable({ __base = arg1, __parent = arg2, __isFile = true }, var4))
end

var5 = {
    __index = function(arg1, arg2)
        if arg2 == "Parent" then
            return (folderNode((parentDir(arg1.__dir))))
        end

        return (fileNode(arg1.__dir .. "/" .. arg2, arg1))
    end
}

var4 = {
    __index = function(arg1, arg2)
        if arg2 == "Parent" then
            return arg1.__parent
        end
        error(`unsupported instance access: .{tostring(arg2)} on module file`)
    end
}

local function func1(script)
    assert(type(script) == "table" and script.__isFile, "custom require expects a module node")
    local __base = script.__base
    if tbl5[__base] ~= nil then
        return tbl5[__base]
    end

    local var6 = __base .. ".lua"
    if not fs.exists(var6) then
        var6 = __base .. ".luau"
    end

    local var7 = fs.readFileToString(var6)
    local var8 = luau.compile(var7)

    local var9 = setmetatable({ script = script, require = func1, _G = _G }, { __index = tbl3 })

    local var10 = luau.load(var8, var6, var9)()
    tbl5[__base] = var10
    return var10
end

local var6 = folderNode(var1)

local var7 = fileNode(var1 .. "/Client", var6)
local var8 = func1(var7):new({ dsn = dsn, environment = "sentry-sdk-test", release = "sentry-sdk-test" }, HttpService)

var8:set_tag("test_run", "breadcrumb-lute")
var8:add_breadcrumb({ type = "ui", category = "ui.click", message = "client-level crumb" })

local stacktrace = {
    frames = {
        {
            filename = "CartService.lua",
            abs_path = "CartService.lua",
            ["function"] = "submitOrder",
            lineno = 142,
            colno = 9,
            in_app = true
        },
        {
            filename = "PurchaseFlow.lua",
            abs_path = "PurchaseFlow.lua",
            ["function"] = "startCheckout",
            lineno = 88,
            in_app = true
        }
    }
}

print("Sending exception to Sentry with context, threads, stacktrace, and breadcrumbs...")

var8:capture_exception(
    { type = "LuaError", message = "Breadcrumb test from lute", stacktrace = stacktrace },
    "error",
    {
        app = { app_version = "1.2.3", app_build = "4567" },
        device = {
            name = "iPhone 15",
            model = "iPhone16,1",
            manufacturer = "Apple",
            memory_size = 8000000000
        },
        checkout = { cart_id = "cart_abc123", item_count = 3 }
    },
    {
        values = {
            { id = 1, name = "main", main = true, crashed = true, stacktrace = stacktrace },
            {
                id = 2,
                name = "PrefetchWorker",
                main = false,
                crashed = false,
                stacktrace = {
                    frames = {{
                        filename = "PrefetchWorker.lua",
                        ["function"] = "run",
                        lineno = 27,
                        in_app = true
                    }}
                }
            }
        }
    },
    function(arg1, arg2, arg3)
        print("---- Sentry response ----")
        print("callback success:", arg1)
        print("eventId:", tostring(arg3))
        if type(arg2) == "table" and type(arg2.body) == "table" then
            print("HTTP status:", tostring(arg2.body.StatusCode))
            print("HTTP body:", tostring(arg2.body.Body))
        elseif type(arg2) == "table" then
            print("error:", tostring(arg2.error))
        end
        print("-------------------------")
    end,
    {
        {
            type = "navigation",
            category = "navigation",
            message = "Opened Avatar editor",
            timestamp = os.time() - 10,
            data = { from = "/home", to = "/avatar" }
        },
        {
            type = "ui",
            category = "ui.click",
            message = "Tapped Buy",
            level = "info",
            timestamp = os.time()
        }
    }
)
