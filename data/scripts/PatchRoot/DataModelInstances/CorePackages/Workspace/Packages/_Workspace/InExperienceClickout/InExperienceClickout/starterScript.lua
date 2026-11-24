-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WebViewService = game:GetService("WebViewService")
local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Loggers = require(scriptParentParent.Loggers)

local ClickoutTelemetry = require(scriptParent.ClickoutTelemetry)

local flaggedMutedError = Loggers.flaggedMutedError

local bool1 = game:DefineFastFlag("LuaAppIsClickoutEnabledUniverse", false)
local GetFFlagEnableUnifiedWebViews = require(scriptParentParent.SharedFlags).GetFFlagEnableUnifiedWebViews

local function starterScript()
    if not bool1 then
        return
    end

    ReplicatedStorage:WaitForChild("AdClickoutEvent").Event:Connect(function(url: string)
        if string.find(url, "[<>]") then
            flaggedMutedError("InExperienceClickout_InvalidURL", `AdClickoutEvent received invalid URL: {url}`)
            return
        end

        if not string.match(url, "^https://") then
            flaggedMutedError(
                "InExperienceClickout_InvalidURL",
                `AdClickoutEvent received URL with invalid scheme: {url}`
            )
            return
        end

        if #url == 0 then
            flaggedMutedError("InExperienceClickout_InvalidURL", "AdClickoutEvent received empty URL.")
            return
        end

        if #url > 512 then
            flaggedMutedError(
                "InExperienceClickout_InvalidURL",
                `AdClickoutEvent received URL exceeding max length: {url}`
            )
            return
        end

        local str1 = HttpService:GenerateGUID(false)

        local connection = nil
        if GetFFlagEnableUnifiedWebViews() then
            connection = WebViewService.OnWindowClosed:Connect(function()
                ClickoutTelemetry.logWebviewToggled(false, str1, url)
                WebViewService:CloseWindow()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end)
        else
            connection = BrowserService.BrowserWindowClosed:Connect(function()
                ClickoutTelemetry.logWebviewToggled(false, str1, url)
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end)
        end

        ClickoutTelemetry.logWebviewToggled(true, str1, url)
        if GetFFlagEnableUnifiedWebViews() then
            WebViewService:OpenWindow(url, nil, true, nil, nil, true)
            return
        end

        local success, result = pcall(function(): string
            return HttpService:JSONEncode(
                {
                    command = "open",
                    url = url,
                    visible = true,
                    isGenericWebview = true,
                    showDomainAsTitle = true
                }
            )
        end)

        if not success then
            flaggedMutedError(
                "InExperienceClickout_JSONEncodeFailed",
                `AdClickoutEvent failed to JSON encode command for URL: {url}`
            )
            return
        end
        BrowserService:SendCommand(result)
    end)
end

return starterScript
