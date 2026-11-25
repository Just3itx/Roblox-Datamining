-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")
local VoiceChatParent = VoiceChat.Parent

local Promise = require(VoiceChatParent.Promise)
local Signals = require(VoiceChatParent.Signals)

local FIntVoiceRestrictionExpiryGraceSeconds = require(VoiceChat.Flags.FIntVoiceRestrictionExpiryGraceSeconds)

local tbl1 = {
    UNACKNOWLEDGED_UNEXPIRED = 8,
    ACKNOWLEDGED_UNEXPIRED = 9,
    UNACKNOWLEDGED_EXPIRED = 10
}

local function isUFRBanReason(num1: number?): boolean -- Luacid: unused: defined but never referenced
    return num1 == 8 or num1 == 9 or num1 == 10
end

local function isUnacknowledgedBanReason(num1: number?): boolean -- Luacid: unused: defined but never referenced
    return num1 == 8 or num1 == 10
end

local function isJoinLikeTrigger(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 == "gameJoin" or str1 == "expiry" or str1 == "acknowledgement"
end

local function createVoiceRestrictionController(tbl2)
    local getPresentationState, var2 = Signals.createSignal("normal")

    local getNow = tbl2.getNow

    local bool1 = false
    local var3 = nil
    local var4 = nil

    local bool2 = false

    local bool3 = false
    local check = nil

    local function hasEnded(tbl3): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        local bannedUntil = tbl3.bannedUntil
        return not (bannedUntil == nil) and bannedUntil.Seconds <= getNow()
    end

    local function cancelExpiry() -- Luacid: Inlined by compiler; 14 call sites recovered
        bool3 = false
        if var4 then
            task.cancel(var4)
            var4 = nil
        end
    end

    local function endRestriction() -- Luacid: Inlined by compiler; 1 call site recovered
        cancelExpiry()
        bool2 = false
        var2("hiddenUntilRejoin")
    end

    local function scheduleExpiryCheck(num1: number) -- Luacid: Inlined by compiler; 4 call sites recovered
        cancelExpiry()
        local num2 = math.max(num1 - getNow(), 0)
        var4 = task.delay(num2, function()
            var4 = nil
            bool3 = false
            check("expiry")
        end)
    end

    local function scheduleExpiryAfterEnd(num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
        if num1 then
            scheduleExpiryCheck(num1 + FIntVoiceRestrictionExpiryGraceSeconds)
            return
        end

        cancelExpiry()
    end

    local function createAcknowledgementHandler(tbl3) -- Luacid: Inlined by compiler; 6 call sites recovered
        return function()
            if getPresentationState(false) ~= "restricted" or bool2 then
                return
            end
            local bannedUntil = tbl3.bannedUntil
            if not bannedUntil or bannedUntil.Seconds <= getNow() then
                check("acknowledgement")
            end
        end
    end

    local function showUFRRestriction(tbl3, str1: string) -- Luacid: unused: defined but never referenced
        tbl2.showUFRRestriction(tbl3, str1, (createAcknowledgementHandler(tbl3)))
    end

    local function failCheck(trigger: string, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if trigger == "expiry" or trigger == "acknowledgement" then
            endRestriction()
            return
        end

        tbl2.onError(str1)
    end

    local function showDialogIfUnseen(tbl3, tbl4, func1: (...any) -> (...any))
        local trigger = tbl3.trigger
        local banReason = tbl4.banReason
        local bool4 = banReason == tbl1.UNACKNOWLEDGED_UNEXPIRED
            or banReason == tbl1.ACKNOWLEDGED_UNEXPIRED
            or banReason == tbl1.UNACKNOWLEDGED_EXPIRED
        local informedOfBan

        if bool4 and trigger == "removedFromVoice" then
            informedOfBan = true
        elseif isJoinLikeTrigger(trigger) then
            if bool4 then
                informedOfBan = tbl4.banReason == 9
            else
                informedOfBan = tbl2.getInformedOfBan()
                if not func1() then
                    return
                end
            end
        else
            informedOfBan = false
        end

        if informedOfBan ~= false then
            if not tbl3.micTapped then
                if informedOfBan == nil then
                    tbl2.onError("InformedOfBanUnavailable")
                    return
                end
                return
            end

            trigger = "micTap"
        end

        if bool4 then
            tbl2.showUFRRestriction(tbl4, trigger, (createAcknowledgementHandler(tbl4)))
            return
        end

        tbl2.showLegacyRestriction(tbl4, trigger, func1)
    end

    local function handleEndedRestriction(tbl3, tbl4)
        local trigger = tbl3.trigger
        local banReason = tbl4.banReason
        local bool4 = banReason == tbl1.UNACKNOWLEDGED_UNEXPIRED
            or banReason == tbl1.ACKNOWLEDGED_UNEXPIRED
            or banReason == tbl1.UNACKNOWLEDGED_EXPIRED

        if trigger == "removedFromVoice" then
            scheduleExpiryCheck(getNow() + FIntVoiceRestrictionExpiryGraceSeconds)
            bool3 = true
        end

        if bool3 then
            if bool4 and (trigger == "micTap" or tbl3.micTapped) then
                tbl2.showUFRRestriction(tbl4, "micTap", (createAcknowledgementHandler(tbl4)))
            end

            return
        end

        cancelExpiry()
        bool2 = false
        var2("hiddenUntilRejoin")

        local banReason2 = tbl4.banReason

        if (banReason2 == tbl1.UNACKNOWLEDGED_UNEXPIRED or banReason2 == tbl1.UNACKNOWLEDGED_EXPIRED)
            and trigger ~= "acknowledgement"
        then
            tbl2.showUFRRestriction(tbl4, trigger, (createAcknowledgementHandler(tbl4)))
        end
    end

    local function runCheck(tbl3, tbl4)
        local function isCurrent(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
            return var3 == tbl3
        end

        local trigger = tbl3.trigger
        local var5 = tbl4 or tbl2.getSettings()

        if not isCurrent() then
            return
        end

        if not var5 then
            failCheck(trigger, "SettingsUnavailable")
            return
        end

        if var5.isBanned and not hasEnded(var5) then
            bool2 = false
            var2("restricted")
            local seconds = if var5.bannedUntil then var5.bannedUntil.Seconds else nil
            scheduleExpiryAfterEnd(seconds)
            showDialogIfUnseen(tbl3, var5, isCurrent)
            return
        end

        if bool2 then
            if trigger == "micTap" or tbl3.micTapped then
                tbl2.showUFRRestriction(var5, "micTap", (createAcknowledgementHandler(var5)))
            end

            return
        end

        if var5.isBanned or var5.banReason == 10 then
            handleEndedRestriction(tbl3, var5)
        elseif trigger == "gameJoin" or trigger == "removedFromVoice" then
            tbl2.onError("PlayerModeratedBadState")
        else
            cancelExpiry()
            bool2 = false
            var2("hiddenUntilRejoin")
        end
    end

    check = function(trigger: string, tbl3)
        if bool1 then
            return Promise.resolve()
        end

        local var5 = var3
        if trigger == "micTap" and var5 and var5.promise then
            var5.micTapped = true
            return var5.promise
        end

        if trigger == "gameJoin" or trigger == "removedFromVoice" and not bool2 then
            cancelExpiry()
        end

        if trigger == "gameJoin" or trigger == "expiry" then
            bool2 = false
        end

        local tbl4 = { trigger = trigger, micTapped = false }
        var3 = tbl4

        if not tbl3 or tbl3.banReason == nil then
            tbl3 = nil
        end

        local var6 = trigger == "gameJoin" and tbl3 ~= nil and tbl3.isBanned and hasEnded(tbl3)

        if trigger ~= "micTap" and not var6 then
            var2("restricted")
        end

        local promise = Promise.defer(function(callback)
            runCheck(tbl4, tbl3)
            callback()
        end):catch(function()
            if var3 == tbl4 then
                failCheck(trigger, "RestrictionRequestFailed")
            end
        end)
        tbl4.promise = promise
        promise:finally(function()
            tbl4.promise = nil
        end)

        return promise
    end

    return {
        getPresentationState = getPresentationState,
        check = check,
        applyUFRTimeout = function(num1: number?)
            if bool1 then
                return
            end

            var3 = nil
            bool2 = true
            var2("restricted")
            scheduleExpiryAfterEnd(num1)
        end,
        showPendingAcknowledgement = function(tbl3)
            if not bool1
                and not tbl3.isBanned
                and tbl3.banReason == 10
                and getPresentationState(false) == "normal"
                and not (var3 or bool2)
            then
                tbl2.showUFRRestriction(tbl3, "gameJoin", (createAcknowledgementHandler(tbl3)))
            end
        end,
        dispose = function()
            bool1 = true
            if var3 and var3.promise then
                var3.promise:cancel()
            end
            var3 = nil
            cancelExpiry()
            var2("normal")
        end
    }
end
return createVoiceRestrictionController
