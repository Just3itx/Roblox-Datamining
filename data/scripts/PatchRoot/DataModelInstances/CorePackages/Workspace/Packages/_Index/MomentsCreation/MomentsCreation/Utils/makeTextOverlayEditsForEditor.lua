-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Dash = require(MomentsCreationParent.Dash)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local function makeTextOverlayEditsForEditor(tbl1, arg1, num1: number)
    local num2 = if num1 > 0 then num1 else 1

    if not tbl1 or #tbl1 == 0 then
        return { Dash.joinDeep(arg1, { scale = 1 / num2 }) }
    end

    return Dash.map(tbl1, function(arg2)
        local var1 = arg2.scale * num2

        return Dash.joinDeep(arg2, { scale = 1 / num2, textOverlayStyle = { fontSize = arg2.textOverlayStyle.fontSize * var1 } })
    end)
end

return makeTextOverlayEditsForEditor
