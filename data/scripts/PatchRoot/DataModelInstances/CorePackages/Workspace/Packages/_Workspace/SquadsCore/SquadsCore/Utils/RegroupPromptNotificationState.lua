-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local module = {}

local getActiveNotifId = nil
local getActiveSquadId = nil

function module.setActive(arg1, str1: string?)
    getActiveNotifId = arg1
    getActiveSquadId = str1
end

function module.getActiveNotifId()
    return getActiveNotifId
end

function module.getActiveSquadId()
    return getActiveSquadId
end

function module.clearActive(notificationId)
    if notificationId == nil or getActiveNotifId == notificationId then
        getActiveNotifId = nil
        getActiveSquadId = nil
    end
end

function module.dismissNotification(notificationId)
    if notificationId == nil then
        return
    end
    pcall(function()
        GuiService:DismissNotification(notificationId)
    end)
    module.clearActive(notificationId)
end

return module
