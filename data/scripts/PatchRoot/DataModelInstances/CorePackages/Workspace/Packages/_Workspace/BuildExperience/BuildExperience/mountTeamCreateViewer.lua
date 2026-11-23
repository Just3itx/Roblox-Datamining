-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local BuildModeLaunch = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.BuildModeLaunch)
local GetLibraryStore = require(BuildExperience.Stores.GetLibraryStore)
local createTeamCreateFreeCamera = require(BuildExperience.createTeamCreateFreeCamera)
local mountChatSheet = require(BuildExperience.mountChatSheet)
local mountLibrary = require(BuildExperience.mountLibrary)

local bool1 = false
local bool2 = false

local function mountTeamCreateViewer(num1: number, arg1)
    if not bool1 then
        bool1 = true
        BuildModeLaunch:applyViewerTheme()
        mountLibrary(nil, BuildModeLaunch:getChatSessionId(num1))
    end
    if arg1 == nil or bool2 then
        return
    end
    bool2 = true
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

    local teamCreateFreeCamera = createTeamCreateFreeCamera(workspace.CurrentCamera, arg1, GetLibraryStore())
    RunService.RenderStepped:Connect(teamCreateFreeCamera.step)
    mountChatSheet()
end

return mountTeamCreateViewer
