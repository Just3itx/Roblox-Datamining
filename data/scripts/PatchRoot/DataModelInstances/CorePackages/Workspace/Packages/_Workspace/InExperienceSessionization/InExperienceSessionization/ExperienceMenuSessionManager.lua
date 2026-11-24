-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionType = require(script.Parent.SessionType)

local module = {}
module.__index = module

function module.new(_sessionService)
    local self = setmetatable({}, module)
    if _sessionService then
        self._sessionService = _sessionService
    else
        self._sessionService = game:GetService("SessionService")
    end

    self._currentMenuTab = nil

    return self
end

function module:_setMetadata(str1: string, str2: string, str3: string)
    self._sessionService:SetMetadata(str1, str2, str3)
end

function module:OpenExperienceMenu(tbl1)
    self._sessionService:SetSession(
        SessionType.StructuralIdentifier.Level2a,
        SessionType.StructuralIdentifier.ExperienceMenu,
        SessionType.Tag.level3.ExperienceMenu
    )
    if not tbl1 then
        return
    end

    for k, value in pairs(tbl1) do
        self._sessionService:SetMetadata(SessionType.StructuralIdentifier.ExperienceMenu, k, value)
    end
end

function module:CloseExperienceMenu()
    self:CloseOpenedMenuTab()
    self._sessionService:RemoveSession(SessionType.StructuralIdentifier.ExperienceMenu)
end

function module:CloseOpenedMenuTab()
    if self._currentMenuTab then
        self._sessionService:RemoveSession(self._currentMenuTab)
        self._currentMenuTab = nil
    end
end

function module:OpenPeopleTab(str1: string?, tbl1)
    local var1 = str1 or SessionType.StructuralIdentifier.ExperienceMenu
    self._sessionService:SetSession(var1, SessionType.StructuralIdentifier.PeopleTab, SessionType.Tag.level3.PeopleTab)

    if tbl1 then
        for k, value in pairs(tbl1) do
            self._sessionService:SetMetadata(SessionType.StructuralIdentifier.PeopleTab, k, value)
        end
    end
    self._currentMenuTab = SessionType.StructuralIdentifier.PeopleTab
end

function module:OpenSettingsTab(str1: string?, tbl1)
    local var1 = str1 or SessionType.StructuralIdentifier.ExperienceMenu
    self._sessionService:SetSession(var1, SessionType.StructuralIdentifier.SettingsTab, SessionType.Tag.level3.SettingsTab)

    if tbl1 then
        for k, value in pairs(tbl1) do
            self._sessionService:SetMetadata(SessionType.StructuralIdentifier.SettingsTab, k, value)
        end
    end
    self._currentMenuTab = SessionType.StructuralIdentifier.SettingsTab
end

function module:OpenCapturesTab(str1: string?, tbl1)
    local var1 = str1 or SessionType.StructuralIdentifier.ExperienceMenu
    self._sessionService:SetSession(var1, SessionType.StructuralIdentifier.CapturesTab, SessionType.Tag.level3.CapturesTab)

    if tbl1 then
        for k, value in pairs(tbl1) do
            self._sessionService:SetMetadata(SessionType.StructuralIdentifier.CapturesTab, k, value)
        end
    end
    self._currentMenuTab = SessionType.StructuralIdentifier.CapturesTab
end

function module:OpenReportTab(str1: string?, tbl1)
    local var1 = str1 or SessionType.StructuralIdentifier.ExperienceMenu
    self._sessionService:SetSession(var1, SessionType.StructuralIdentifier.ReportTab, SessionType.Tag.level3.ReportTab)

    if tbl1 then
        for k, value in pairs(tbl1) do
            self._sessionService:SetMetadata(SessionType.StructuralIdentifier.ReportTab, k, value)
        end
    end
    self._currentMenuTab = SessionType.StructuralIdentifier.ReportTab
end

function module:OpenHelpTab(str1: string?, tbl1)
    local var1 = str1 or SessionType.StructuralIdentifier.ExperienceMenu
    self._sessionService:SetSession(var1, SessionType.StructuralIdentifier.HelpTab, SessionType.Tag.level3.HelpTab)

    if tbl1 then
        for k, value in pairs(tbl1) do
            self._sessionService:SetMetadata(SessionType.StructuralIdentifier.HelpTab, k, value)
        end
    end
    self._currentMenuTab = SessionType.StructuralIdentifier.HelpTab
end

function module:OpenLeaveExperience(str1: string?, tbl1)
    local var1 = str1 or SessionType.StructuralIdentifier.ExperienceMenu
    self._sessionService:SetSession(
        var1,
        SessionType.StructuralIdentifier.LeaveExperience,
        SessionType.Tag.level3.LeaveExperience
    )

    if tbl1 then
        for k, value in pairs(tbl1) do
            self._sessionService:SetMetadata(SessionType.StructuralIdentifier.LeaveExperience, k, value)
        end
    end
    self._currentMenuTab = SessionType.StructuralIdentifier.LeaveExperience
end

function module:OpenResetCharacter(str1: string?, tbl1)
    local var1 = str1 or SessionType.StructuralIdentifier.ExperienceMenu
    self._sessionService:SetSession(
        var1,
        SessionType.StructuralIdentifier.ResetCharacter,
        SessionType.Tag.level3.ResetCharacter
    )

    if tbl1 then
        for k, value in pairs(tbl1) do
            self._sessionService:SetMetadata(SessionType.StructuralIdentifier.ResetCharacter, k, value)
        end
    end
    self._currentMenuTab = SessionType.StructuralIdentifier.ResetCharacter
end

function module.MenuSwitchToPage(arg1, arg2)
    if arg2 == nil then
        return
    end
    arg1:CloseOpenedMenuTab()
    local name = arg2.Name

    if name == "Players" then
        arg1:OpenPeopleTab()
    elseif name == "Page" then
        arg1:OpenSettingsTab()
    elseif name == "Captures" then
        arg1:OpenCapturesTab()
    elseif name == "ReportAbuseMenuNewContainerPage" then
        arg1:OpenReportTab()
    elseif name == "Help" then
        arg1:OpenHelpTab()
    elseif name == "LeaveGamePage" then
        arg1:OpenLeaveExperience()
    elseif name == "ResetCharacter" then
        arg1:OpenResetCharacter()
    end
end

return module
