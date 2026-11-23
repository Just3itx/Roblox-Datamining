-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local _LibraryTypes = require(script.Parent.LibraryTypes)

return {
    fromItems = function(tbl1, arg1)
        local items = {}
        for _, value in { "Model", "Image", "Sound" } do
            for _, value2 in tbl1 do
                if value2.kind ~= value then
                    continue
                end

                table.insert(items, {
                    key = if value == "Model" then "Models" elseif value == "Image" then "Images" else "Sounds",
                    title = if value == "Model" then arg1.model elseif value == "Image" then arg1.image else arg1.sound,
                    itemKind = value2.kind
                })
                break
            end
        end

        return items
    end
}
