-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Localization = require(BuildExperienceParent.Localization)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local _LibraryTypes = require(script.Parent.LibraryTypes)

local tbl1 = {
    title = LocalizationStrings.LIBRARY_TITLE,
    empty = LocalizationStrings.LIBRARY_EMPTY,
    image = LocalizationStrings.LIBRARY_IMAGES_2D,
    sound = LocalizationStrings.LIBRARY_SOUNDS,
    modelUnavailable = LocalizationStrings.LIBRARY_MODEL_UNAVAILABLE,
    searchPlaceholder = LocalizationStrings.LIBRARY_SEARCH_PLACEHOLDER
}
local tbl2 = {
    model = { LocalizationStrings.LIBRARY_OBJECTS_3D, "3D Objects" },
    object = { LocalizationStrings.LIBRARY_OBJECT, "Object" },
    world = { LocalizationStrings.LIBRARY_WORLD, "World" },
    searchEmpty = { LocalizationStrings.LIBRARY_SEARCH_EMPTY, "No search results found" },
    selectAll = { LocalizationStrings.LIBRARY_SELECT_ALL, "Select all" },
    selectFirst = { LocalizationStrings.LIBRARY_SELECT_FIRST, "Select first {count}" }
}

local function useLibraryStrings()
    local var1 = Localization.Hooks.useLocalization(tbl1)
    local var2 = React.useContext(Localization.LocalizationRoactContext)
    local current = table.clone(var1)
    for value, value2 in tbl2 do
        local var4 = value2[1]
        local var5 = value2[2]
        local success, result = pcall(function()
            assert(var2 ~= nil, "Library localization context is unavailable")
            return var2:Format(var4)
        end)
        if success and type(result) == "string" and result ~= "" and result ~= var4 then
            var5 = result
        end

        current[value] = var5
    end

    local var4 = React.useRef(current)
    for value, value2 in current do
        if var4.current[value] ~= value2 then
            var4.current = current
            break
        end
    end

    return var4.current
end

return useLibraryStrings
