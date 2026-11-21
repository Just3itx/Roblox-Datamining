-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Dash = require(scriptParentParentParent.Dash)

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local _Types = require(scriptParentParent.Types)

local tbl1 = {
    {
        contentId = "rbxasset://textures/AvatarEditorImages/AvatarEditor.png",
        filePath = "c://some/path/to/2231221_1818_1234598400000.png",
        type = CaptureType.Screenshot
    },
    {
        contentId = "rbxasset://textures/AvatarEditorImages/AvatarEditor_LightTheme.png",
        filePath = "c://some/path/to/2231221_14375697_1653030000000.png",
        type = CaptureType.Screenshot
    }
}
local tbl2 = {
    {
        CaptureType = Enum.CaptureType.Screenshot,
        SourceUniverseId = 1,
        SourcePlaceId = 1,
        LocalId = "123",
        CaptureTime = DateTime.fromUnixTimestampMillis(1653030000000)
    },
    {
        CaptureType = Enum.CaptureType.Video,
        SourceUniverseId = 2,
        SourcePlaceId = 2,
        LocalId = "321",
        CaptureTime = DateTime.fromUnixTimestampMillis(1653030000000),
        TimeLength = 10
    }
}

return function(num1: number, bool1: boolean?)
    local result = {}
    if bool1 then
        for i = 1, num1 do
            table.insert(result, (Dash.joinDeep(tbl2[i % #tbl2 + 1], {})))
        end

        return result
    end

    for i = 1, num1 do
        local var1 = Dash.joinDeep(tbl1[i % #tbl1 + 1], {})
        local str1 = string.sub(var1.contentId, 21)
        local num2 = i / #tbl1
        var1.contentId = "rbxasset://textures/" .. ("/./"):rep(math.floor(num2)) .. str1
        table.insert(result, var1)
    end

    return result
end
