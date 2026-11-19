-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function getStaticAttributes()
    return {
        LocalVersion = RunService:GetRobloxVersion(),
        BaseUrl = ContentProvider.BaseUrl,
        PlaceId = game.PlaceId,
        Platform = UserInputService:GetPlatform().Name,
        UserAgent = HttpService:GetUserAgent(),
        CoreScriptVersion = RunService:GetCoreScriptVersion()
    }
end

local function createCoreScriptReportProcessor(tbl1)
    local var1 = tbl1 or getStaticAttributes()

    local function processReport<T>(arg1: T): T
        arg1:addAttributes(var1)

        arg1:addAttributes({ PlayerCount = #Players:GetPlayers() })

        arg1:addAttributes({ RobloxChannel = RunService:GetRobloxClientChannel() })

        return arg1
    end

    return processReport, var1
end

return createCoreScriptReportProcessor
