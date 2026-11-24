-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)

local _CaptureTypes = require(CoreScriptsPlayerFeedback.CaptureTypes)
local fetchGalleryCaptures = require(CoreScriptsPlayerFeedback.Utils.fetchGalleryCaptures)

local function useGalleryCaptures()
    local captures, var2 = React.useState({})
    local isLoading, var4 = React.useState(false)
    local var5 = React.useRef(false)
    local var6 = React.useRef(nil)
    local var7 = React.useRef({})
    local hasMore, var9 = React.useState(true)

    local var10 = React.useCallback(function()
        local current = var7.current
        if #current == 0 then
            return
        end
        local tbl1 = {}
        local currentLen = #current

        for i = 1, math.min(30, currentLen) do
            table.insert(tbl1, current[i])
        end
        local tbl2 = {}
        for i = 31, #current do
            table.insert(tbl2, current[i])
        end
        var7.current = tbl2
        var2(function(arg1)
            local var10 = table.clone(arg1)
            for _, value in tbl1 do
                table.insert(var10, value)
            end
            return var10
        end)
    end, {})

    local var11 = React.useCallback(function()
        local current = var6.current
        if current == nil or current.IsFinished then
            var9(false)
            var4(false)
            return
        end
        var4(true)
        task.spawn(function()
            local gameId = game.GameId

            while #var7.current == 0 do
                if not pcall(function()
                    current:AdvanceToNextPageAsync()
                end) then
                    var4(false)
                    var9(false)
                    return
                end
                for _, value in (current:GetCurrentPage()) do
                    if gameId == 0 or value.SourceUniverseId == gameId then
                        table.insert(var7.current, value)
                    end
                end
                if current.IsFinished then
                    break
                end
            end

            var10()
            var9(#var7.current > 0 or not current.IsFinished)
            var4(false)
        end)
    end, { var10 })

    return {
        captures = captures,
        isLoading = isLoading,
        hasMore = hasMore,
        load = React.useCallback(function()
            if var5.current or isLoading then
                return
            end
            var5.current = true
            var4(true)
            task.spawn(function()
                local current = fetchGalleryCaptures()
                if current == nil then
                    var4(false)
                    var9(false)
                    return
                end
                var6.current = current
                local gameId = game.GameId

                repeat
                    for _, value in (current:GetCurrentPage()) do
                        if gameId == 0 or value.SourceUniverseId == gameId then
                            table.insert(var7.current, value)
                        end
                    end
                until #var7.current >= 30 or current.IsFinished or not pcall(function()
                    current:AdvanceToNextPageAsync()
                end)

                var10()
                var9(#var7.current > 0 or not current.IsFinished)
                var4(false)
            end)
        end, { isLoading, var10 }),
        loadMore = React.useCallback(function()
            if isLoading then
                return
            end

            if #var7.current > 0 then
                var10()
                local current = var6.current
                var9(#var7.current > 0 or not (current == nil) and not current.IsFinished)
            else
                var11()
            end
        end, { isLoading, var10, var11 })
    }
end

return useGalleryCaptures
