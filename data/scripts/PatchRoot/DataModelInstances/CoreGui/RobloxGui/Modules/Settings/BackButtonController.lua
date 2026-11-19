-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local TeleportService = game:GetService("TeleportService")
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local Promise = require(CorePackages.Packages.Promise)
local Roact = require(CorePackages.Packages.Roact)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local var1 = require(RobloxGui.Modules.Common.httpRequest)(HttpRbxApiService)

local engineFeature = game:GetEngineFeature("TeleportHistoryButtons")

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local GetGameNameAndDescription = require(CorePackages.Workspace.Packages.GameDetailRodux).GetGameNameAndDescription
local bool1 = false

local num1 = 0
local var2, var3 = AdService:GetAdTeleportInfo()
if var2 > 0 and (var3 == 0 or var3 == game.GameId) then
    num1 = var2
    if engineFeature then
        bool1 = true
    end
end

if engineFeature and num1 == 0 then
    local var4, _ = TeleportService:GetThirdPartyTeleportInfo(false)
    if var4 > 0 then
        num1 = var4
    end
    bool1 = false
end

local function truncateWithEllipsis(arg1, arg2) -- Luacid: unused: defined but never referenced
    if not (arg2 < #arg1) then
        return arg1
    end

    return string.sub(arg1, 1, arg2 - 3) .. "..."
end

local var4 = nil
local var5 = Promise.defer(function(callback)
    if not (num1 > 0) then
        callback()

        return
    end

    GetGameNameAndDescription(var1, num1):andThen(function(arg1)
        var4 = arg1.Name
        if not engineFeature then
            return
        end

        local name = arg1.Name

        if #name > 30 then
            name = string.sub(name, 1, 27) .. "..."
        end

        var4 = name
    end):await()
    callback()
end)
local module = {}

function module.getTooltipText()
    if var4 == nil then
        return RobloxTranslator:FormatByKey("InGame.CommonUI.Label.ReturnFallback")
    end
    return RobloxTranslator:FormatByKey("InGame.CommonUI.Label.ReturnTo", { placeName = var4 })
end

function module.getTooltipTextTimeout()
    if var4 == nil then
        Promise.any({ var5, Promise.delay(1) }):await()
    end
    return module.getTooltipText()
end

function module.getMenuText()
    local var6, var7 = Roact.createBinding(module.getTooltipText())
    if var4 == nil then
        pcall(function()
            var5:andThen(function()
                var7(module.getTooltipText())
            end)
        end)
    end
    return var6
end

function module.initiateBackButtonTeleport(adTeleportMethod: Enum.AdTeleportMethod)
    if engineFeature then
        if bool1 then
            AdService:ReturnToPublisherExperience(adTeleportMethod)
        else
            TeleportService:TeleportTrustedBackForth(false)
        end
    end
    AdService:ReturnToPublisherExperience(adTeleportMethod)
end

function module.hasReturnUniverse(): boolean
    return num1 > 0
end

return module
