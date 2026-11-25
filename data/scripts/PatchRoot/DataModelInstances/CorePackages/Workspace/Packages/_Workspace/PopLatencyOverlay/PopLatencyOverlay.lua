-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local React = require(scriptParent.React)
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local GameplayOverlay = require(script.GameplayOverlay)
local Overlay = require(script.Overlay)
local fetchAdminStatus = require(script.fetchAdminStatus)
local observeAdminStatus = require(script.observeAdminStatus)

local function isUserAdmin(arg1)
    return fetchAdminStatus(arg1, HttpRbxApiService, HttpService, ContentProvider.BaseUrl)
end

local function PopLatencyOverlay(arg1)
    return React.createElement(
        "ScreenGui",
        {
            Name = "PopLatencyOverlay",
            IgnoreGuiInset = true,
            ResetOnSpawn = false,
            DisplayOrder = 1000
        },
        React.createElement(Overlay, arg1)
    )
end

local function useAdminAuthorization()
    local var1, var2 = React.useState(0)
    local var3 = React.useRef(nil)

    React.useEffect(function()
        local current, var5 = observeAdminStatus(Players, isUserAdmin, function()
            var2(function(arg1): number
                return arg1 + 1
            end)
        end)
        var3.current = current

        return function()
            var3.current = nil
            var5()
        end
    end, {})

    return React.useCallback(function()
        local current = var3.current
        return not (current == nil) and current()
    end, {}), var1
end

local function GameplayPopLatencyOverlay(arg1)
    return React.createElement(
        "ScreenGui",
        { Name = "GameplayPopLatencyOverlay", ResetOnSpawn = false, DisplayOrder = 1000 },
        React.createElement(GameplayOverlay, arg1)
    )
end

local module = {
    ["jest.config"] = script["jest.config"]
}

function module.adminOnly(_)
    local authorizeToggle, authorizationVersion = useAdminAuthorization()
    return React.createElement(PopLatencyOverlay, {
        authorizationVersion = authorizationVersion,
        authorizeToggle = authorizeToggle,
        deferServiceUntilToggle = true,
        failClosedOnProbeCheck = true
    })
end

module.default = PopLatencyOverlay
module.gameplay = GameplayPopLatencyOverlay

function module.gameplayAdminOnly(arg1)
    local authorizeToggle, authorizationVersion = useAdminAuthorization()
    return React.createElement(GameplayPopLatencyOverlay, {
        experienceService = arg1.experienceService,
        authorizationVersion = authorizationVersion,
        authorizeToggle = authorizeToggle
    })
end

return module
