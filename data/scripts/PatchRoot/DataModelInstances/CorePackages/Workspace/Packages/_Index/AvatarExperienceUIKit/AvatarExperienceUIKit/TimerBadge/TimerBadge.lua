-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local Badge = require(AvatarExperienceUIKitParent.Foundation).Badge
local useLocalization = require(AvatarExperienceUIKitParent.Localization).Hooks.useLocalization

local useRemainingTime = require(AvatarExperienceUIKit.Utils.useRemainingTime)

local function getTimerText(arg1, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local unit = arg1.unit
    local bool1 = arg1.value ~= 1

    if unit == "days" then
        if bool1 then
            return tbl1.dayPlural
        end

        return tbl1.daySingular
    elseif unit == "hours" then
        if bool1 then
            return tbl1.hourPlural
        end

        return tbl1.hourSingular
    elseif unit == "minutes" then
        if bool1 then
            return tbl1.minutePlural
        end

        return tbl1.minuteSingular
    end

    if bool1 then
        return tbl1.secondPlural
    end

    return tbl1.secondSingular
end

local function TimerBadge(tbl1)
    local var1 = useRemainingTime(tbl1.endTime)

    local number = if var1 then var1.value else 0

    local var3 = useLocalization({
        daySingular = "Feature.Catalog.Label.Timer.Day.Singular",
        dayPlural = { "Feature.Catalog.Label.Timer.Day.Plural", number = number },
        hourSingular = "Feature.Catalog.Label.Timer.Hour.Singular",
        hourPlural = { "Feature.Catalog.Label.Timer.Hour.Plural", number = number },
        minuteSingular = "Feature.Catalog.Label.Timer.Minute.Singular",
        minutePlural = { "Feature.Catalog.Label.Timer.Minute.Plural", number = number },
        secondSingular = "Feature.Catalog.Label.Timer.Second.Singular",
        secondPlural = { "Feature.Catalog.Label.Timer.Second.Plural", number = number }
    })

    if not var1 or var1.value < 0 then
        return nil
    end

    return React.createElement(
        Badge,
        {
            LayoutOrder = tbl1.LayoutOrder,
            text = getTimerText(var1, var3),
            variant = tbl1.badgeVariant
        }
    )
end
return TimerBadge
