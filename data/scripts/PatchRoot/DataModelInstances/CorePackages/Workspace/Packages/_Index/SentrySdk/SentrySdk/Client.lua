-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxTransport = require(script.Parent.RobloxTransport)
local Version = require(script.Parent.Version)
local isStudio = game:GetService("RunService"):IsStudio()

local function isBundled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(_G.LUAUFORGE_BUNDLED_FILE_PATH) == "string"
end

local function isTableEmpty(extra): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return next(extra) == nil
end

local function parseJSON(arg1, str1: string) -- Luacid: unused: defined but never referenced
    if type(str1) ~= "string" then
        return nil, "Input is not a string"
    end

    local success, result = pcall(function()
        return arg1:JSONDecode(str1)
    end)

    if success then
        return result, nil
    end
    return nil, tostring(result)
end

local function createCallbackWithEventId(httpService, callback: ((...any) -> (...any))?): ((boolean, {[any]: any}?) -> ())? -- Luacid: Inlined by compiler; 3 call sites recovered
    return if callback then function(bool1: boolean, tbl1)
        local id = nil
        local var1 = nil

        if bool1 and tbl1 and tbl1.body then
            if type(tbl1.body) == "table" and tbl1.body.Body then
                local var2 = httpService
                local body = tbl1.body.Body
                local result

                if type(body) == "string" then
                    local success

                    success, result = pcall(function()
                        return var2:JSONDecode(body)
                    end)

                    if not success then
                        tostring(result)
                        result = nil
                    end
                else
                    result = nil
                end

                if result and result.id then
                    id = result.id
                end
            end
        else
            tbl1 = tbl1 or var1
        end

        callback(bool1, tbl1, id)
    end else nil
end

local module = {}
module.__index = module

function module.new(_, config, httpService)
    if not config.dsn then
        error("DSN is required")
    end

    return (setmetatable({
        transport = RobloxTransport:new(config.dsn, httpService),
        httpService = httpService,
        user = nil,
        tags = {},
        extra = {},
        breadcrumbs = {},
        config = config
    }, module))
end

function module:_buildDebugMeta()
    local luauforgeSentryDebugIds = _G.LUAUFORGE_SENTRY_DEBUG_IDS

    if type(luauforgeSentryDebugIds) ~= "table" then
        return nil
    end

    local images = {}
    for codeFile, debugId in luauforgeSentryDebugIds do
        table.insert(images, { type = "sourcemap", code_file = codeFile, debug_id = debugId })
    end

    return if #images == 0 then nil else { images = images }
end

function module:capture_message(message: string, level: string?, callback: ((...any) -> (...any))?, breadcrumbs)
    local tbl1 = {
        message = { message = message },
        level = level or "info",
        timestamp = os.time(),
        environment = self.config.environment or "production",
        release = self.config.release or "unknown",
        platform = "roblox",
        sdk = {
            name = "sentry.lua",
            version = Version.SDK_VERSION
        },
        server_name = "roblox-server",
        user = self.user,
        tags = self.tags,
        extra = if isTableEmpty(self.extra) then nil else self.extra,
        breadcrumbs = breadcrumbs or self.breadcrumbs,
        contexts = {
            roblox = {
                version = Version.SDK_VERSION,
                place_id = tostring(game.PlaceId),
                job_id = game.JobId or "unknown"
            }
        }
    }

    local callbackWithEventId = createCallbackWithEventId(self.httpService, callback)

    self.transport:send(tbl1, callbackWithEventId)
end

function module:capture_exception(tbl1, str1: string?, tbl2, threads, callback: ((...any) -> (...any))?, breadcrumbs, timestamp: number?, tbl3)
    local level = str1 or "error"

    local contexts = {
        roblox = {
            version = Version.SDK_VERSION,
            place_id = tostring(game.PlaceId),
            job_id = game.JobId or "unknown"
        }
    }

    if tbl2 then
        for k, value in pairs(tbl2) do
            contexts[k] = value
        end
    end

    local tbl5 = {
        type = tbl1.type or "RobloxError",
        value = tbl1.message or tostring(tbl1)
    }

    if tbl1.stacktrace and tbl1.stacktrace.frames and #tbl1.stacktrace.frames > 0 then
        tbl5.stacktrace = tbl1.stacktrace

        if isBundled() then
            for _, value in tbl1.stacktrace.frames do
                value.platform = "javascript"
            end
        end
    end

    local exception = {
        values = { tbl5 }
    }

    if isStudio then
        print("🔍 Exception structure:", exception)
    end

    local tbl7 = {
        exception = exception,
        level = level,
        timestamp = timestamp or os.time(),
        environment = self.config.environment or "production",
        release = self.config.release or "unknown",
        platform = "roblox",
        sdk = {
            name = "sentry.lua",
            version = Version.SDK_VERSION
        },
        server_name = "roblox-server",
        user = self.user,
        tags = self.tags,
        extra = if isTableEmpty(self.extra) then nil else self.extra,
        breadcrumbs = breadcrumbs or self.breadcrumbs,
        contexts = contexts
    }

    if tbl3 then
        tbl7.tags = table.clone(self.tags)
        for value, value2 in tbl3 do
            tbl7.tags[value] = value2
        end
    end

    if threads then
        tbl7.threads = threads
    end

    tbl7.debug_meta = self:_buildDebugMeta()

    local callbackWithEventId = createCallbackWithEventId(self.httpService, callback)

    self.transport:send(tbl7, callbackWithEventId)
end

function module:send_event_with_attachments(str1: string, tbl1, callback: ((...any) -> (...any))?)
    if str1 and #tbl1 ~= 0 then
        local callbackWithEventId = createCallbackWithEventId(self.httpService, callback)

        self.transport:send_attachments(str1, tbl1, callbackWithEventId)

        return
    end

    if callback then
        callback(false, { error = "eventId and attachments are required" }, nil)
    end
end

function module:set_user(user)
    self.user = user
end

function module:set_tag(str1: string, arg1)
    self.tags[str1] = tostring(arg1)
end

function module:set_extra(str1: string, arg1)
    self.extra[str1] = arg1
end

function module:add_breadcrumb(arg1)
    arg1.timestamp = os.time()
    table.insert(self.breadcrumbs, arg1)

    if #self.breadcrumbs > 50 then
        table.remove(self.breadcrumbs, 1)
    end
end

return module
