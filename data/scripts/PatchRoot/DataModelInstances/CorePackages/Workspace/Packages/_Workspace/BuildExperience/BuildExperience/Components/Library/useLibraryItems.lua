-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local React = require(BuildExperience.Parent.React)
local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local getLibraryMatches = require(script.Parent.getLibraryMatches)

local function useLibraryItems(str1: string, tbl1, kind, str2: string, count: number, str3: string?, str4: string?)
    local key = React.useMemo(function()
        return {}
    end, {
        str1,
        kind or false,
        str2,
        str3 or false,
        str4 or false
    })

    local var2, var3 = React.useState({ key = key, count = count })
    local var1 = if var2.key == key then var2.count else count
    local libraryMatches = getLibraryMatches(tbl1, kind, str2, str4, str2 ~= "")
    local libraryMatchesLen = #libraryMatches
    local tbl2 = table.move(libraryMatches, 1, math.min(var1, libraryMatchesLen), 1, {})
    local bool1 = var1 < libraryMatchesLen
    local var5 = React.useRef({ key = key, count = var1 })
    React.useEffect(function()
        local current = var5.current
        if current.key == key and var1 > current.count then
            local num2 = math.min(var1, libraryMatchesLen) - math.min(current.count, libraryMatchesLen)
            if num2 > 0 then
                sendBuildExperienceEvent("LIBRARY_LOAD_MORE", {
                    universeId = game.GameId,
                    placeId = game.PlaceId
                }, {
                    surface = if str3 == nil then "Browser" else "Category",
                    kind = kind or "All",
                    scope = if str4 == nil then "Root" else "Folder",
                    addedCount = tostring(num2),
                    visibleCount = tostring(math.min(var1, libraryMatchesLen))
                })
            end
        end
        var5.current = { key = key, count = var1 }
    end, {
        key,
        var1,
        libraryMatchesLen,
        kind or false,
        str3 or false,
        str4 or false
    })

    return tbl2, bool1, (React.useCallback(function()
        if bool1 then
            var3({ key = key, count = var1 + count })
        end
    end, {
        key,
        var1,
        count,
        bool1
    }))
end
return useLibraryItems
