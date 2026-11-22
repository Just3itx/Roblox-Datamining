-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)
local sendPromptModalSkippedEvent = require(ServerTriggeredModals.sendPromptModalSkippedEvent)
local _PromptEntry = require(ServerTriggeredModals.SduiV2.Types.PromptEntry)

local FFlagPromptsImpressionUsesTitle = SharedFlags.FFlagPromptsImpressionUsesTitle

local Reason = {
    AlreadyShown = "alreadyShown",
    NotFocused = "notFocused",
    IncompleteEntry = "incompleteEntry",
    LegacyMetadata = "legacyMetadata"
}

local tbl2 = ({})
local tbl3 = ({})

local function getModalType(tbl4) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (if FFlagPromptsImpressionUsesTitle then tbl4.title else tbl4.robloxComponentType) or ""
end

local function log(reason: string, entryPoint: string, tbl4)
    local identifier = tbl4.identifier or ""
    local modalType = getModalType(tbl4)
    local var1 = tbl2[entryPoint]

    if reason == Reason.AlreadyShown and var1 ~= nil and tbl4.identifier ~= nil and var1.identifier == tbl4.identifier then
        return
    end
    local var2 = entryPoint .. "|" .. identifier .. "|" .. modalType .. "|" .. reason
    if tbl3[var2] then
        return
    end
    tbl3[var2] = true

    sendPromptModalSkippedEvent({
        reason = reason,
        modalId = identifier,
        modalType = modalType,
        entryPoint = entryPoint,
        shownByModalId = var1 and var1.identifier or "",
        shownByModalType = if var1 then getModalType(var1) else ""
    })
end

return {
    Reason = Reason,
    log = log,
    logAll = function(reason: string, entryPoint: string, tbl4)
        for _, value in tbl4 do
            log(reason, entryPoint, value)
        end
    end,
    markShown = function(str1: string, tbl4)
        if tbl2[str1] == nil then
            tbl2[str1] = tbl4
        end
    end,
    resetForTests = function()
        tbl2 = {}
        tbl3 = {}
    end
}
