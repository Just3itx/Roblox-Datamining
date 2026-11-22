-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local IconName = require(SocialCardsParent.Foundation).Enums.IconName

local CallCardStatus = require(script.Parent.CallCardStatus)

local function formatDuration(durationSeconds: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    if not (durationSeconds >= 60) then
        return `{durationSeconds} sec`
    end

    local num1 = durationSeconds / 60
    return `{math.floor(num1)} min`
end

local function mapCallCard(tbl1, func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?, func3: ((...any) -> (...any))?)
    local isRinging = tbl1.status == CallCardStatus.Ringing or tbl1.status == CallCardStatus.Active
    local icon = if tbl1.isInitiator then IconName.PhoneArrowDiagonalUp else IconName.PhoneArrowDiagonalDown
    local str1 = "Voice call"
    local str2

    if isRinging then
        str2 = "Ringing"
        if tbl1.isInitiator then
            func2 = nil
        else
            func2 = func1
        end
    elseif tbl1.status == CallCardStatus.Ongoing then
        func2 = func3
        str2 = "Ongoing"
    elseif tbl1.status == CallCardStatus.Answered or tbl1.status == CallCardStatus.Ended then
        if tbl1.durationSeconds == nil then
            str2 = nil
        else
            local durationSeconds = tbl1.durationSeconds
            str2 = formatDuration(durationSeconds)
        end
    elseif tbl1.isInitiator then
        str2 = "No answer"
    else
        str1 = "Missed voice call"
        str2 = "Tap to call back"
    end

    return {
        icon = icon,
        title = str1,
        description = str2,
        isRinging = isRinging,
        onActivated = func2
    }
end

return mapCallCard
