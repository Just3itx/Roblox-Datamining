-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local _Modules = RobloxGui:WaitForChild("Modules")

local UIBlox = require(CorePackages.Packages.UIBlox)
local UIBloxInGameConfig = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).UIBloxInGameConfig
UIBlox.init(UIBloxInGameConfig)

local bool1 = game:DefineFastFlag("FeedbackModuleEarlyFontInitialization", false)

local FFlagBuildExperienceInstanceSelection = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBuildExperienceInstanceSelection
local InstanceSelectionProtocol = if FFlagBuildExperienceInstanceSelection then require(CorePackages.Workspace.Packages.BuildExperience.InstanceSelectionProtocol) else nil

local function isSelectingInstance() -- Luacid: Inlined by compiler; 2 call sites recovered
    return FFlagBuildExperienceInstanceSelection and InstanceSelectionProtocol.getActiveRequest() ~= nil
end

if bool1 then
    local TextService = game:GetService("TextService")
    local getTextBoundsParams = Instance.new("GetTextBoundsParams")
    getTextBoundsParams.Text = "random text"
    getTextBoundsParams.Font = Font.fromEnum(Enum.Font.Gotham)
    getTextBoundsParams.Size = 19
    getTextBoundsParams.Width = 0
    local _vector2 = TextService:GetTextBoundsAsync(getTextBoundsParams)
end
local MessageBusService = game:GetService("MessageBusService")
local messageId = MessageBusService:GetMessageId("CaptureMode", "sceneSelectionExitReason")

game:GetService("GuiService").NativeClose:Connect(function() -- name: handleNativeExit
    if isSelectingInstance() then
        InstanceSelectionProtocol.finishSelection({ status = "cancelled" })
        return
    end
    MessageBusService:Publish(messageId, { reason = "nativeExit" })
    game:GetService("ExperienceStateCaptureService"):ToggleCaptureMode()
end)
game:WaitForChild("SafetyService")
local SafetyService = game:GetService("SafetyService")

if isSelectingInstance() then
    require(CorePackages.Workspace.Packages.BuildExperience.mountInstanceSelection)()
elseif SafetyService.IsCaptureModeForReport then
    require(CorePackages.Workspace.Packages.InGameAssetReporting).initialize()
else
    require(RobloxGui.Modules.Feedback).initialize()
end
