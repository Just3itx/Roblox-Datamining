-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local FFlagAXPPEReturnToEntrySurface = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagAXPPEReturnToEntrySurface
local entrySurface = require(script.Parent.entrySurface)

local function closeProfilePictureEditor(arg1)
    if not arg1 then
        return
    end

    local var1, var2 = entrySurface.resolve(arg1)
    if var1 and arg1.navigate then
        if FFlagAXPPEReturnToEntrySurface then
            entrySurface.park(arg1, var1)
        end

        if var2 then
            arg1.navigate(var1, var2)
            return
        end
        arg1.navigate(var1)
    elseif arg1.goBack then
        arg1.goBack()
    elseif arg1.pop then
        arg1.pop()
    end
end

return closeProfilePictureEditor
