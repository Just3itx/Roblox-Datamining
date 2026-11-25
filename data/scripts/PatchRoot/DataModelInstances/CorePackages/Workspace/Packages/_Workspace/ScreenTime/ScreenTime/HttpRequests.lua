-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ScreenTimeParent = script:FindFirstAncestor("ScreenTime").Parent
local Url = require(ScreenTimeParent.Http).Url
local UrlBuilder = require(ScreenTimeParent.UrlBuilder).UrlBuilder
local Logging = require(ScreenTimeParent.AppCommonLib).Logging
local ArgCheck = require(ScreenTimeParent.ArgCheck)

local tbl1 = {
    GET_INSTRUCTIONS = { errorCode = "number", instructions = "table" },
    INSTRUCTION = {
        type = "number",
        instructionName = "string",
        serialId = "string",
        title = "string",
        message = "string",
        url = "string",
        modalType = "number",
        data = "string"
    },
    REPORT_EXECUTION = { errorCode = "number" }
}

local var1 = UrlBuilder.new({ base = Url.APIS_URL, path = "timed-entertainment-allowance/v1/instructions" })()

local var2 = UrlBuilder.new({ base = Url.APIS_URL, path = "timed-entertainment-allowance/v1/reportExecute" })()

local var3 = UrlBuilder.new({ base = Url.AUTH_URL, path = "v1/logout" })()

local function checkFormat(arg1, arg2)
    for k, value in pairs(arg1) do
        assert(arg2[k] ~= nil, "Missing key")
        assert(type(arg2[k]) == value, "Wrong type")
    end
end

local module = { httpService = nil }

function module.new(arg1, httpService)
    ArgCheck.isNotNil(httpService, "httpService")
    local tbl2 = { httpService = httpService }

    setmetatable(tbl2, arg1)
    arg1.__index = arg1
    return tbl2
end

function module.getInstructions(arg1, callback)
    ArgCheck.isNotNil(arg1.httpService, "httpService")
    ArgCheck.isNotNil(callback, "callback")
    arg1.httpService:RequestInternal({ Url = var1, Method = "GET" }):Start(function(arg2, arg3)
        local bool1 = false
        local tbl2 = {}
        local success, result

        if arg2 then
            if arg3.StatusCode == 401 then
                success = false
                bool1 = true
                result = "Unauthorized"
            elseif arg3.StatusCode < 200 or arg3.StatusCode >= 400 then
                result = "Status code: " .. arg3.StatusCode
                success = false
            else
                success, result = pcall(function()
                    local var4 = arg1.httpService:JSONDecode(arg3.Body)
                    checkFormat(tbl1.GET_INSTRUCTIONS, var4)
                    assert(var4.errorCode == 0, "Error code is not 0")
                    for _, instruction in ipairs(var4.instructions) do
                        checkFormat(tbl1.INSTRUCTION, instruction)
                    end
                    tbl2 = var4.instructions
                end)
            end
        else
            success = false
            result = "Connection error"
        end

        if not success then
            Logging.warn("HttpRequests" .. " getInstructions failed: " .. var1 .. ", " .. result)
        end
        callback(success, bool1, tbl2)
    end)
end

function module.reportExecution(arg1, instructionName, serialId, callback)
    ArgCheck.isNotNil(arg1.httpService, "httpService")

    local execTime = os.date("%Y-%m-%dT%H:%M:%SZ")
    local body = arg1.httpService:JSONEncode({ instructionName = instructionName, serialId = serialId, execTime = execTime })

    arg1.httpService:RequestInternal(
        {
            Url = var2,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = body
        }
    ):Start(
        function(arg2, arg3)
            local result, success

            if arg2 then
                if arg3.StatusCode < 200 and arg3.StatusCode >= 400 then
                    result = "Status code: " .. arg3.StatusCode
                    success = false
                else
                    success, result = pcall(function()
                        local var6 = arg1.httpService:JSONDecode(arg3.Body)
                        checkFormat(tbl1.REPORT_EXECUTION, var6)
                        assert(var6.errorCode == 0, "Error code is not 0")
                    end)
                end
            else
                success = false
                result = "Connection error"
            end

            if not success then
                Logging.warn("HttpRequests" .. " reportExecution failed: " .. var2 .. ", " .. result)
            end
            if callback ~= nil then
                callback(success)
            end
        end
    )
end

function module.logout(arg1)
    ArgCheck.isNotNil(arg1.httpService, "httpService")
    local var4 = arg1.httpService:RequestInternal(
        {
            Url = var3,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = ""
        }
    )

    pcall(function()
        var4:Start(function(_, _) end)
    end)
end

return module
