-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent

local Promise = require(VoiceChatParent.Promise)
local Signals = require(VoiceChatParent.Signals)

local function createVoiceRestrictionController_DEPRECATED(tbl1)
    local getPresentationState, var2 = Signals.createSignal("normal")

    local num1 = 0
    local bool1 = false
    local var3 = nil
    local var4 = nil
    local bool2 = false
    local var5 = nil

    local function cancelExpiry() -- Luacid: Inlined by compiler; 7 call sites recovered
        if var5 then
            task.cancel(var5)
            var5 = nil
        end
    end

    local function expireRestriction() -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool1 then
            return
        end

        cancelExpiry()
        num1 += 1
        var2("hiddenUntilRejoin")
    end

    local function scheduleExpiry(tbl2)
        cancelExpiry()
        local bannedUntil = tbl2.bannedUntil
        if not bannedUntil then
            return
        end

        local var6 = bannedUntil.Seconds - DateTime.now().UnixTimestamp
        if var6 <= 0 then
            return
        end

        var5 = task.delay(var6, function()
            var5 = nil
            expireRestriction()
        end)
    end

    local function runCheck(str1: string, tbl2, func1: (...any) -> (...any))
        local var6 = tbl2 and tbl2.banReason ~= nil and tbl2 or tbl1.getSettings()

        if not func1() then
            return
        end

        if not var6 then
            tbl1.onError("SettingsUnavailable")
            return
        end

        if not var6.isBanned then
            if str1 == "micTap" then
                cancelExpiry()
                var2("hiddenUntilRejoin")
                return
            end
            tbl1.onError("PlayerModeratedBadState")
            return
        end

        var2("restricted")
        scheduleExpiry(var6)
        local informedOfBan = str1 == "gameJoin" and tbl1.getInformedOfBan()

        if not func1() then
            return
        end

        if informedOfBan == false then
            tbl1.showLegacyRestriction(var6, str1, func1)
        elseif bool2 then
            tbl1.showLegacyRestriction(var6, "micTap", func1)
        elseif informedOfBan == nil then
            tbl1.onError("InformedOfBanUnavailable")
        end
    end

    return {
        getPresentationState = getPresentationState,
        check = function(str1: string, tbl2)
            if bool1 then
                return Promise.resolve()
            end

            if str1 == "expiry" then
                expireRestriction()
                return Promise.resolve()
            end

            if str1 == "micTap" and var3 then
                if var4 == "gameJoin" then
                    bool2 = true
                end
                return var3
            end

            if str1 == "gameJoin" or str1 == "removedFromVoice" then
                cancelExpiry()
            end

            bool2 = false
            num1 += 1
            local num2 = num1
            local function isCurrent(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
                return not bool1 and num1 == num2
            end

            if str1 ~= "micTap" then
                var2("restricted")
            end

            local var6 = Promise.defer(function(callback)
                runCheck(str1, tbl2, isCurrent)
                callback()
            end):catch(function()
                if isCurrent() then
                    tbl1.onError("RestrictionRequestFailed")
                end
            end)

            var3 = var6
            var4 = str1
            var6:finally(function()
                if var3 == var6 then
                    var3 = nil
                    var4 = nil
                    bool2 = false
                end
            end)

            return var6
        end,
        dispose = function()
            bool1 = true
            num1 += 1

            if var3 then
                var3:cancel()
                var3 = nil
                var4 = nil
                bool2 = false
            end

            cancelExpiry()
            var2("normal")
        end
    }
end
return createVoiceRestrictionController_DEPRECATED
