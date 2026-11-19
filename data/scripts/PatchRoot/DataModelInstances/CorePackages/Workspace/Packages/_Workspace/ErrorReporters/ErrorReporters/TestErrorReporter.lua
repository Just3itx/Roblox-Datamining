-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local luau = require("@std/luau")
local fs = require("@std/fs")
local json = require("@std/json")
local net = require("@std/net")
local process = require("@std/process")

local function parentDir(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1:match("^(.*)/[^/]+$") or "."
end

local function isModuleDir(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return fs.exists(arg1 .. "/init.lua") or fs.exists(arg1 .. "/init.luau")
end

local var1 = process.args[1]:match("^(.*)/[^/]+$") or "."
local var2 = parentDir((parentDir(var1)))

local var3 = var2 .. "/sentry-sdk/src"

local dsn = process.args[2] or process.env.SENTRY_DSN
if not dsn or dsn == "" then
    print("ERROR: no DSN provided.")
    print("  lute TestErrorReporter.lua \"<your-sentry-dsn>\"")
    print("  or set SENTRY_DSN in the environment")
    process.exit(1)
end

for _, value in { var1 .. "/Sentry/SentryReporter.lua", var3 .. "/Client.lua" } do
    if not fs.exists(value) then
        print(`ERROR: cannot find {value}`)
        process.exit(1)
    end
end

local tbl1 = {
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

local RunService = {
    renderStepped = {
        Connect = function()
            return {
                Disconnect = function() end
            }
        end
    }
}

function RunService.IsStudio(_): boolean
    return false
end

function RunService.GetRobloxVersion(_): string
    return "version-9.999.0.9999999"
end

local tbl3 = { HttpService = tbl1, RunService = RunService }
local game = setmetatable({ PlaceId = 0, JobId = "lute-test-job" }, {})
function game.GetService(_, arg1)
    return tbl3[arg1]
end

function game.DefineFastFlag(_, arg1, arg2)
    return arg1 == "SentryReportBreadcrumbs" or arg2
end

function game.DefineFastInt<T>(_, _, arg1: T): T
    return arg1
end

local var6 = setmetatable({}, {
    __index = function(): () -> (() -> boolean)
        return function(): () -> boolean
            return function(): boolean
                return true
            end
        end
    end
})

local tbl4 = {
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
    tick = os.clock,
    game = game
}

local _G = {}
local tbl6 = ({})

local var7 = nil

local function makeNode(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 6 call sites recovered
    return (setmetatable({ __path = arg1, __name = arg2, __parent = arg3 }, var7))
end

var7 = {
    __index = function(tbl7: {[string]: any}, arg1)
        if type(arg1) == "string" and arg1:sub(1, 2) == "__" then
            return rawget(tbl7, arg1)
        elseif arg1 == "Parent" then
            return tbl7.__parent
        elseif arg1 == "Name" then
            return tbl7.__name
        elseif arg1 == "FindFirstAncestor" then
            return function(_, __name)
                local __parent = tbl7.__parent
                while __parent ~= nil do
                    if __parent.__name == __name then
                        return __parent
                    end
                    __parent = __parent.__parent
                end
                return nil
            end
        else
            local var8 = tbl7.__overrides and tbl7.__overrides[arg1]
            if var8 ~= nil then
                return var8
            end

            return (makeNode(tbl7.__path .. "/" .. arg1, arg1, tbl7))
        end
    end
}

local function func1(script)
    assert(type(script) == "table" and script.__path, "custom require expects a module node")

    if script.__value ~= nil then
        return script.__value
    end

    local __path = script.__path

    if isModuleDir(__path) then
        __path ..= "/init"
    end

    if tbl6[__path] ~= nil then
        return tbl6[__path]
    end

    local var8 = __path .. ".lua"
    if not fs.exists(var8) then
        var8 = __path .. ".luau"
    end

    local var9 = fs.readFileToString(var8)
    local var10 = luau.compile(var9)

    local var11 = setmetatable({ script = script, require = func1, _G = _G }, { __index = tbl4 })

    local var12 = luau.load(var10, var8, var11)()
    tbl6[__path] = var12
    return var12
end

local node = makeNode(var2, "Packages", nil)
local ErrorReporters = makeNode(var1, "ErrorReporters", node)
node.__overrides = {
    ErrorReporters = ErrorReporters,
    SentrySdk = makeNode(var3, "SentrySdk", node),
    Cryo = makeNode(var2 .. "/Cryo", "Cryo", node),
    t = makeNode(var2 .. "/t", "t", node)
}

node.__overrides.Cryo.__value = {
    Dictionary = {
        join = function(...)
            local result = ({})
            local select2 = select

            for i = 1, select2("#", ...) do
                local select = select
                local var8 = select(i, ...)
                if type(var8) ~= "table" then
                    continue
                end

                for k, value in pairs(var8) do
                    result[k] = value
                end
            end

            return result
        end
    }
}

node.__overrides.t.__value = var6

local var8 = func1(ErrorReporters.Sentry.SentryReporter)
local var9 = func1(ErrorReporters.Sentry.ErrorReport)

local var10 = dsn:match("@([^/]+)") or "?"

local messageAndStack = nil

local function summarizeBreadcrumbs()
    local tbl7 = {}
    for k, breadcrumb in messageAndStack.breadcrumbs do
        local format = string.format

        local str1 = tostring(breadcrumb.type)
        local str2 = tostring(breadcrumb.category)
        local str3 = tostring(breadcrumb.message)
        table.insert(tbl7, format("      #%d [%s/%s] %s", k, str1, str2, str3))
    end

    return table.concat(tbl7, "\n")
end

local var11 = var8.new({
    httpService = tbl1,
    dsn = dsn,
    environment = "development",
    release = "error-reporter-test",
    sentryClientSuccessCallback = function()
        print("---- Sentry report accepted ----")
        print("  environment:", "development")
        print("  release:", "error-reporter-test")
        print("  dsn host:", var10)
        print("  level:", tostring(messageAndStack.level))
        print("  message:", tostring(messageAndStack.message))
        print("  attributes:", tbl1:JSONEncode(messageAndStack.attributes))
        print("  customMetadata:", tbl1:JSONEncode(messageAndStack.customMetadata))
        print("  breadcrumbs:", #messageAndStack.breadcrumbs)
        if #messageAndStack.breadcrumbs > 0 then
            print(summarizeBreadcrumbs())
        end
        print("--------------------------------")
    end,
    sentryClientFailureCallback = function(arg1)
        print("[callback] sentryClientFailureCallback fired:", tostring(arg1))
    end
})

messageAndStack = var9.fromMessageAndStack(
    "Testing TestErrorReporter",
    "Script 'CartService', Line 142 - submitOrder\nScript 'PurchaseFlow', Line 88 - startCheckout",
    "error"
)

messageAndStack:addAttributes(
    {
        appVersion = "1.2.3",
        baseOs = "iOS",
        systemVersion = "17.5",
        deviceName = "iPhone 15",
        networkType = "wifi"
    }
)

messageAndStack:addCustomMetadata({ checkout = { cart_id = "cart_abc123", item_count = 3 } })

local tbl7 = {
    type = "navigation",
    category = "navigation",
    message = "Opened Avatar editor",
    data = { from = "/home", to = "/avatar" },
    timestamp = os.time() - 10
}
messageAndStack:addBreadcrumb(tbl7)

messageAndStack:addBreadcrumb({ type = "ui", category = "ui.click", message = "Tapped Buy", level = "info" })

print("Report breadcrumbs:", #messageAndStack.breadcrumbs)
print("Sending error report to Sentry (context + threads + breadcrumbs)...")

var11:sendErrorReport(messageAndStack)

var11:stop()
print("Done. Check the Sentry issue for the breadcrumb trail.")
