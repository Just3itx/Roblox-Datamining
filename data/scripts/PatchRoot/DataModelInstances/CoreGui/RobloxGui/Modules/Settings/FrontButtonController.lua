-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TeleportService = game:GetService("TeleportService")
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local Promise = require(CorePackages.Packages.Promise)
local Roact = require(CorePackages.Packages.Roact)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local var1 = require(RobloxGui.Modules.Common.httpRequest)(HttpRbxApiService)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local GetGameNameAndDescription = require(CorePackages.Workspace.Packages.GameDetailRodux).GetGameNameAndDescription
local engineFeature = game:GetEngineFeature("TeleportHistoryButtons")

local num1 = 0
local var2

if engineFeature then
    local _
    var2, _ = TeleportService:GetThirdPartyTeleportInfo(true)
else
    var2 = 0
end

if engineFeature and var2 > 0 then
    num1 = var2
end

local function truncateWithEllipsis(arg1, arg2) -- Luacid: unused: defined but never referenced
    if not (arg2 < #arg1) then
        return arg1
    end

    return string.sub(arg1, 1, arg2 - 3) .. "..."
end

local var3 = nil
local var4 = Promise.defer(function(callback)
    if not (num1 > 0) then
        callback()

        return
    end

    GetGameNameAndDescription(var1, num1):andThen(function(arg1)
        local name = arg1.Name

        if #name > 30 then
            name = string.sub(name, 1, 27) .. "..."
        end

        var3 = name
    end):await()
    callback()
end)
local module = {}
function module.getTooltipText()
    if var3 == nil then
        return RobloxTranslator:FormatByKey("InGame.CommonUI.Label.ReturnFallback")
    end
    return RobloxTranslator:FormatByKey("InGame.CommonUI.Label.ReturnTo", { placeName = var3 })
end

function module.getTooltipTextTimeout()
    if var3 == nil then
        Promise.any({ var4, Promise.delay(1) }):await()
    end
    return module.getTooltipText()
end

function module.getMenuText()
    local var5, var6 = Roact.createBinding(module.getTooltipText())
    if var3 == nil then
        pcall(function()
            var4:andThen(function()
                var6(module.getTooltipText())
            end)
        end)
    end
    return var5
end

function module.initiateFrontButtonTeleport()
    if engineFeature then
        TeleportService:TeleportTrustedBackForth(true)
    end
end

function module.hasReturnUniverse(): boolean
    return num1 > 0
end
return module
