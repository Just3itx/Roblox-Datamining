-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppStorageService = game:GetService("AppStorageService")
local Players = game:GetService("Players")

local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local MomentsDraftSerializer = require(MomentsCreation.Utils.MomentsDraftSerializer)
local getLocalUserId = require(MomentsCreation.Utils.getLocalUserId)
local FailureReason = require(MomentsCreation.Enums.FailureReason)

local var1 = require(MomentsCreationParent.Loggers).Logger:new("Moments.DraftStorage")

local num1 = game:DefineFastInt("MomentDraftTTLDays", 14) * 24 * 60 * 60 * 1000

local function clear() -- Luacid: Inlined by compiler; 4 call sites recovered
    pcall(function()
        AppStorageService:SetItem("MomentsDraftStorage", "")
        AppStorageService:Flush()
    end)
end

return {
    save = function(tbl1): boolean
        local userId = getLocalUserId(Players)
        if userId == nil then
            var1:debug("event=save_skipped reason=no_local_player")
            return false
        end

        local tbl2 = {
            userId = userId,
            captureRef = tbl1.captureRef,
            description = tbl1.description,
            commentsEnabled = tbl1.commentsEnabled,
            edits = tbl1.edits,
            lastSaveTime = DateTime.now().UnixTimestampMillis
        }

        local success, result = pcall(function()
            local input = MomentsDraftSerializer.serialize(tbl2)
            AppStorageService:SetItem("MomentsDraftStorage", HttpService:JSONEncode(input))
            AppStorageService:Flush()
        end)

        if not success then
            var1:error("event=save_failed reason=app_storage_write_error error={}", tostring(result))
        end

        return success
    end,
    load = function()
        local localUserId = getLocalUserId(Players)
        if localUserId == nil then
            var1:debug("event=load_failed reason=no_local_player")
            return nil, nil
        end

        local success, result = pcall(function(): string
            return AppStorageService:GetItem("MomentsDraftStorage")
        end)
        if not success then
            var1:debug("event=load_failed reason=app_storage_read_error")
            return nil, nil
        end
        if result == nil or result == "" then
            return nil, nil
        end

        local success2, result2 = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        if not success2 or type(result2) ~= "table" then
            clear()
            return nil, FailureReason.CorruptShape
        end

        local var2 = MomentsDraftSerializer.deserialize(result2)
        if var2 == nil then
            clear()
            return nil, FailureReason.CorruptShape
        end

        if var2.userId ~= localUserId then
            clear()
            return nil, FailureReason.WrongUser
        end

        if not (DateTime.now().UnixTimestampMillis - var2.lastSaveTime > num1) then
            return var2, nil
        end

        clear()
        return nil, FailureReason.ExpiredDraft
    end,
    clear = clear
}
