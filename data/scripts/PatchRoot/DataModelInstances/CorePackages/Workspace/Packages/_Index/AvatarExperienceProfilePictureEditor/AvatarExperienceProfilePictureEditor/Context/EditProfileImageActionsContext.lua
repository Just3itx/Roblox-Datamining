-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)

local Context = React.createContext(nil)

return {
    Context = Context,
    Provider = Context.Provider,
    useEditProfileImageActions = function()
        local var1 = React.useContext(Context)
        if var1 == nil then
            error("useEditProfileImageActions must be used within an EditProfileImageActions Provider")
        end
        return var1
    end
}
