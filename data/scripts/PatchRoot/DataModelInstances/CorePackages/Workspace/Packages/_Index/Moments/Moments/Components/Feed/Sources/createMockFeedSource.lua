-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local MomentsMomentFixtures = require(MomentsParent.DataHydration.MomentsMomentFixtures)

local function createMockFeedSource(tbl1)
    local tbl2 = tbl1 or {}
    local pageSize = tbl2.pageSize or 5
    local total = tbl2.total
    local latencySeconds = tbl2.latencySeconds or 0
    local failAfterPages = tbl2.failAfterPages
    local bool1 = tbl2.deferred == true

    local num1 = 0

    local tbl3 = {}

    local function buildPage(num2: number)
        local var1 = if total ~= nil then math.max(total - (num2 - 1), 0) else pageSize
        local num3 = math.min(pageSize, var1)
        local num4 = num2 + num3
        local bool2 = total == nil or num4 <= total
        local tbl4 = {
            items = MomentsMomentFixtures.buildMomentFeedItems(num2, num3),
            nextCursor = 0
        }

        if not bool2 then
            num4 = nil
        end

        tbl4.nextCursor = num4
        return tbl4
    end

    return {
        fetchAsync = function(num2: number?)
            local num3 = num2 or 1
            num1 += 1
            local num4 = num1

            if bool1 then
                table.insert(tbl3, coroutine.running())
                local var1, var2 = coroutine.yield()
                if not var1 then
                    error(var2 or "mock feed source fetch rejected")
                end
            else
                if latencySeconds > 0 then
                    task.wait(latencySeconds)
                end
                if failAfterPages ~= nil and failAfterPages < num4 then
                    error(`mock feed source failed on page {num4}`)
                end
            end

            return (buildPage(num3))
        end,
        id = tbl2.id or "mock",
        recommendationSource = tbl2.recommendationSource or "Trending",
        endsWithCaughtUp = tbl2.endsWithCaughtUp,
        dispose = function() end,
        getPendingCount = function(): number
            return #tbl3
        end,
        resolveNext = function()
            local var1 = table.remove(tbl3, 1)
            if var1 == nil then
                return
            end

            local var2, var3 = coroutine.resume(var1, true)
            if not var2 then
                error(var3)
            end
        end,
        rejectNext = function(str1: string?)
            local var1 = table.remove(tbl3, 1)
            if var1 == nil then
                return
            end

            local var2, var3 = coroutine.resume(var1, false, str1)
            if not var2 then
                error(var3)
            end
        end
    }
end

return createMockFeedSource
