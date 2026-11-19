-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Modules = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("Modules")
local CorePackages = game:GetService("CorePackages")

local PlaceId = game.PlaceId
local select2 = select
local var1 = select2("#", ...)
if PlaceId <= 0 and var1 > 0 then
    local select = select
    PlaceId = select(1, ...)
end

if game:DefineFastFlag("EnableExperienceGenericChallengeRenderingOnLoadingScript", false) then
    coroutine.wrap(function()
        require(CorePackages.Workspace.Packages.GenericChallenges).Middleware.InitExperienceChallengeInterceptor()
    end)()
end

if require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.teamCreateUtils).isViewer() then
    require(CorePackages.Packages.UIBlox).init(
        require(CorePackages.Workspace.Packages.CoreScriptsInitializer).UIBloxInGameConfig
    )
    require(CorePackages.Workspace.Packages.BuildExperience.mountTeamCreateViewer)(PlaceId)
    return
end

local loadingScript = require(CorePackages.Workspace.Packages.ExperienceLoadingScript).loadingScript
coroutine.wrap(loadingScript)(PlaceId, 72)
