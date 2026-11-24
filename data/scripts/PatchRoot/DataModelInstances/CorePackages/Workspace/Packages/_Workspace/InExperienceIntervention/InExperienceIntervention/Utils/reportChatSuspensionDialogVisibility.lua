-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("SSUIMetaLua")

local function reportChatSuspensionDialogVisibility(bool1: boolean)
    if not engineFeature then
        return
    end

    pcall(function()
        local SafetyService = game:GetService("SafetyService")
        if bool1 then
            SafetyService:ReportChatSuspensionDialogOpen()
            return
        end
        SafetyService:ReportChatSuspensionDialogClose()
    end)
end

return reportChatSuspensionDialogVisibility
