-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local commentTimestamp = require(script.Parent.commentTimestamp)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    minutes = "Feature.Moments.Label.CommentTimestampMinutes",
    hours = "Feature.Moments.Label.CommentTimestampHours",
    days = "Feature.Moments.Label.CommentTimestampDays",
    weeks = "Feature.Moments.Label.CommentTimestampWeeks",
    months = "Feature.Moments.Label.CommentTimestampMonths",
    years = "Feature.Moments.Label.CommentTimestampYears"
}

local function useCommentTimestamp(str1: string)
    local var1 = React.useMemo(function()
        return commentTimestamp.parseTimestamp(str1)
    end, { str1 })
    local var2, var3 = React.useState(function(): number
        return DateTime.now().UnixTimestampMillis
    end)

    React.useEffect(function()
        var3(DateTime.now().UnixTimestampMillis)
        if var1 == nil then
            return
        end

        local bool1 = false
        local var4 = nil

        local function scheduleUpdate()
            local unixTimestampMillis = DateTime.now().UnixTimestampMillis
            local nextChangeTimestamp = commentTimestamp.getNextChangeTimestamp(var1, unixTimestampMillis)
            if nextChangeTimestamp == nil then
                var4 = nil
                return
            end
            local num1 = math.max(0, nextChangeTimestamp - unixTimestampMillis) / 1000
            var4 = task.delay(num1, function()
                var4 = nil
                if bool1 then
                    return
                end
                var3(DateTime.now().UnixTimestampMillis)
                scheduleUpdate()
            end)
        end

        scheduleUpdate()
        return function()
            bool1 = true
            if var4 ~= nil then
                task.cancel(var4)
                var4 = nil
            end
        end
    end, { var1 })

    local relativeAge = commentTimestamp.getRelativeAge(var1, var2)
    local var4 = useLocalization({
        timestamp = if relativeAge == nil then nil elseif relativeAge.unit == "now" then "Feature.Moments.Label.CommentTimestampNow" else {
            tbl1[relativeAge.unit],
            count = relativeAge.count
        }
    })

    return if relativeAge == nil then nil else var4.timestamp
end

return useCommentTimestamp
